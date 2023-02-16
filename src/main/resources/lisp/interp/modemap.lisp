
; )package "BOOT"

(IN-PACKAGE "BOOT")

; addDomain(domain,e) ==
;   atom domain =>
;     EQ(domain,"$EmptyMode") => e
;     EQ(domain,"$NoValueMode") => e
;     not IDENTP domain or 2<#(s:= STRINGIMAGE domain) and
;       EQ(char "#",s.(0)) and EQ(char "#",s.(1)) => e
;     MEMQ(domain,getDomainsInScope e) => e
;     isLiteral(domain,e) => e
;     addNewDomain(domain,e)
;   (name:= first domain)='Category => e
;   domainMember(domain,getDomainsInScope e) => e
;   getmode(name, e) is ["Mapping", target, :.] and isCategoryForm(target) =>
;       addNewDomain(domain,e)
;     -- constructor? test needed for domains compiled with $bootStrapMode=true
;   isFunctor name or constructor? name => addNewDomain(domain,e)
;   if not isCategoryForm(domain) and
;     not member(name,'(Mapping CATEGORY)) then
;       unknownTypeError name
;   e        --is not a functor

(DEFUN |addDomain| (|domain| |e|)
  (PROG (|s| |name| |ISTMP#1| |ISTMP#2| |target|)
    (RETURN
     (COND
      ((ATOM |domain|)
       (COND ((EQ |domain| '|$EmptyMode|) |e|)
             ((EQ |domain| '|$NoValueMode|) |e|)
             ((OR (NULL (IDENTP |domain|))
                  (AND (< 2 (LENGTH (SETQ |s| (STRINGIMAGE |domain|))))
                       (EQ (|char| '|#|) (ELT |s| 0))
                       (EQ (|char| '|#|) (ELT |s| 1))))
              |e|)
             ((MEMQ |domain| (|getDomainsInScope| |e|)) |e|)
             ((|isLiteral| |domain| |e|) |e|)
             (#1='T (|addNewDomain| |domain| |e|))))
      ((EQ (SETQ |name| (CAR |domain|)) '|Category|) |e|)
      ((|domainMember| |domain| (|getDomainsInScope| |e|)) |e|)
      ((AND
        (PROGN
         (SETQ |ISTMP#1| (|getmode| |name| |e|))
         (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
              (PROGN
               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
               (AND (CONSP |ISTMP#2|)
                    (PROGN (SETQ |target| (CAR |ISTMP#2|)) #1#)))))
        (|isCategoryForm| |target|))
       (|addNewDomain| |domain| |e|))
      ((OR (|isFunctor| |name|) (|constructor?| |name|))
       (|addNewDomain| |domain| |e|))
      (#1#
       (PROGN
        (COND
         ((AND (NULL (|isCategoryForm| |domain|))
               (NULL (|member| |name| '(|Mapping| CATEGORY))))
          (|unknownTypeError| |name|)))
        |e|))))))

; domainMember(dom,domList) == or/[modeEqual(dom,d) for d in domList]

(DEFUN |domainMember| (|dom| |domList|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#2| |bfVar#1| |d|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|) (PROGN (SETQ |d| (CAR |bfVar#1|)) NIL))
           (RETURN |bfVar#2|))
          ('T
           (PROGN
            (SETQ |bfVar#2| (|modeEqual| |dom| |d|))
            (COND (|bfVar#2| (RETURN |bfVar#2|))))))
         (SETQ |bfVar#1| (CDR |bfVar#1|))))
      NIL |domList| NIL))))

; getModemapList(op,numOfArgs,e) ==
;   op is ['Sel, D, op'] => getModemapListFromDomain(op', numOfArgs, D, e)
;   [mm for
;     (mm:= [[.,.,:sigl],:.]) in get(op,'modemap,e) | numOfArgs=#sigl]

(DEFUN |getModemapList| (|op| |numOfArgs| |e|)
  (PROG (|ISTMP#1| D |ISTMP#2| |op'| |sigl|)
    (RETURN
     (COND
      ((AND (CONSP |op|) (EQ (CAR |op|) '|Sel|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |op|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ D (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |op'| (CAR |ISTMP#2|)) #1='T))))))
       (|getModemapListFromDomain| |op'| |numOfArgs| D |e|))
      (#1#
       ((LAMBDA (|bfVar#4| |bfVar#3| |mm|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#3|) (PROGN (SETQ |mm| (CAR |bfVar#3|)) NIL))
             (RETURN (NREVERSE |bfVar#4|)))
            (#1#
             (AND (CONSP |mm|)
                  (PROGN
                   (SETQ |ISTMP#1| (CAR |mm|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN (SETQ |sigl| (CDR |ISTMP#2|)) #1#)))))
                  (EQL |numOfArgs| (LENGTH |sigl|))
                  (SETQ |bfVar#4| (CONS |mm| |bfVar#4|)))))
           (SETQ |bfVar#3| (CDR |bfVar#3|))))
        NIL (|get| |op| '|modemap| |e|) NIL))))))

; getModemapListFromDomain(op,numOfArgs,D,e) ==
;   [mm
;     for (mm:= [[dc,:sig],:.]) in get(op,'modemap,e) | dc=D and #rest sig=
;       numOfArgs]

(DEFUN |getModemapListFromDomain| (|op| |numOfArgs| D |e|)
  (PROG (|ISTMP#1| |dc| |sig|)
    (RETURN
     ((LAMBDA (|bfVar#6| |bfVar#5| |mm|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#5|) (PROGN (SETQ |mm| (CAR |bfVar#5|)) NIL))
           (RETURN (NREVERSE |bfVar#6|)))
          (#1='T
           (AND (CONSP |mm|)
                (PROGN
                 (SETQ |ISTMP#1| (CAR |mm|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |dc| (CAR |ISTMP#1|))
                       (SETQ |sig| (CDR |ISTMP#1|))
                       #1#)))
                (EQUAL |dc| D) (EQL (LENGTH (CDR |sig|)) |numOfArgs|)
                (SETQ |bfVar#6| (CONS |mm| |bfVar#6|)))))
         (SETQ |bfVar#5| (CDR |bfVar#5|))))
      NIL (|get| |op| '|modemap| |e|) NIL))))

; addModemapKnown(op, mc, sig, pred, fn, e) ==
; --  if knownInfo pred then pred:=true
; --  that line is handled elsewhere
;   $insideCapsuleFunctionIfTrue=true =>
;     $CapsuleModemapFrame :=
;       addModemap0(op,mc,sig,pred,fn,$CapsuleModemapFrame)
;     e
;   addModemap0(op, mc, sig, pred, fn, e)

(DEFUN |addModemapKnown| (|op| |mc| |sig| |pred| |fn| |e|)
  (PROG ()
    (RETURN
     (COND
      ((EQUAL |$insideCapsuleFunctionIfTrue| T)
       (PROGN
        (SETQ |$CapsuleModemapFrame|
                (|addModemap0| |op| |mc| |sig| |pred| |fn|
                 |$CapsuleModemapFrame|))
        |e|))
      ('T (|addModemap0| |op| |mc| |sig| |pred| |fn| |e|))))))

; addModemap0(op,mc,sig,pred,fn,e) ==
;   --mc is the "mode of computation"; fn the "implementation"
;   op = 'elt or op = "setelt!" => addEltModemap(op, mc, sig, pred, fn, e)
;   addModemap1(op,mc,sig,pred,fn,e)

(DEFUN |addModemap0| (|op| |mc| |sig| |pred| |fn| |e|)
  (PROG ()
    (RETURN
     (COND
      ((OR (EQ |op| '|elt|) (EQ |op| '|setelt!|))
       (|addEltModemap| |op| |mc| |sig| |pred| |fn| |e|))
      ('T (|addModemap1| |op| |mc| |sig| |pred| |fn| |e|))))))

; addEltModemap(op,mc,sig,pred,fn,e) ==
;    --hack to change selectors from strings to identifiers; and to
;    --add flag identifiers as literals in the envir
;   op='elt and sig is [:lt,sel] =>
;     STRINGP sel =>
;       id:= INTERN sel
;       e := makeLiteral(id, e)
;       addModemap1(op,mc,[:lt,id],pred,fn,e)
;     -- atom sel => systemErrorHere '"addEltModemap"
;     addModemap1(op,mc,sig,pred,fn,e)
;   op = "setelt!" and sig is [:lt, sel, v] =>
;     STRINGP sel =>
;       id:= INTERN sel
;       e := makeLiteral(id, e)
;       addModemap1(op,mc,[:lt,id,v],pred,fn,e)
;     -- atom sel => systemError '"addEltModemap"
;     addModemap1(op,mc,sig,pred,fn,e)
;   systemErrorHere '"addEltModemap"

(DEFUN |addEltModemap| (|op| |mc| |sig| |pred| |fn| |e|)
  (PROG (|ISTMP#1| |sel| |lt| |id| |v| |ISTMP#2|)
    (RETURN
     (COND
      ((AND (EQ |op| '|elt|) (CONSP |sig|)
            (PROGN (SETQ |ISTMP#1| (REVERSE |sig|)) #1='T) (CONSP |ISTMP#1|)
            (PROGN
             (SETQ |sel| (CAR |ISTMP#1|))
             (SETQ |lt| (CDR |ISTMP#1|))
             #1#)
            (PROGN (SETQ |lt| (NREVERSE |lt|)) #1#))
       (COND
        ((STRINGP |sel|)
         (PROGN
          (SETQ |id| (INTERN |sel|))
          (SETQ |e| (|makeLiteral| |id| |e|))
          (|addModemap1| |op| |mc| (APPEND |lt| (CONS |id| NIL)) |pred| |fn|
           |e|)))
        (#1# (|addModemap1| |op| |mc| |sig| |pred| |fn| |e|))))
      ((AND (EQ |op| '|setelt!|) (CONSP |sig|)
            (PROGN (SETQ |ISTMP#1| (REVERSE |sig|)) #1#) (CONSP |ISTMP#1|)
            (PROGN
             (SETQ |v| (CAR |ISTMP#1|))
             (SETQ |ISTMP#2| (CDR |ISTMP#1|))
             (AND (CONSP |ISTMP#2|)
                  (PROGN
                   (SETQ |sel| (CAR |ISTMP#2|))
                   (SETQ |lt| (CDR |ISTMP#2|))
                   #1#)))
            (PROGN (SETQ |lt| (NREVERSE |lt|)) #1#))
       (COND
        ((STRINGP |sel|)
         (PROGN
          (SETQ |id| (INTERN |sel|))
          (SETQ |e| (|makeLiteral| |id| |e|))
          (|addModemap1| |op| |mc| (APPEND |lt| (CONS |id| (CONS |v| NIL)))
           |pred| |fn| |e|)))
        (#1# (|addModemap1| |op| |mc| |sig| |pred| |fn| |e|))))
      (#1# (|systemErrorHere| "addEltModemap"))))))

; addModemap1(op,mc,sig,pred,fn,e) ==
;    --mc is the "mode of computation"; fn the "implementation"
;   if mc='Rep then
; --     if fn is [kind,'Rep,.] and
;                -- save old sig for NRUNTIME
; --       (kind = 'ELT or kind = 'CONST) then fn:=[kind,'Rep,sig]
;      sig:= substitute("$",'Rep,sig)
;   currentProplist:= getProplist(op,e) or nil
;   newModemapList:=
;     mkNewModemapList(mc,sig,pred,fn,LASSOC('modemap,currentProplist),e,nil)
;   newProplist:= augProplist(currentProplist,'modemap,newModemapList)
;   unErrorRef op
;         --There may have been a warning about op having no value
;   addBinding(op, newProplist, e)

(DEFUN |addModemap1| (|op| |mc| |sig| |pred| |fn| |e|)
  (PROG (|currentProplist| |newModemapList| |newProplist|)
    (RETURN
     (PROGN
      (COND ((EQ |mc| '|Rep|) (SETQ |sig| (|substitute| '$ '|Rep| |sig|))))
      (SETQ |currentProplist| (OR (|getProplist| |op| |e|) NIL))
      (SETQ |newModemapList|
              (|mkNewModemapList| |mc| |sig| |pred| |fn|
               (LASSOC '|modemap| |currentProplist|) |e| NIL))
      (SETQ |newProplist|
              (|augProplist| |currentProplist| '|modemap| |newModemapList|))
      (|unErrorRef| |op|)
      (|addBinding| |op| |newProplist| |e|)))))

; mkNewModemapList(mc,sig,pred,fn,curModemapList,e,filenameOrNil) ==
;   entry:= [map:= [mc,:sig],[pred,fn],:filenameOrNil]
;   member(entry,curModemapList) => curModemapList
;   (oldMap:= assoc(map,curModemapList)) and oldMap is [.,[opred, =fn],:.] =>
;     $forceAdd => mergeModemap(entry,curModemapList,e)
;     opred=true => curModemapList
;     if pred~=true and pred~=opred then pred:= ["OR",pred,opred]
;     [if x=oldMap then [map,[pred,fn],:filenameOrNil] else x
;
;   --if new modemap less general, put at end; otherwise, at front
;       for x in curModemapList]
;   mergeModemap(entry,curModemapList,e)

(DEFUN |mkNewModemapList|
       (|mc| |sig| |pred| |fn| |curModemapList| |e| |filenameOrNil|)
  (PROG (|map| |entry| |oldMap| |ISTMP#1| |ISTMP#2| |opred| |ISTMP#3|)
    (RETURN
     (PROGN
      (SETQ |entry|
              (CONS (SETQ |map| (CONS |mc| |sig|))
                    (CONS (LIST |pred| |fn|) |filenameOrNil|)))
      (COND ((|member| |entry| |curModemapList|) |curModemapList|)
            ((AND (SETQ |oldMap| (|assoc| |map| |curModemapList|))
                  (CONSP |oldMap|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR |oldMap|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN
                               (SETQ |opred| (CAR |ISTMP#2|))
                               (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                               (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                    (EQUAL (CAR |ISTMP#3|) |fn|))))))))
             (COND (|$forceAdd| (|mergeModemap| |entry| |curModemapList| |e|))
                   ((EQUAL |opred| T) |curModemapList|)
                   (#1='T
                    (PROGN
                     (COND
                      ((AND (NOT (EQUAL |pred| T))
                            (NOT (EQUAL |pred| |opred|)))
                       (SETQ |pred| (LIST 'OR |pred| |opred|))))
                     ((LAMBDA (|bfVar#8| |bfVar#7| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#7|)
                               (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
                           (RETURN (NREVERSE |bfVar#8|)))
                          (#1#
                           (SETQ |bfVar#8|
                                   (CONS
                                    (COND
                                     ((EQUAL |x| |oldMap|)
                                      (CONS |map|
                                            (CONS (LIST |pred| |fn|)
                                                  |filenameOrNil|)))
                                     (#1# |x|))
                                    |bfVar#8|))))
                         (SETQ |bfVar#7| (CDR |bfVar#7|))))
                      NIL |curModemapList| NIL)))))
            (#1# (|mergeModemap| |entry| |curModemapList| |e|)))))))

; mergeModemap(entry is [[mc,:sig],[pred,:.],:.],modemapList,e) ==
;   for (mmtail:= [[[mc',:sig'],[pred',:.],:.],:.]) in tails modemapList repeat
;     mc=mc' or isSuperDomain(mc',mc,e) =>
;       newmm:= nil
;       mm:= modemapList
;       while (not EQ(mm,mmtail)) repeat (newmm:= [first mm,:newmm]; mm:= rest mm)
;       if (mc=mc') and (sig=sig') then
;         --We only need one of these, unless the conditions are hairy
;         not $forceAdd and TruthP pred' =>
;           entry:=nil
;               --the new predicate buys us nothing
;           return modemapList
;         TruthP pred => mmtail:=rest mmtail
;           --the thing we matched against is useless, by comparison
;       modemapList:= NCONC(NREVERSE newmm,[entry,:mmtail])
;       entry:= nil
;       return modemapList
;   if entry then [:modemapList,entry] else modemapList

(DEFUN |mergeModemap| (|entry| |modemapList| |e|)
  (PROG (|mc| |sig| |pred| |ISTMP#1| |ISTMP#2| |mc'| |sig'| |ISTMP#3| |ISTMP#4|
         |pred'| |newmm| |mm|)
    (RETURN
     (PROGN
      (SETQ |mc| (CAAR . #1=(|entry|)))
      (SETQ |sig| (CDAR . #1#))
      (SETQ |pred| (CAADR |entry|))
      ((LAMBDA (|mmtail|)
         (LOOP
          (COND ((ATOM |mmtail|) (RETURN NIL))
                (#2='T
                 (AND (CONSP |mmtail|)
                      (PROGN
                       (SETQ |ISTMP#1| (CAR |mmtail|))
                       (AND (CONSP |ISTMP#1|)
                            (PROGN
                             (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                             (AND (CONSP |ISTMP#2|)
                                  (PROGN
                                   (SETQ |mc'| (CAR |ISTMP#2|))
                                   (SETQ |sig'| (CDR |ISTMP#2|))
                                   #2#)))
                            (PROGN
                             (SETQ |ISTMP#3| (CDR |ISTMP#1|))
                             (AND (CONSP |ISTMP#3|)
                                  (PROGN
                                   (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                                   (AND (CONSP |ISTMP#4|)
                                        (PROGN
                                         (SETQ |pred'| (CAR |ISTMP#4|))
                                         #2#)))))))
                      (COND
                       ((OR (EQUAL |mc| |mc'|)
                            (|isSuperDomain| |mc'| |mc| |e|))
                        (IDENTITY
                         (PROGN
                          (SETQ |newmm| NIL)
                          (SETQ |mm| |modemapList|)
                          ((LAMBDA ()
                             (LOOP
                              (COND ((EQ |mm| |mmtail|) (RETURN NIL))
                                    (#2#
                                     (PROGN
                                      (SETQ |newmm| (CONS (CAR |mm|) |newmm|))
                                      (SETQ |mm| (CDR |mm|))))))))
                          (COND
                           ((AND (EQUAL |mc| |mc'|) (EQUAL |sig| |sig'|))
                            (COND
                             ((AND (NULL |$forceAdd|) (|TruthP| |pred'|))
                              (PROGN
                               (SETQ |entry| NIL)
                               (RETURN |modemapList|)))
                             ((|TruthP| |pred|)
                              (SETQ |mmtail| (CDR |mmtail|))))))
                          (SETQ |modemapList|
                                  (NCONC (NREVERSE |newmm|)
                                         (CONS |entry| |mmtail|)))
                          (SETQ |entry| NIL)
                          (RETURN |modemapList|))))))))
          (SETQ |mmtail| (CDR |mmtail|))))
       |modemapList|)
      (COND (|entry| (APPEND |modemapList| (CONS |entry| NIL)))
            (#2# |modemapList|))))))

; isSuperDomain(domainForm,domainForm',e) ==
;   isSubset(domainForm',domainForm,e) => true
;   domainForm='Rep and domainForm'="$" => true --regard $ as a subdomain of Rep
;   LASSOC(opOf domainForm',get(domainForm,"SubDomain",e))

(DEFUN |isSuperDomain| (|domainForm| |domainForm'| |e|)
  (PROG ()
    (RETURN
     (COND ((|isSubset| |domainForm'| |domainForm| |e|) T)
           ((AND (EQ |domainForm| '|Rep|) (EQ |domainForm'| '$)) T)
           ('T
            (LASSOC (|opOf| |domainForm'|)
             (|get| |domainForm| '|SubDomain| |e|)))))))

; addNewDomain(domain,e) ==
;   augModemapsFromDomain(domain,domain,e)

(DEFUN |addNewDomain| (|domain| |e|)
  (PROG () (RETURN (|augModemapsFromDomain| |domain| |domain| |e|))))

; augModemapsFromDomain(name,functorForm,e) ==
;   member(IFCAR name or name, $DummyFunctorNames) => e
;   name = $Category or isCategoryForm(name) => e
;   member(name, getDomainsInScope e) => e
;   if u:= GETDATABASE(opOf functorForm,'SUPERDOMAIN) then
;     e:= addNewDomain(first u,e)
;     --need code to handle parameterized SuperDomains
;   if innerDom:= listOrVectorElementMode name then e:= addDomain(innerDom,e)
;   if name is ["Union",:dl] then for d in stripUnionTags dl
;                          repeat e:= addDomain(d,e)
;   augModemapsFromDomain1(name,functorForm,e)

(DEFUN |augModemapsFromDomain| (|name| |functorForm| |e|)
  (PROG (|u| |innerDom| |dl|)
    (RETURN
     (COND ((|member| (OR (IFCAR |name|) |name|) |$DummyFunctorNames|) |e|)
           ((OR (EQUAL |name| |$Category|) (|isCategoryForm| |name|)) |e|)
           ((|member| |name| (|getDomainsInScope| |e|)) |e|)
           (#1='T
            (PROGN
             (COND
              ((SETQ |u| (GETDATABASE (|opOf| |functorForm|) 'SUPERDOMAIN))
               (SETQ |e| (|addNewDomain| (CAR |u|) |e|))))
             (COND
              ((SETQ |innerDom| (|listOrVectorElementMode| |name|))
               (SETQ |e| (|addDomain| |innerDom| |e|))))
             (COND
              ((AND (CONSP |name|) (EQ (CAR |name|) '|Union|)
                    (PROGN (SETQ |dl| (CDR |name|)) #1#))
               ((LAMBDA (|bfVar#9| |d|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#9|)
                         (PROGN (SETQ |d| (CAR |bfVar#9|)) NIL))
                     (RETURN NIL))
                    (#1# (SETQ |e| (|addDomain| |d| |e|))))
                   (SETQ |bfVar#9| (CDR |bfVar#9|))))
                (|stripUnionTags| |dl|) NIL)))
             (|augModemapsFromDomain1| |name| |functorForm| |e|)))))))

; substituteCategoryArguments(argl,catform) ==
;   argl:= substitute("$$","$",argl)
;   arglAssoc := [[INTERNL1("#", STRINGIMAGE i), :a] for i in 1.. for a in argl]
;   SUBLIS(arglAssoc,catform)

(DEFUN |substituteCategoryArguments| (|argl| |catform|)
  (PROG (|arglAssoc|)
    (RETURN
     (PROGN
      (SETQ |argl| (|substitute| '$$ '$ |argl|))
      (SETQ |arglAssoc|
              ((LAMBDA (|bfVar#11| |i| |bfVar#10| |a|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#10|)
                        (PROGN (SETQ |a| (CAR |bfVar#10|)) NIL))
                    (RETURN (NREVERSE |bfVar#11|)))
                   ('T
                    (SETQ |bfVar#11|
                            (CONS (CONS (INTERNL1 '|#| (STRINGIMAGE |i|)) |a|)
                                  |bfVar#11|))))
                  (SETQ |i| (+ |i| 1))
                  (SETQ |bfVar#10| (CDR |bfVar#10|))))
               NIL 1 |argl| NIL))
      (SUBLIS |arglAssoc| |catform|)))))

; augModemapsFromCategory(domainName, functorForm, categoryForm, e) ==
;   [fnAlist,e]:= evalAndSub(domainName, functorForm, categoryForm, e)
;   compilerMessage ["Adding ",domainName," modemaps"]
;   e:= putDomainsInScope(domainName,e)
;   for [[op,sig,:.],cond,fnsel] in fnAlist repeat
;       e:= addModemapKnown(op,domainName,sig,cond,fnsel,e)
;   e

(DEFUN |augModemapsFromCategory|
       (|domainName| |functorForm| |categoryForm| |e|)
  (PROG (|LETTMP#1| |fnAlist| |ISTMP#1| |op| |ISTMP#2| |sig| |ISTMP#3| |cond|
         |ISTMP#4| |fnsel|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1|
              (|evalAndSub| |domainName| |functorForm| |categoryForm| |e|))
      (SETQ |fnAlist| (CAR |LETTMP#1|))
      (SETQ |e| (CADR |LETTMP#1|))
      (|compilerMessage| (LIST '|Adding | |domainName| '| modemaps|))
      (SETQ |e| (|putDomainsInScope| |domainName| |e|))
      ((LAMBDA (|bfVar#13| |bfVar#12|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#13|)
                (PROGN (SETQ |bfVar#12| (CAR |bfVar#13|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#12|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |bfVar#12|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |op| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1#)))))
                 (PROGN
                  (SETQ |ISTMP#3| (CDR |bfVar#12|))
                  (AND (CONSP |ISTMP#3|)
                       (PROGN
                        (SETQ |cond| (CAR |ISTMP#3|))
                        (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                        (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                             (PROGN (SETQ |fnsel| (CAR |ISTMP#4|)) #1#)))))
                 (SETQ |e|
                         (|addModemapKnown| |op| |domainName| |sig| |cond|
                          |fnsel| |e|)))))
          (SETQ |bfVar#13| (CDR |bfVar#13|))))
       |fnAlist| NIL)
      |e|))))

; evalAndSub(domainName, functorForm, form, e) ==
;   $tmp_e : local := e
;   --next lines necessary-- see MPOLY for which $ is actual arg. --- RDJ 3/83
;   if CONTAINED("$$",form) then
;       e := put("$$", "mode", get("$", "mode", e), e)
;   $tmp_e : local := e
;   opAlist:= getOperationAlist(domainName,functorForm,form)
;   substAlist:= substNames(domainName, functorForm, opAlist)
;   [substAlist, $tmp_e]

(DEFUN |evalAndSub| (|domainName| |functorForm| |form| |e|)
  (PROG (|$tmp_e| |substAlist| |opAlist|)
    (DECLARE (SPECIAL |$tmp_e|))
    (RETURN
     (PROGN
      (SETQ |$tmp_e| |e|)
      (COND
       ((CONTAINED '$$ |form|)
        (SETQ |e| (|put| '$$ '|mode| (|get| '$ '|mode| |e|) |e|))))
      (SETQ |$tmp_e| |e|)
      (SETQ |opAlist| (|getOperationAlist| |domainName| |functorForm| |form|))
      (SETQ |substAlist| (|substNames| |domainName| |functorForm| |opAlist|))
      (LIST |substAlist| |$tmp_e|)))))

; getOperationAlist(name,functorForm,form) ==
;   if atom name and GETDATABASE(name,'NILADIC) then functorForm:= [functorForm]
;   (u:= isFunctor functorForm) and not
;     ($insideFunctorIfTrue and first functorForm=first $functorForm) => u
;   $insideFunctorIfTrue and name="$" =>
;     ($domainShell => $domainShell.(1); systemError '"$ has no shell now")
;   T := compMakeCategoryObject(form, $tmp_e) =>
;       ([., ., $tmp_e] := T; T.expr.(1))
;   stackMessage ["not a category form: ",form]

(DEFUN |getOperationAlist| (|name| |functorForm| |form|)
  (PROG (|u| T$)
    (RETURN
     (PROGN
      (COND
       ((AND (ATOM |name|) (GETDATABASE |name| 'NILADIC))
        (SETQ |functorForm| (LIST |functorForm|))))
      (COND
       ((AND (SETQ |u| (|isFunctor| |functorForm|))
             (NULL
              (AND |$insideFunctorIfTrue|
                   (EQUAL (CAR |functorForm|) (CAR |$functorForm|)))))
        |u|)
       ((AND |$insideFunctorIfTrue| (EQ |name| '$))
        (COND (|$domainShell| (ELT |$domainShell| 1))
              (#1='T (|systemError| "$ has no shell now"))))
       ((SETQ T$ (|compMakeCategoryObject| |form| |$tmp_e|))
        (PROGN (SETQ |$tmp_e| (CADDR T$)) (ELT (CAR T$) 1)))
       (#1# (|stackMessage| (LIST '|not a category form: | |form|))))))))

; substNames(domainName, functorForm, opalist) ==
;   functorForm := SUBSTQ("$$","$", functorForm)
;   nameForDollar :=
;     isCategoryPackageName functorForm => CADR functorForm
;     domainName
;
;        -- following calls to SUBSTQ must copy to save RPLAC's in
;        -- putInLocalDomainReferences
;   [[:SUBSTQ("$","$$",SUBSTQ(nameForDollar,"$",modemapform)),
;        [sel, domainName, if domainName = "$" then pos else
;                                          CADAR modemapform]]
;      for [:modemapform,[sel,"$",pos]] in
;           EQSUBSTLIST(IFCDR functorForm, $FormalMapVariableList, opalist)]

(DEFUN |substNames| (|domainName| |functorForm| |opalist|)
  (PROG (|nameForDollar| |ISTMP#1| |ISTMP#2| |sel| |ISTMP#3| |ISTMP#4| |pos|
         |modemapform|)
    (RETURN
     (PROGN
      (SETQ |functorForm| (SUBSTQ '$$ '$ |functorForm|))
      (SETQ |nameForDollar|
              (COND
               ((|isCategoryPackageName| |functorForm|) (CADR |functorForm|))
               (#1='T |domainName|)))
      ((LAMBDA (|bfVar#16| |bfVar#15| |bfVar#14|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#15|)
                (PROGN (SETQ |bfVar#14| (CAR |bfVar#15|)) NIL))
            (RETURN (NREVERSE |bfVar#16|)))
           (#1#
            (AND (CONSP |bfVar#14|)
                 (PROGN (SETQ |ISTMP#1| (REVERSE |bfVar#14|)) #1#)
                 (CONSP |ISTMP#1|)
                 (PROGN
                  (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                  (AND (CONSP |ISTMP#2|)
                       (PROGN
                        (SETQ |sel| (CAR |ISTMP#2|))
                        (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                        (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) '$)
                             (PROGN
                              (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                              (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                   (PROGN
                                    (SETQ |pos| (CAR |ISTMP#4|))
                                    #1#)))))))
                 (PROGN (SETQ |modemapform| (CDR |ISTMP#1|)) #1#)
                 (PROGN (SETQ |modemapform| (NREVERSE |modemapform|)) #1#)
                 (SETQ |bfVar#16|
                         (CONS
                          (APPEND
                           (SUBSTQ '$ '$$
                            (SUBSTQ |nameForDollar| '$ |modemapform|))
                           (CONS
                            (LIST |sel| |domainName|
                                  (COND ((EQ |domainName| '$) |pos|)
                                        (#1# (CADAR |modemapform|))))
                            NIL))
                          |bfVar#16|)))))
          (SETQ |bfVar#15| (CDR |bfVar#15|))))
       NIL
       (EQSUBSTLIST (IFCDR |functorForm|) |$FormalMapVariableList| |opalist|)
       NIL)))))

; compCat(form is [functorName,:argl],m,e) ==
;   fn := get_oplist_maker(functorName) or return nil
;   [funList,e]:= FUNCALL(fn,form,form,e)
;   catForm:=
;     ["Join",'(SetCategory),["CATEGORY","domain",:
;       [["SIGNATURE",op,sig] for [op,sig,.] in funList | op~="="]]]
;   --RDJ: for coercion purposes, it necessary to know it's a Set; I'm not
;   --sure if it uses any of the other signatures(see extendsCategoryForm)
;   [form,catForm,e]

(DEFUN |compCat| (|form| |m| |e|)
  (PROG (|functorName| |argl| |fn| |LETTMP#1| |funList| |op| |ISTMP#1| |sig|
         |ISTMP#2| |catForm|)
    (RETURN
     (PROGN
      (SETQ |functorName| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |fn| (OR (|get_oplist_maker| |functorName|) (RETURN NIL)))
      (SETQ |LETTMP#1| (FUNCALL |fn| |form| |form| |e|))
      (SETQ |funList| (CAR |LETTMP#1|))
      (SETQ |e| (CADR |LETTMP#1|))
      (SETQ |catForm|
              (LIST '|Join| '(|SetCategory|)
                    (CONS 'CATEGORY
                          (CONS '|domain|
                                ((LAMBDA (|bfVar#19| |bfVar#18| |bfVar#17|)
                                   (LOOP
                                    (COND
                                     ((OR (ATOM |bfVar#18|)
                                          (PROGN
                                           (SETQ |bfVar#17| (CAR |bfVar#18|))
                                           NIL))
                                      (RETURN (NREVERSE |bfVar#19|)))
                                     ('T
                                      (AND (CONSP |bfVar#17|)
                                           (PROGN
                                            (SETQ |op| (CAR |bfVar#17|))
                                            (SETQ |ISTMP#1| (CDR |bfVar#17|))
                                            (AND (CONSP |ISTMP#1|)
                                                 (PROGN
                                                  (SETQ |sig| (CAR |ISTMP#1|))
                                                  (SETQ |ISTMP#2|
                                                          (CDR |ISTMP#1|))
                                                  (AND (CONSP |ISTMP#2|)
                                                       (EQ (CDR |ISTMP#2|)
                                                           NIL)))))
                                           (NOT (EQ |op| '=))
                                           (SETQ |bfVar#19|
                                                   (CONS
                                                    (LIST 'SIGNATURE |op|
                                                          |sig|)
                                                    |bfVar#19|)))))
                                    (SETQ |bfVar#18| (CDR |bfVar#18|))))
                                 NIL |funList| NIL)))))
      (LIST |form| |catForm| |e|)))))

; addModemap(op, mc, sig, pred, fn, e) ==
;     $InteractiveMode => e
;     if known_info_in_env(pred, e) then pred := true
;     $insideCapsuleFunctionIfTrue = true =>
;         $CapsuleModemapFrame :=
;           addModemap0(op, mc, sig, pred, fn, $CapsuleModemapFrame)
;         e
;     addModemap0(op, mc, sig, pred, fn, e)

(DEFUN |addModemap| (|op| |mc| |sig| |pred| |fn| |e|)
  (PROG ()
    (RETURN
     (COND (|$InteractiveMode| |e|)
           (#1='T
            (PROGN
             (COND ((|known_info_in_env| |pred| |e|) (SETQ |pred| T)))
             (COND
              ((EQUAL |$insideCapsuleFunctionIfTrue| T)
               (PROGN
                (SETQ |$CapsuleModemapFrame|
                        (|addModemap0| |op| |mc| |sig| |pred| |fn|
                         |$CapsuleModemapFrame|))
                |e|))
              (#1# (|addModemap0| |op| |mc| |sig| |pred| |fn| |e|)))))))))

; add_builtin_modemaps(name,form is [functorName,:.],e) ==
;   $InteractiveMode => BREAK()
;   e:= putDomainsInScope(name,e) --frame
;   fn := get_oplist_maker(functorName)
;   [funList,e]:= FUNCALL(fn,name,form,e)
;   for [op,sig,opcode] in funList repeat
;     if opcode is [sel,dc,n] and sel='ELT then
;           nsig := substitute("$$$",name,sig)
;           nsig := substitute('$,"$$$",substitute("$$",'$,nsig))
;           opcode := [sel,dc,nsig]
;     e:= addModemap(op,name,sig,true,opcode,e)
;   e

(DEFUN |add_builtin_modemaps| (|name| |form| |e|)
  (PROG (|functorName| |fn| |LETTMP#1| |funList| |op| |ISTMP#1| |sig| |ISTMP#2|
         |opcode| |sel| |dc| |n| |nsig|)
    (RETURN
     (PROGN
      (SETQ |functorName| (CAR |form|))
      (COND (|$InteractiveMode| (BREAK))
            (#1='T
             (PROGN
              (SETQ |e| (|putDomainsInScope| |name| |e|))
              (SETQ |fn| (|get_oplist_maker| |functorName|))
              (SETQ |LETTMP#1| (FUNCALL |fn| |name| |form| |e|))
              (SETQ |funList| (CAR |LETTMP#1|))
              (SETQ |e| (CADR |LETTMP#1|))
              ((LAMBDA (|bfVar#21| |bfVar#20|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#21|)
                        (PROGN (SETQ |bfVar#20| (CAR |bfVar#21|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (AND (CONSP |bfVar#20|)
                         (PROGN
                          (SETQ |op| (CAR |bfVar#20|))
                          (SETQ |ISTMP#1| (CDR |bfVar#20|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |sig| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |opcode| (CAR |ISTMP#2|))
                                      #1#)))))
                         (PROGN
                          (COND
                           ((AND (CONSP |opcode|)
                                 (PROGN
                                  (SETQ |sel| (CAR |opcode|))
                                  (SETQ |ISTMP#1| (CDR |opcode|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |dc| (CAR |ISTMP#1|))
                                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                        (AND (CONSP |ISTMP#2|)
                                             (EQ (CDR |ISTMP#2|) NIL)
                                             (PROGN
                                              (SETQ |n| (CAR |ISTMP#2|))
                                              #1#)))))
                                 (EQ |sel| 'ELT))
                            (SETQ |nsig| (|substitute| '$$$ |name| |sig|))
                            (SETQ |nsig|
                                    (|substitute| '$ '$$$
                                     (|substitute| '$$ '$ |nsig|)))
                            (SETQ |opcode| (LIST |sel| |dc| |nsig|))))
                          (SETQ |e|
                                  (|addModemap| |op| |name| |sig| T |opcode|
                                   |e|))))))
                  (SETQ |bfVar#21| (CDR |bfVar#21|))))
               |funList| NIL)
              |e|)))))))

; getDomainsInScope e ==
;   $insideCapsuleFunctionIfTrue=true => $CapsuleDomainsInScope
;   get("$DomainsInScope","special",e)

(DEFUN |getDomainsInScope| (|e|)
  (PROG ()
    (RETURN
     (COND ((EQUAL |$insideCapsuleFunctionIfTrue| T) |$CapsuleDomainsInScope|)
           ('T (|get| '|$DomainsInScope| '|special| |e|))))))

; putDomainsInScope(x,e) ==
;   l:= getDomainsInScope e
;   if member(x,l) then SAY("****** Domain: ",x," already in scope")
;   newValue:= [x,:delete(x,l)]
;   $insideCapsuleFunctionIfTrue => ($CapsuleDomainsInScope:= newValue; e)
;   put("$DomainsInScope","special",newValue,e)

(DEFUN |putDomainsInScope| (|x| |e|)
  (PROG (|l| |newValue|)
    (RETURN
     (PROGN
      (SETQ |l| (|getDomainsInScope| |e|))
      (COND
       ((|member| |x| |l|) (SAY '|****** Domain: | |x| '| already in scope|)))
      (SETQ |newValue| (CONS |x| (|delete| |x| |l|)))
      (COND
       (|$insideCapsuleFunctionIfTrue|
        (PROGN (SETQ |$CapsuleDomainsInScope| |newValue|) |e|))
       ('T (|put| '|$DomainsInScope| '|special| |newValue| |e|)))))))

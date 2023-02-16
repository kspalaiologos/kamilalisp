
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($getUnexposedOperations, true)

(DEFPARAMETER |$getUnexposedOperations| T)

; augLisplibModemapsFromCategory(form is [op,:argl], body, signature,
;                                domainShell) ==
;   sl := [["$",:"*1"],:[[a,:p] for a in argl
;     for p in rest $PatternVariableList]]
;   form:= SUBLIS(sl,form)
;   body:= SUBLIS(sl,body)
;   signature:= SUBLIS(sl,signature)
;   opAlist:= SUBLIS(sl, domainShell.(1)) or return nil
;   nonCategorySigAlist:=
;     mkAlistOfExplicitCategoryOps substitute("*1","$",body)
;   domainList:=
;     [[a,m] for a in rest form for m in rest signature |
;       isCategoryForm(m)]
;   catPredList:= [['ofCategory,:u] for u in [["*1",form],:domainList]]
;   for (entry:= [[op,sig,:.],pred,sel]) in opAlist |
;     member(sig,LASSOC(op,nonCategorySigAlist)) repeat
;       pred':= MKPF([pred,:catPredList],'AND)
;       modemap:= [["*1",:sig],[pred',sel]]
;       $lisplibModemapAlist:=
;         [[op,:interactiveModemapForm modemap],:$lisplibModemapAlist]

(DEFUN |augLisplibModemapsFromCategory|
       (|form| |body| |signature| |domainShell|)
  (PROG (|op| |argl| |sl| |opAlist| |nonCategorySigAlist| |domainList|
         |catPredList| |ISTMP#1| |ISTMP#2| |sig| |ISTMP#3| |pred| |ISTMP#4|
         |sel| |pred'| |modemap|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |sl|
              (CONS (CONS '$ '*1)
                    ((LAMBDA (|bfVar#3| |bfVar#1| |a| |bfVar#2| |p|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#1|)
                              (PROGN (SETQ |a| (CAR |bfVar#1|)) NIL)
                              (ATOM |bfVar#2|)
                              (PROGN (SETQ |p| (CAR |bfVar#2|)) NIL))
                          (RETURN (NREVERSE |bfVar#3|)))
                         (#1='T
                          (SETQ |bfVar#3| (CONS (CONS |a| |p|) |bfVar#3|))))
                        (SETQ |bfVar#1| (CDR |bfVar#1|))
                        (SETQ |bfVar#2| (CDR |bfVar#2|))))
                     NIL |argl| NIL (CDR |$PatternVariableList|) NIL)))
      (SETQ |form| (SUBLIS |sl| |form|))
      (SETQ |body| (SUBLIS |sl| |body|))
      (SETQ |signature| (SUBLIS |sl| |signature|))
      (SETQ |opAlist| (OR (SUBLIS |sl| (ELT |domainShell| 1)) (RETURN NIL)))
      (SETQ |nonCategorySigAlist|
              (|mkAlistOfExplicitCategoryOps| (|substitute| '*1 '$ |body|)))
      (SETQ |domainList|
              ((LAMBDA (|bfVar#6| |bfVar#4| |a| |bfVar#5| |m|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#4|) (PROGN (SETQ |a| (CAR |bfVar#4|)) NIL)
                        (ATOM |bfVar#5|)
                        (PROGN (SETQ |m| (CAR |bfVar#5|)) NIL))
                    (RETURN (NREVERSE |bfVar#6|)))
                   (#1#
                    (AND (|isCategoryForm| |m|)
                         (SETQ |bfVar#6| (CONS (LIST |a| |m|) |bfVar#6|)))))
                  (SETQ |bfVar#4| (CDR |bfVar#4|))
                  (SETQ |bfVar#5| (CDR |bfVar#5|))))
               NIL (CDR |form|) NIL (CDR |signature|) NIL))
      (SETQ |catPredList|
              ((LAMBDA (|bfVar#8| |bfVar#7| |u|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#7|)
                        (PROGN (SETQ |u| (CAR |bfVar#7|)) NIL))
                    (RETURN (NREVERSE |bfVar#8|)))
                   (#1#
                    (SETQ |bfVar#8|
                            (CONS (CONS '|ofCategory| |u|) |bfVar#8|))))
                  (SETQ |bfVar#7| (CDR |bfVar#7|))))
               NIL (CONS (LIST '*1 |form|) |domainList|) NIL))
      ((LAMBDA (|bfVar#9| |entry|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#9|) (PROGN (SETQ |entry| (CAR |bfVar#9|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |entry|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |entry|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |op| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1#)))))
                 (PROGN
                  (SETQ |ISTMP#3| (CDR |entry|))
                  (AND (CONSP |ISTMP#3|)
                       (PROGN
                        (SETQ |pred| (CAR |ISTMP#3|))
                        (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                        (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                             (PROGN (SETQ |sel| (CAR |ISTMP#4|)) #1#)))))
                 (|member| |sig| (LASSOC |op| |nonCategorySigAlist|))
                 (PROGN
                  (SETQ |pred'| (MKPF (CONS |pred| |catPredList|) 'AND))
                  (SETQ |modemap| (LIST (CONS '*1 |sig|) (LIST |pred'| |sel|)))
                  (SETQ |$lisplibModemapAlist|
                          (CONS
                           (CONS |op| (|interactiveModemapForm| |modemap|))
                           |$lisplibModemapAlist|))))))
          (SETQ |bfVar#9| (CDR |bfVar#9|))))
       |opAlist| NIL)))))

; augmentLisplibModemapsFromFunctor(form,opAlist,signature) ==
;   form:= [formOp,:argl]:= formal2Pattern form
;   opAlist:= formal2Pattern opAlist
;   signature:= formal2Pattern signature
;   nonCategorySigAlist:=
;     mkAlistOfExplicitCategoryOps first signature or return nil
;   for (entry:= [[op,sig,:.],pred,sel]) in opAlist |
;     or/[(sig in catSig) for catSig in
;       allLASSOCs(op,nonCategorySigAlist)] repeat
;         skip:=
;           argl and CONTAINED("$",rest sig) => 'SKIP
;           nil
;         sel:= substitute(form,"$",sel)
;         patternList:= listOfPatternIds sig
;         --get relevant predicates
;         predList:=
;           [[a,m] for a in argl for m in rest signature
;             | MEMQ(a,$PatternVariableList)]
;         sig:= substitute(form,"$",sig)
;         pred':= MKPF([pred,:[mkDatabasePred y for y in predList]],'AND)
;         l:=listOfPatternIds predList
;         if "OR"/[null MEMQ(u,l) for u in argl] then
;           sayMSG ['"cannot handle modemap for",:bright op,
;                           '"by pattern match" ]
;           skip:= 'SKIP
;         modemap:= [[form,:sig],[pred',sel,:skip]]
;         $lisplibModemapAlist:= [[op,:interactiveModemapForm modemap],
;           :$lisplibModemapAlist]

(DEFUN |augmentLisplibModemapsFromFunctor| (|form| |opAlist| |signature|)
  (PROG (|LETTMP#1| |formOp| |argl| |nonCategorySigAlist| |ISTMP#1| |op|
         |ISTMP#2| |sig| |ISTMP#3| |pred| |ISTMP#4| |sel| |skip| |patternList|
         |predList| |pred'| |l| |modemap|)
    (RETURN
     (PROGN
      (SETQ |form|
              (PROGN
               (SETQ |LETTMP#1| (|formal2Pattern| |form|))
               (SETQ |formOp| (CAR |LETTMP#1|))
               (SETQ |argl| (CDR |LETTMP#1|))
               |LETTMP#1|))
      (SETQ |opAlist| (|formal2Pattern| |opAlist|))
      (SETQ |signature| (|formal2Pattern| |signature|))
      (SETQ |nonCategorySigAlist|
              (OR (|mkAlistOfExplicitCategoryOps| (CAR |signature|))
                  (RETURN NIL)))
      ((LAMBDA (|bfVar#10| |entry|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#10|) (PROGN (SETQ |entry| (CAR |bfVar#10|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |entry|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |entry|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |op| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1#)))))
                 (PROGN
                  (SETQ |ISTMP#3| (CDR |entry|))
                  (AND (CONSP |ISTMP#3|)
                       (PROGN
                        (SETQ |pred| (CAR |ISTMP#3|))
                        (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                        (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                             (PROGN (SETQ |sel| (CAR |ISTMP#4|)) #1#)))))
                 ((LAMBDA (|bfVar#12| |bfVar#11| |catSig|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#11|)
                           (PROGN (SETQ |catSig| (CAR |bfVar#11|)) NIL))
                       (RETURN |bfVar#12|))
                      (#1#
                       (PROGN
                        (SETQ |bfVar#12| (|member| |sig| |catSig|))
                        (COND (|bfVar#12| (RETURN |bfVar#12|))))))
                     (SETQ |bfVar#11| (CDR |bfVar#11|))))
                  NIL (|allLASSOCs| |op| |nonCategorySigAlist|) NIL)
                 (PROGN
                  (SETQ |skip|
                          (COND ((AND |argl| (CONTAINED '$ (CDR |sig|))) 'SKIP)
                                (#1# NIL)))
                  (SETQ |sel| (|substitute| |form| '$ |sel|))
                  (SETQ |patternList| (|listOfPatternIds| |sig|))
                  (SETQ |predList|
                          ((LAMBDA (|bfVar#15| |bfVar#13| |a| |bfVar#14| |m|)
                             (LOOP
                              (COND
                               ((OR (ATOM |bfVar#13|)
                                    (PROGN (SETQ |a| (CAR |bfVar#13|)) NIL)
                                    (ATOM |bfVar#14|)
                                    (PROGN (SETQ |m| (CAR |bfVar#14|)) NIL))
                                (RETURN (NREVERSE |bfVar#15|)))
                               (#1#
                                (AND (MEMQ |a| |$PatternVariableList|)
                                     (SETQ |bfVar#15|
                                             (CONS (LIST |a| |m|)
                                                   |bfVar#15|)))))
                              (SETQ |bfVar#13| (CDR |bfVar#13|))
                              (SETQ |bfVar#14| (CDR |bfVar#14|))))
                           NIL |argl| NIL (CDR |signature|) NIL))
                  (SETQ |sig| (|substitute| |form| '$ |sig|))
                  (SETQ |pred'|
                          (MKPF
                           (CONS |pred|
                                 ((LAMBDA (|bfVar#17| |bfVar#16| |y|)
                                    (LOOP
                                     (COND
                                      ((OR (ATOM |bfVar#16|)
                                           (PROGN
                                            (SETQ |y| (CAR |bfVar#16|))
                                            NIL))
                                       (RETURN (NREVERSE |bfVar#17|)))
                                      (#1#
                                       (SETQ |bfVar#17|
                                               (CONS (|mkDatabasePred| |y|)
                                                     |bfVar#17|))))
                                     (SETQ |bfVar#16| (CDR |bfVar#16|))))
                                  NIL |predList| NIL))
                           'AND))
                  (SETQ |l| (|listOfPatternIds| |predList|))
                  (COND
                   (((LAMBDA (|bfVar#19| |bfVar#18| |u|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#18|)
                              (PROGN (SETQ |u| (CAR |bfVar#18|)) NIL))
                          (RETURN |bfVar#19|))
                         (#1#
                          (PROGN
                           (SETQ |bfVar#19| (NULL (MEMQ |u| |l|)))
                           (COND (|bfVar#19| (RETURN |bfVar#19|))))))
                        (SETQ |bfVar#18| (CDR |bfVar#18|))))
                     NIL |argl| NIL)
                    (|sayMSG|
                     (CONS "cannot handle modemap for"
                           (APPEND (|bright| |op|)
                                   (CONS "by pattern match" NIL))))
                    (SETQ |skip| 'SKIP)))
                  (SETQ |modemap|
                          (LIST (CONS |form| |sig|)
                                (CONS |pred'| (CONS |sel| |skip|))))
                  (SETQ |$lisplibModemapAlist|
                          (CONS
                           (CONS |op| (|interactiveModemapForm| |modemap|))
                           |$lisplibModemapAlist|))))))
          (SETQ |bfVar#10| (CDR |bfVar#10|))))
       |opAlist| NIL)))))

; saveUsersHashTable() ==
;   erase_lib(['USERS, 'DATABASE])
;   stream:= writeLib('USERS,'DATABASE)
;   for k in MSORT HKEYS $usersTb repeat
;     rwrite(k, HGET($usersTb, k), stream)
;   RSHUT stream

(DEFUN |saveUsersHashTable| ()
  (PROG (|stream|)
    (RETURN
     (PROGN
      (|erase_lib| (LIST 'USERS 'DATABASE))
      (SETQ |stream| (|writeLib| 'USERS 'DATABASE))
      ((LAMBDA (|bfVar#20| |k|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#20|) (PROGN (SETQ |k| (CAR |bfVar#20|)) NIL))
            (RETURN NIL))
           ('T (|rwrite| |k| (HGET |$usersTb| |k|) |stream|)))
          (SETQ |bfVar#20| (CDR |bfVar#20|))))
       (MSORT (HKEYS |$usersTb|)) NIL)
      (RSHUT |stream|)))))

; saveDependentsHashTable() ==
;   erase_lib(['DEPENDENTS, 'DATABASE])
;   stream:= writeLib('DEPENDENTS,'DATABASE)
;   for k in MSORT HKEYS $depTb repeat
;     rwrite(k, HGET($depTb, k), stream)
;   RSHUT stream

(DEFUN |saveDependentsHashTable| ()
  (PROG (|stream|)
    (RETURN
     (PROGN
      (|erase_lib| (LIST 'DEPENDENTS 'DATABASE))
      (SETQ |stream| (|writeLib| 'DEPENDENTS 'DATABASE))
      ((LAMBDA (|bfVar#21| |k|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#21|) (PROGN (SETQ |k| (CAR |bfVar#21|)) NIL))
            (RETURN NIL))
           ('T (|rwrite| |k| (HGET |$depTb| |k|) |stream|)))
          (SETQ |bfVar#21| (CDR |bfVar#21|))))
       (MSORT (HKEYS |$depTb|)) NIL)
      (RSHUT |stream|)))))

; save_browser_data() ==
;     buildLibdb(false)
;     dbSplitLibdb()
;     mkUsersHashTable()
;     saveUsersHashTable()
;     mkDependentsHashTable()
;     saveDependentsHashTable()

(DEFUN |save_browser_data| ()
  (PROG ()
    (RETURN
     (PROGN
      (|buildLibdb| NIL)
      (|dbSplitLibdb|)
      (|mkUsersHashTable|)
      (|saveUsersHashTable|)
      (|mkDependentsHashTable|)
      (|saveDependentsHashTable|)))))

; getUsersOfConstructor(con) ==
;   stream := readLib('USERS, 'DATABASE)
;   val := rread_list(con, stream)
;   RSHUT stream
;   val

(DEFUN |getUsersOfConstructor| (|con|)
  (PROG (|stream| |val|)
    (RETURN
     (PROGN
      (SETQ |stream| (|readLib| 'USERS 'DATABASE))
      (SETQ |val| (|rread_list| |con| |stream|))
      (RSHUT |stream|)
      |val|))))

; getDependentsOfConstructor(con) ==
;   stream := readLib('DEPENDENTS, 'DATABASE)
;   val := rread_list(con, stream)
;   RSHUT stream
;   val

(DEFUN |getDependentsOfConstructor| (|con|)
  (PROG (|stream| |val|)
    (RETURN
     (PROGN
      (SETQ |stream| (|readLib| 'DEPENDENTS 'DATABASE))
      (SETQ |val| (|rread_list| |con| |stream|))
      (RSHUT |stream|)
      |val|))))

; orderPredicateItems(pred1,sig,skip) ==
;   pred:= signatureTran pred1
;   pred is ["AND",:l] => orderPredTran(l,sig,skip)
;   pred

(DEFUN |orderPredicateItems| (|pred1| |sig| |skip|)
  (PROG (|pred| |l|)
    (RETURN
     (PROGN
      (SETQ |pred| (|signatureTran| |pred1|))
      (COND
       ((AND (CONSP |pred|) (EQ (CAR |pred|) 'AND)
             (PROGN (SETQ |l| (CDR |pred|)) #1='T))
        (|orderPredTran| |l| |sig| |skip|))
       (#1# |pred|))))))

; orderPredTran(oldList,sig,skip) ==
;   lastPreds:=nil
;   --(1) make two kinds of predicates appear last:
;   -----  (op *target ..) when *target does not appear later in sig
;   -----  (isDomain *1 ..)
;   for pred in oldList repeat
;     ((pred is [op,pvar,.] and MEMQ(op,'(isDomain ofCategory))
;        and pvar=first sig and not (pvar in rest sig)) or
;         (not skip and pred is ['isDomain,pvar,.] and pvar="*1")) =>
;           oldList:=delete(pred,oldList)
;           lastPreds:=[pred,:lastPreds]
;
;   --(2a) lastDependList=list of all variables that lastPred forms depend upon
;   lastDependList := "UNIONQ"/[listOfPatternIds x for x in lastPreds]
; --sayBrightlyNT "lastDependList="
; --pp lastDependList
;
;   --(2b) dependList=list of all variables that isDom/ofCat forms depend upon
;   dependList :=
;     "UNIONQ"/[listOfPatternIds y for x in oldList |
;       x is ['isDomain,.,y] or x is ['ofCategory,.,y]]
; --sayBrightlyNT "dependList="
; --pp dependList
;
;   --(3a) newList= list of ofCat/isDom entries that don't depend on
;   for x in oldList repeat
;     if (x is ['ofCategory,v,body]) or (x is ['isDomain,v,body]) then
;       indepvl:=listOfPatternIds v
;       depvl:=listOfPatternIds body
;     else
;       indepvl := listOfPatternIds x
;       depvl := nil
;     (INTERSECTIONQ(indepvl,dependList) = nil)
;         and INTERSECTIONQ(indepvl,lastDependList) =>
;       lastPreds := [:lastPreds,x]
;       oldList := delete(x,oldList)
;
;   --(3b) newList= list of ofCat/isDom entries that don't depend on
;   while oldList repeat
;     for x in oldList repeat
;       if (x is ['ofCategory,v,body]) or (x is ['isDomain,v,body]) then
;         indepvl:=listOfPatternIds v
;         depvl:=listOfPatternIds body
;       else
;         indepvl := listOfPatternIds x
;         depvl := nil
;       (INTERSECTIONQ(indepvl,dependList) = nil) =>
;         dependList:= setDifference(dependList,depvl)
;         newList:= [:newList,x]
; --  sayBrightlyNT "newList="
; --  pp newList
;
;   --(4) noldList= what is left over
;     (noldList:= setDifference(oldList,newList)) = oldList =>
; --    sayMSG '"NOTE: Parameters to domain have circular dependencies"
;       newList := [:newList,:oldList]
;       return nil
;     oldList:=noldList
; --  sayBrightlyNT "noldList="
; --  pp noldList
;
;   for pred in newList repeat
;     if pred is ['isDomain,x,y] or x is ['ofCategory,x,y] then
;       ids:= listOfPatternIds y
;       if and/[id in fullDependList for id in ids] then
;         fullDependList:= insertWOC(x,fullDependList)
;       fullDependList:= UNIONQ(fullDependList,ids)
;
;   newList:=[:newList,:lastPreds]
;
; --substitute (isDomain ..) forms as completely as possible to avoid false paths
;   newList := isDomainSubst newList
;   answer := [['AND,:newList],:INTERSECTIONQ(fullDependList,sig)]

(DEFUN |orderPredTran| (|oldList| |sig| |skip|)
  (PROG (|lastPreds| |op| |ISTMP#1| |pvar| |ISTMP#2| |lastDependList| |y|
         |dependList| |v| |body| |indepvl| |depvl| |newList| |noldList| |x|
         |ids| |fullDependList| |answer|)
    (RETURN
     (PROGN
      (SETQ |lastPreds| NIL)
      ((LAMBDA (|bfVar#22| |pred|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#22|) (PROGN (SETQ |pred| (CAR |bfVar#22|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((OR
               (AND (CONSP |pred|)
                    (PROGN
                     (SETQ |op| (CAR |pred|))
                     (SETQ |ISTMP#1| (CDR |pred|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |pvar| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)))))
                    (MEMQ |op| '(|isDomain| |ofCategory|))
                    (EQUAL |pvar| (CAR |sig|))
                    (NULL (|member| |pvar| (CDR |sig|))))
               (AND (NULL |skip|) (CONSP |pred|) (EQ (CAR |pred|) '|isDomain|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |pred|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |pvar| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)))))
                    (EQ |pvar| '*1)))
              (IDENTITY
               (PROGN
                (SETQ |oldList| (|delete| |pred| |oldList|))
                (SETQ |lastPreds| (CONS |pred| |lastPreds|))))))))
          (SETQ |bfVar#22| (CDR |bfVar#22|))))
       |oldList| NIL)
      (SETQ |lastDependList|
              ((LAMBDA (|bfVar#24| |bfVar#23| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#23|)
                        (PROGN (SETQ |x| (CAR |bfVar#23|)) NIL))
                    (RETURN |bfVar#24|))
                   (#1#
                    (SETQ |bfVar#24|
                            (UNIONQ |bfVar#24| (|listOfPatternIds| |x|)))))
                  (SETQ |bfVar#23| (CDR |bfVar#23|))))
               NIL |lastPreds| NIL))
      (SETQ |dependList|
              ((LAMBDA (|bfVar#26| |bfVar#25| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#25|)
                        (PROGN (SETQ |x| (CAR |bfVar#25|)) NIL))
                    (RETURN |bfVar#26|))
                   (#1#
                    (AND
                     (OR
                      (AND (CONSP |x|) (EQ (CAR |x|) '|isDomain|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |x|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |y| (CAR |ISTMP#2|))
                                        #1#))))))
                      (AND (CONSP |x|) (EQ (CAR |x|) '|ofCategory|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |x|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |y| (CAR |ISTMP#2|))
                                        #1#)))))))
                     (SETQ |bfVar#26|
                             (UNIONQ |bfVar#26| (|listOfPatternIds| |y|))))))
                  (SETQ |bfVar#25| (CDR |bfVar#25|))))
               NIL |oldList| NIL))
      ((LAMBDA (|bfVar#27| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#27|) (PROGN (SETQ |x| (CAR |bfVar#27|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (COND
              ((OR
                (AND (CONSP |x|) (EQ (CAR |x|) '|ofCategory|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |x|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |v| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN (SETQ |body| (CAR |ISTMP#2|)) #1#))))))
                (AND (CONSP |x|) (EQ (CAR |x|) '|isDomain|)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |x|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |v| (CAR |ISTMP#1|))
                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                 (PROGN
                                  (SETQ |body| (CAR |ISTMP#2|))
                                  #1#)))))))
               (SETQ |indepvl| (|listOfPatternIds| |v|))
               (SETQ |depvl| (|listOfPatternIds| |body|)))
              (#1# (SETQ |indepvl| (|listOfPatternIds| |x|))
               (SETQ |depvl| NIL)))
             (COND
              ((AND (NULL (INTERSECTIONQ |indepvl| |dependList|))
                    (INTERSECTIONQ |indepvl| |lastDependList|))
               (PROGN
                (SETQ |lastPreds| (APPEND |lastPreds| (CONS |x| NIL)))
                (SETQ |oldList| (|delete| |x| |oldList|))))))))
          (SETQ |bfVar#27| (CDR |bfVar#27|))))
       |oldList| NIL)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT |oldList|) (RETURN NIL))
                (#1#
                 (PROGN
                  ((LAMBDA (|bfVar#28| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#28|)
                            (PROGN (SETQ |x| (CAR |bfVar#28|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (PROGN
                         (COND
                          ((OR
                            (AND (CONSP |x|) (EQ (CAR |x|) '|ofCategory|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |x|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |v| (CAR |ISTMP#1|))
                                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                        (AND (CONSP |ISTMP#2|)
                                             (EQ (CDR |ISTMP#2|) NIL)
                                             (PROGN
                                              (SETQ |body| (CAR |ISTMP#2|))
                                              #1#))))))
                            (AND (CONSP |x|) (EQ (CAR |x|) '|isDomain|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |x|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |v| (CAR |ISTMP#1|))
                                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                        (AND (CONSP |ISTMP#2|)
                                             (EQ (CDR |ISTMP#2|) NIL)
                                             (PROGN
                                              (SETQ |body| (CAR |ISTMP#2|))
                                              #1#)))))))
                           (SETQ |indepvl| (|listOfPatternIds| |v|))
                           (SETQ |depvl| (|listOfPatternIds| |body|)))
                          (#1# (SETQ |indepvl| (|listOfPatternIds| |x|))
                           (SETQ |depvl| NIL)))
                         (COND
                          ((NULL (INTERSECTIONQ |indepvl| |dependList|))
                           (PROGN
                            (SETQ |dependList|
                                    (SETDIFFERENCE |dependList| |depvl|))
                            (SETQ |newList|
                                    (APPEND |newList| (CONS |x| NIL)))))))))
                      (SETQ |bfVar#28| (CDR |bfVar#28|))))
                   |oldList| NIL)
                  (COND
                   ((EQUAL
                     (SETQ |noldList| (SETDIFFERENCE |oldList| |newList|))
                     |oldList|)
                    (PROGN
                     (SETQ |newList| (APPEND |newList| |oldList|))
                     (RETURN NIL)))
                   (#1# (SETQ |oldList| |noldList|)))))))))
      ((LAMBDA (|bfVar#29| |pred|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#29|) (PROGN (SETQ |pred| (CAR |bfVar#29|)) NIL))
            (RETURN NIL))
           (#1#
            (COND
             ((OR
               (AND (CONSP |pred|) (EQ (CAR |pred|) '|isDomain|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |pred|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |x| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1#))))))
               (AND (CONSP |x|) (EQ (CAR |x|) '|ofCategory|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |x|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |x| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1#)))))))
              (SETQ |ids| (|listOfPatternIds| |y|))
              (COND
               (((LAMBDA (|bfVar#31| |bfVar#30| |id|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#30|)
                          (PROGN (SETQ |id| (CAR |bfVar#30|)) NIL))
                      (RETURN |bfVar#31|))
                     (#1#
                      (PROGN
                       (SETQ |bfVar#31| (|member| |id| |fullDependList|))
                       (COND ((NOT |bfVar#31|) (RETURN NIL))))))
                    (SETQ |bfVar#30| (CDR |bfVar#30|))))
                 T |ids| NIL)
                (SETQ |fullDependList| (|insertWOC| |x| |fullDependList|))))
              (SETQ |fullDependList| (UNIONQ |fullDependList| |ids|))))))
          (SETQ |bfVar#29| (CDR |bfVar#29|))))
       |newList| NIL)
      (SETQ |newList| (APPEND |newList| |lastPreds|))
      (SETQ |newList| (|isDomainSubst| |newList|))
      (SETQ |answer|
              (CONS (CONS 'AND |newList|)
                    (INTERSECTIONQ |fullDependList| |sig|)))))))

; isDomainSubst u == main where
;   main ==
;     u is [head,:tail] =>
;       nhead :=
;         head is ['isDomain,x,y] => ['isDomain,x,fn(y,tail)]
;         head
;       [nhead,:isDomainSubst rest u]
;     u
;   fn(x,alist) ==
;     atom x =>
;       IDENTP x and MEMQ(x,$PatternVariableList) and (s := findSub(x,alist)) => s
;       x
;     [first x, :[fn(y, alist) for y in rest x]]
;   findSub(x,alist) ==
;     null alist => nil
;     alist is [['isDomain,y,z],:.] and x = y => z
;     findSub(x,rest alist)

(DEFUN |isDomainSubst| (|u|)
  (PROG (|head| |tail| |ISTMP#1| |x| |ISTMP#2| |y| |nhead|)
    (RETURN
     (COND
      ((AND (CONSP |u|)
            (PROGN (SETQ |head| (CAR |u|)) (SETQ |tail| (CDR |u|)) #1='T))
       (PROGN
        (SETQ |nhead|
                (COND
                 ((AND (CONSP |head|) (EQ (CAR |head|) '|isDomain|)
                       (PROGN
                        (SETQ |ISTMP#1| (CDR |head|))
                        (AND (CONSP |ISTMP#1|)
                             (PROGN
                              (SETQ |x| (CAR |ISTMP#1|))
                              (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                              (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                   (PROGN (SETQ |y| (CAR |ISTMP#2|)) #1#))))))
                  (LIST '|isDomain| |x| (|isDomainSubst,fn| |y| |tail|)))
                 (#1# |head|)))
        (CONS |nhead| (|isDomainSubst| (CDR |u|)))))
      (#1# |u|)))))
(DEFUN |isDomainSubst,fn| (|x| |alist|)
  (PROG (|s|)
    (RETURN
     (COND
      ((ATOM |x|)
       (COND
        ((AND (IDENTP |x|) (MEMQ |x| |$PatternVariableList|)
              (SETQ |s| (|isDomainSubst,findSub| |x| |alist|)))
         |s|)
        (#1='T |x|)))
      (#1#
       (CONS (CAR |x|)
             ((LAMBDA (|bfVar#33| |bfVar#32| |y|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#32|)
                       (PROGN (SETQ |y| (CAR |bfVar#32|)) NIL))
                   (RETURN (NREVERSE |bfVar#33|)))
                  (#1#
                   (SETQ |bfVar#33|
                           (CONS (|isDomainSubst,fn| |y| |alist|)
                                 |bfVar#33|))))
                 (SETQ |bfVar#32| (CDR |bfVar#32|))))
              NIL (CDR |x|) NIL)))))))
(DEFUN |isDomainSubst,findSub| (|x| |alist|)
  (PROG (|ISTMP#1| |ISTMP#2| |y| |ISTMP#3| |z|)
    (RETURN
     (COND ((NULL |alist|) NIL)
           ((AND (CONSP |alist|)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |alist|))
                  (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|isDomain|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |y| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |z| (CAR |ISTMP#3|))
                                    #1='T)))))))
                 (EQUAL |x| |y|))
            |z|)
           (#1# (|isDomainSubst,findSub| |x| (CDR |alist|)))))))

; signatureTran pred ==
;   atom pred => pred
;   pred is ['has, D, catForm] and isCategoryForm(catForm) =>
;     ['ofCategory,D,catForm]
;   [signatureTran p for p in pred]

(DEFUN |signatureTran| (|pred|)
  (PROG (|ISTMP#1| D |ISTMP#2| |catForm|)
    (RETURN
     (COND ((ATOM |pred|) |pred|)
           ((AND (CONSP |pred|) (EQ (CAR |pred|) '|has|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |pred|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ D (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |catForm| (CAR |ISTMP#2|)) #1='T)))))
                 (|isCategoryForm| |catForm|))
            (LIST '|ofCategory| D |catForm|))
           (#1#
            ((LAMBDA (|bfVar#35| |bfVar#34| |p|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#34|)
                      (PROGN (SETQ |p| (CAR |bfVar#34|)) NIL))
                  (RETURN (NREVERSE |bfVar#35|)))
                 (#1#
                  (SETQ |bfVar#35| (CONS (|signatureTran| |p|) |bfVar#35|))))
                (SETQ |bfVar#34| (CDR |bfVar#34|))))
             NIL |pred| NIL))))))

; interactiveModemapForm mm ==
;   --  create modemap form for use by the interpreter.  This function
;   --  replaces all specific domains mentioned in the modemap with pattern
;   --  variables, and predicates
;   mm := replaceVars(COPY mm,$PatternVariableList,$FormalMapVariableList)
;   [pattern:=[dc,:sig],pred] := mm
;   pred := [fn x for x in pred] where fn x ==
;     x is [a,b,c] and a ~= 'isFreeFunction and atom c => [a,b,[c]]
;     x
;   [mmpat, patternAlist, partial, patvars] :=
;     modemapPattern(pattern,sig)
;   [pred,domainPredicateList] :=
;     substVars(pred,patternAlist,patvars)
;   pred := fixUpPredicate(pred,domainPredicateList,partial,rest mmpat)
;   [cond, :.] := pred
;   [mmpat, cond]

(DEFUN |interactiveModemapForm| (|mm|)
  (PROG (|pattern| |dc| |sig| |pred| |LETTMP#1| |mmpat| |patternAlist|
         |partial| |patvars| |domainPredicateList| |cond|)
    (RETURN
     (PROGN
      (SETQ |mm|
              (|replaceVars| (COPY |mm|) |$PatternVariableList|
               |$FormalMapVariableList|))
      (SETQ |pattern| (CAR . #1=(|mm|)))
      (SETQ |dc| (CAAR . #1#))
      (SETQ |sig| (CDAR . #1#))
      (SETQ |pred| (CADR |mm|))
      (SETQ |pred|
              ((LAMBDA (|bfVar#37| |bfVar#36| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#36|)
                        (PROGN (SETQ |x| (CAR |bfVar#36|)) NIL))
                    (RETURN (NREVERSE |bfVar#37|)))
                   ('T
                    (SETQ |bfVar#37|
                            (CONS (|interactiveModemapForm,fn| |x|)
                                  |bfVar#37|))))
                  (SETQ |bfVar#36| (CDR |bfVar#36|))))
               NIL |pred| NIL))
      (SETQ |LETTMP#1| (|modemapPattern| |pattern| |sig|))
      (SETQ |mmpat| (CAR |LETTMP#1|))
      (SETQ |patternAlist| (CADR . #2=(|LETTMP#1|)))
      (SETQ |partial| (CADDR . #2#))
      (SETQ |patvars| (CADDDR . #2#))
      (SETQ |LETTMP#1| (|substVars| |pred| |patternAlist| |patvars|))
      (SETQ |pred| (CAR |LETTMP#1|))
      (SETQ |domainPredicateList| (CADR |LETTMP#1|))
      (SETQ |pred|
              (|fixUpPredicate| |pred| |domainPredicateList| |partial|
               (CDR |mmpat|)))
      (SETQ |cond| (CAR |pred|))
      (LIST |mmpat| |cond|)))))
(DEFUN |interactiveModemapForm,fn| (|x|)
  (PROG (|a| |ISTMP#1| |b| |ISTMP#2| |c|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN
             (SETQ |a| (CAR |x|))
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |b| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |c| (CAR |ISTMP#2|)) #1='T)))))
            (NOT (EQ |a| '|isFreeFunction|)) (ATOM |c|))
       (LIST |a| |b| (LIST |c|)))
      (#1# |x|)))))

; modemapPattern(mmPattern,sig) ==
;   --  Returns a list of the pattern of a modemap, an Alist of the
;   --  substitutions made, a boolean flag indicating whether
;   --  the result type is partial, and a list of unused pattern variables
;   patternAlist := nil
;   mmpat := nil
;   patvars := $PatternVariableList
;   partial := false
;   for xTails in tails mmPattern repeat
;     x := first xTails
;     if x is ['Union,dom,tag] and tag = '"failed" and xTails=sig then
;       x := dom
;       partial := true
;     patvar := rassoc(x,patternAlist)
;     not null patvar => mmpat := [patvar,:mmpat]
;     patvar := first patvars
;     patvars := rest patvars
;     mmpat := [patvar,:mmpat]
;     patternAlist := [[patvar,:x],:patternAlist]
;   [NREVERSE mmpat,patternAlist,partial,patvars]

(DEFUN |modemapPattern| (|mmPattern| |sig|)
  (PROG (|patternAlist| |mmpat| |patvars| |partial| |x| |ISTMP#1| |dom|
         |ISTMP#2| |tag| |patvar|)
    (RETURN
     (PROGN
      (SETQ |patternAlist| NIL)
      (SETQ |mmpat| NIL)
      (SETQ |patvars| |$PatternVariableList|)
      (SETQ |partial| NIL)
      ((LAMBDA (|xTails|)
         (LOOP
          (COND ((ATOM |xTails|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |x| (CAR |xTails|))
                  (COND
                   ((AND (CONSP |x|) (EQ (CAR |x|) '|Union|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |x|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |dom| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |tag| (CAR |ISTMP#2|))
                                      #1#)))))
                         (EQUAL |tag| "failed") (EQUAL |xTails| |sig|))
                    (SETQ |x| |dom|) (SETQ |partial| T)))
                  (SETQ |patvar| (|rassoc| |x| |patternAlist|))
                  (COND
                   ((NULL (NULL |patvar|))
                    (SETQ |mmpat| (CONS |patvar| |mmpat|)))
                   (#1#
                    (PROGN
                     (SETQ |patvar| (CAR |patvars|))
                     (SETQ |patvars| (CDR |patvars|))
                     (SETQ |mmpat| (CONS |patvar| |mmpat|))
                     (SETQ |patternAlist|
                             (CONS (CONS |patvar| |x|) |patternAlist|))))))))
          (SETQ |xTails| (CDR |xTails|))))
       |mmPattern|)
      (LIST (NREVERSE |mmpat|) |patternAlist| |partial| |patvars|)))))

; substVars(pred,patternAlist,patternVarList) ==
;   --make pattern variable substitutions
;   domainPredicates := nil
;   for [[patVar,:value],:.] in tails patternAlist repeat
;     pred := substitute(patVar,value,pred)
;     patternAlist := NSUBST(patVar, value, patternAlist)
;     domainPredicates := substitute(patVar,value,domainPredicates)
;     if not MEMQ(value,$FormalMapVariableList) then
;       domainPredicates := [["isDomain",patVar,value],:domainPredicates]
;   everything := [pred,patternAlist,domainPredicates]
;   for var in $FormalMapVariableList repeat
;     CONTAINED(var,everything) =>
;       replacementVar := first patternVarList
;       patternVarList := rest patternVarList
;       pred := substitute(replacementVar,var,pred)
;       domainPredicates := substitute(replacementVar,var,domainPredicates)
;   [pred, domainPredicates]

(DEFUN |substVars| (|pred| |patternAlist| |patternVarList|)
  (PROG (|domainPredicates| |ISTMP#1| |patVar| |value| |everything|
         |replacementVar|)
    (RETURN
     (PROGN
      (SETQ |domainPredicates| NIL)
      ((LAMBDA (|bfVar#38|)
         (LOOP
          (COND ((ATOM |bfVar#38|) (RETURN NIL))
                (#1='T
                 (AND (CONSP |bfVar#38|)
                      (PROGN
                       (SETQ |ISTMP#1| (CAR |bfVar#38|))
                       (AND (CONSP |ISTMP#1|)
                            (PROGN
                             (SETQ |patVar| (CAR |ISTMP#1|))
                             (SETQ |value| (CDR |ISTMP#1|))
                             #1#)))
                      (PROGN
                       (SETQ |pred| (|substitute| |patVar| |value| |pred|))
                       (SETQ |patternAlist|
                               (NSUBST |patVar| |value| |patternAlist|))
                       (SETQ |domainPredicates|
                               (|substitute| |patVar| |value|
                                |domainPredicates|))
                       (COND
                        ((NULL (MEMQ |value| |$FormalMapVariableList|))
                         (SETQ |domainPredicates|
                                 (CONS (LIST '|isDomain| |patVar| |value|)
                                       |domainPredicates|))))))))
          (SETQ |bfVar#38| (CDR |bfVar#38|))))
       |patternAlist|)
      (SETQ |everything| (LIST |pred| |patternAlist| |domainPredicates|))
      ((LAMBDA (|bfVar#39| |var|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#39|) (PROGN (SETQ |var| (CAR |bfVar#39|)) NIL))
            (RETURN NIL))
           (#1#
            (COND
             ((CONTAINED |var| |everything|)
              (IDENTITY
               (PROGN
                (SETQ |replacementVar| (CAR |patternVarList|))
                (SETQ |patternVarList| (CDR |patternVarList|))
                (SETQ |pred| (|substitute| |replacementVar| |var| |pred|))
                (SETQ |domainPredicates|
                        (|substitute| |replacementVar| |var|
                         |domainPredicates|))))))))
          (SETQ |bfVar#39| (CDR |bfVar#39|))))
       |$FormalMapVariableList| NIL)
      (LIST |pred| |domainPredicates|)))))

; fixUpPredicate(predClause, domainPreds, partial, sig) ==
;   --  merge the predicates in predClause and domainPreds into a
;   --  single predicate
;   [predicate, fn, :skip] := predClause
;   if first predicate = "AND" then
;     predicates := APPEND(domainPreds,rest predicate)
;   else if predicate ~= MKQ "T"
;        then predicates:= [predicate, :domainPreds]
;        else predicates := domainPreds or [predicate]
;   if #predicates > 1 then
;     pred := ["AND",:predicates]
;     [pred, :.] := orderPredicateItems(pred,sig,skip)
;   else
;     pred := orderPredicateItems(first predicates,sig,skip)
;   pred := moveORsOutside pred
;   if partial then pred := ["partial", :pred]
;   [pred, fn, :skip]

(DEFUN |fixUpPredicate| (|predClause| |domainPreds| |partial| |sig|)
  (PROG (|predicate| |fn| |skip| |predicates| |pred| |LETTMP#1|)
    (RETURN
     (PROGN
      (SETQ |predicate| (CAR |predClause|))
      (SETQ |fn| (CADR . #1=(|predClause|)))
      (SETQ |skip| (CDDR . #1#))
      (COND
       ((EQ (CAR |predicate|) 'AND)
        (SETQ |predicates| (APPEND |domainPreds| (CDR |predicate|))))
       ((NOT (EQUAL |predicate| (MKQ 'T)))
        (SETQ |predicates| (CONS |predicate| |domainPreds|)))
       (#2='T (SETQ |predicates| (OR |domainPreds| (LIST |predicate|)))))
      (COND
       ((< 1 (LENGTH |predicates|)) (SETQ |pred| (CONS 'AND |predicates|))
        (SETQ |LETTMP#1| (|orderPredicateItems| |pred| |sig| |skip|))
        (SETQ |pred| (CAR |LETTMP#1|)) |LETTMP#1|)
       (#2#
        (SETQ |pred| (|orderPredicateItems| (CAR |predicates|) |sig| |skip|))))
      (SETQ |pred| (|moveORsOutside| |pred|))
      (COND (|partial| (SETQ |pred| (CONS '|partial| |pred|))))
      (CONS |pred| (CONS |fn| |skip|))))))

; moveORsOutside p ==
;   p is ['AND,:q] =>
;     q := [moveORsOutside r for r in q]
;     x := or/[r for r in q | r is ['OR,:s]] =>
;         moveORsOutside(['OR, :[['AND, :substitute(t, x, q)] for t in rest x]])
;     ['AND,:q]
;   p

(DEFUN |moveORsOutside| (|p|)
  (PROG (|q| |s| |x|)
    (RETURN
     (COND
      ((AND (CONSP |p|) (EQ (CAR |p|) 'AND) (PROGN (SETQ |q| (CDR |p|)) #1='T))
       (PROGN
        (SETQ |q|
                ((LAMBDA (|bfVar#41| |bfVar#40| |r|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#40|)
                          (PROGN (SETQ |r| (CAR |bfVar#40|)) NIL))
                      (RETURN (NREVERSE |bfVar#41|)))
                     (#1#
                      (SETQ |bfVar#41|
                              (CONS (|moveORsOutside| |r|) |bfVar#41|))))
                    (SETQ |bfVar#40| (CDR |bfVar#40|))))
                 NIL |q| NIL))
        (COND
         ((SETQ |x|
                  ((LAMBDA (|bfVar#43| |bfVar#42| |r|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#42|)
                            (PROGN (SETQ |r| (CAR |bfVar#42|)) NIL))
                        (RETURN |bfVar#43|))
                       (#1#
                        (AND (CONSP |r|) (EQ (CAR |r|) 'OR)
                             (PROGN (SETQ |s| (CDR |r|)) #1#)
                             (PROGN
                              (SETQ |bfVar#43| |r|)
                              (COND (|bfVar#43| (RETURN |bfVar#43|)))))))
                      (SETQ |bfVar#42| (CDR |bfVar#42|))))
                   NIL |q| NIL))
          (|moveORsOutside|
           (CONS 'OR
                 ((LAMBDA (|bfVar#45| |bfVar#44| |t|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#44|)
                           (PROGN (SETQ |t| (CAR |bfVar#44|)) NIL))
                       (RETURN (NREVERSE |bfVar#45|)))
                      (#1#
                       (SETQ |bfVar#45|
                               (CONS (CONS 'AND (|substitute| |t| |x| |q|))
                                     |bfVar#45|))))
                     (SETQ |bfVar#44| (CDR |bfVar#44|))))
                  NIL (CDR |x|) NIL))))
         (#1# (CONS 'AND |q|)))))
      (#1# |p|)))))

; replaceVars(x,oldvars,newvars) ==
;   --  replace every identifier in oldvars with the corresponding
;   --  identifier in newvars in the expression x
;   for old in oldvars for new in newvars repeat
;     x := substitute(new,old,x)
;   x

(DEFUN |replaceVars| (|x| |oldvars| |newvars|)
  (PROG ()
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#46| |old| |bfVar#47| |new|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#46|) (PROGN (SETQ |old| (CAR |bfVar#46|)) NIL)
                (ATOM |bfVar#47|) (PROGN (SETQ |new| (CAR |bfVar#47|)) NIL))
            (RETURN NIL))
           ('T (SETQ |x| (|substitute| |new| |old| |x|))))
          (SETQ |bfVar#46| (CDR |bfVar#46|))
          (SETQ |bfVar#47| (CDR |bfVar#47|))))
       |oldvars| NIL |newvars| NIL)
      |x|))))

; getDomainFromMm mm ==
;   -- Returns the Domain (or package or category) of origin from a pattern
;   -- modemap
;   [., cond] := mm
;   if cond is ['partial, :c] then cond := c
;   condList :=
;     cond is ['AND, :cl] => cl
;     cond is ['OR, ['AND, :cl],:.] => cl  --all cl's should give same info
;     [cond]
;   val :=
;     for condition in condList repeat
;       condition is ['isDomain, "*1", dom] => return opOf dom
;       condition is ['ofCategory, "*1", cat] and _
;           not(member(opOf cat, ["finiteAggregate", "shallowlyMutable", _
;                "arbitraryPrecision", "canonicalUnitNormal"]))_
;              => return opOf cat
;   null val =>
;     keyedSystemError("S2GE0016",
;       ['"getDomainFromMm",'"Can't find domain in modemap condition"])
;   val

(DEFUN |getDomainFromMm| (|mm|)
  (PROG (|cond| |c| |cl| |ISTMP#1| |ISTMP#2| |condList| |dom| |cat| |val|)
    (RETURN
     (PROGN
      (SETQ |cond| (CADR |mm|))
      (COND
       ((AND (CONSP |cond|) (EQ (CAR |cond|) '|partial|)
             (PROGN (SETQ |c| (CDR |cond|)) #1='T))
        (SETQ |cond| |c|)))
      (SETQ |condList|
              (COND
               ((AND (CONSP |cond|) (EQ (CAR |cond|) 'AND)
                     (PROGN (SETQ |cl| (CDR |cond|)) #1#))
                |cl|)
               ((AND (CONSP |cond|) (EQ (CAR |cond|) 'OR)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |cond|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) 'AND)
                                 (PROGN (SETQ |cl| (CDR |ISTMP#2|)) #1#))))))
                |cl|)
               (#1# (LIST |cond|))))
      (SETQ |val|
              ((LAMBDA (|bfVar#48| |condition|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#48|)
                        (PROGN (SETQ |condition| (CAR |bfVar#48|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (COND
                     ((AND (CONSP |condition|)
                           (EQ (CAR |condition|) '|isDomain|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |condition|))
                            (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '*1)
                                 (PROGN
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |dom| (CAR |ISTMP#2|))
                                        #1#))))))
                      (RETURN (|opOf| |dom|)))
                     ((AND (CONSP |condition|)
                           (EQ (CAR |condition|) '|ofCategory|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |condition|))
                            (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '*1)
                                 (PROGN
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |cat| (CAR |ISTMP#2|))
                                        #1#)))))
                           (NULL
                            (|member| (|opOf| |cat|)
                             (LIST '|finiteAggregate| '|shallowlyMutable|
                                   '|arbitraryPrecision|
                                   '|canonicalUnitNormal|))))
                      (RETURN (|opOf| |cat|))))))
                  (SETQ |bfVar#48| (CDR |bfVar#48|))))
               |condList| NIL))
      (COND
       ((NULL |val|)
        (|keyedSystemError| 'S2GE0016
         (LIST "getDomainFromMm" "Can't find domain in modemap condition")))
       (#1# |val|))))))

; getFirstArgTypeFromMm mm ==
;   -- Returns the type of the first argument or nil
;   [pats, cond] := mm
;   [.,.,:args] := pats
;   null args => nil
;   arg1 := first args
;   if cond is ['partial, :c] then cond := c
;   condList :=
;     cond is ['AND, :cl] => cl
;     cond is ['OR, ['AND, :cl],:.] => cl  --all cl's should give same info
;     [cond]
;   type := nil
;   for condition in condList while not type repeat
;       if condition is ['isDomain, a1, dom] and a1=arg1 then type := dom
;   type

(DEFUN |getFirstArgTypeFromMm| (|mm|)
  (PROG (|pats| |cond| |args| |arg1| |c| |cl| |ISTMP#1| |ISTMP#2| |condList|
         |type| |a1| |dom|)
    (RETURN
     (PROGN
      (SETQ |pats| (CAR |mm|))
      (SETQ |cond| (CADR |mm|))
      (SETQ |args| (CDDR |pats|))
      (COND ((NULL |args|) NIL)
            (#1='T
             (PROGN
              (SETQ |arg1| (CAR |args|))
              (COND
               ((AND (CONSP |cond|) (EQ (CAR |cond|) '|partial|)
                     (PROGN (SETQ |c| (CDR |cond|)) #1#))
                (SETQ |cond| |c|)))
              (SETQ |condList|
                      (COND
                       ((AND (CONSP |cond|) (EQ (CAR |cond|) 'AND)
                             (PROGN (SETQ |cl| (CDR |cond|)) #1#))
                        |cl|)
                       ((AND (CONSP |cond|) (EQ (CAR |cond|) 'OR)
                             (PROGN
                              (SETQ |ISTMP#1| (CDR |cond|))
                              (AND (CONSP |ISTMP#1|)
                                   (PROGN
                                    (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                    (AND (CONSP |ISTMP#2|)
                                         (EQ (CAR |ISTMP#2|) 'AND)
                                         (PROGN
                                          (SETQ |cl| (CDR |ISTMP#2|))
                                          #1#))))))
                        |cl|)
                       (#1# (LIST |cond|))))
              (SETQ |type| NIL)
              ((LAMBDA (|bfVar#49| |condition|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#49|)
                        (PROGN (SETQ |condition| (CAR |bfVar#49|)) NIL) |type|)
                    (RETURN NIL))
                   (#1#
                    (COND
                     ((AND (CONSP |condition|)
                           (EQ (CAR |condition|) '|isDomain|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |condition|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |a1| (CAR |ISTMP#1|))
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |dom| (CAR |ISTMP#2|))
                                        #1#)))))
                           (EQUAL |a1| |arg1|))
                      (SETQ |type| |dom|)))))
                  (SETQ |bfVar#49| (CDR |bfVar#49|))))
               |condList| NIL)
              |type|)))))))

; isFreeFunctionFromMm mm ==
;   -- This returns true is the modemap represents a free function, ie,
;   -- one not coming from a domain or category.
;   [., cond] := mm
;   isFreeFunctionFromMmCond cond

(DEFUN |isFreeFunctionFromMm| (|mm|)
  (PROG (|cond|)
    (RETURN
     (PROGN (SETQ |cond| (CADR |mm|)) (|isFreeFunctionFromMmCond| |cond|)))))

; isFreeFunctionFromMmCond cond ==
;   -- This returns true is the modemap represents a free function, ie,
;   -- one not coming from a domain or category.
;   if cond is ['partial, :c] then cond := c
;   condList :=
;     cond is ['AND, :cl] => cl
;     cond is ['OR, ['AND, :cl],:.] => cl  --all cl's should give same info
;     [cond]
;   iff := false
;   for condition in condList while not iff repeat
;       if condition is ['isFreeFunction, :.] then iff := true
;   iff

(DEFUN |isFreeFunctionFromMmCond| (|cond|)
  (PROG (|c| |cl| |ISTMP#1| |ISTMP#2| |condList| |iff|)
    (RETURN
     (PROGN
      (COND
       ((AND (CONSP |cond|) (EQ (CAR |cond|) '|partial|)
             (PROGN (SETQ |c| (CDR |cond|)) #1='T))
        (SETQ |cond| |c|)))
      (SETQ |condList|
              (COND
               ((AND (CONSP |cond|) (EQ (CAR |cond|) 'AND)
                     (PROGN (SETQ |cl| (CDR |cond|)) #1#))
                |cl|)
               ((AND (CONSP |cond|) (EQ (CAR |cond|) 'OR)
                     (PROGN
                      (SETQ |ISTMP#1| (CDR |cond|))
                      (AND (CONSP |ISTMP#1|)
                           (PROGN
                            (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                            (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) 'AND)
                                 (PROGN (SETQ |cl| (CDR |ISTMP#2|)) #1#))))))
                |cl|)
               (#1# (LIST |cond|))))
      (SETQ |iff| NIL)
      ((LAMBDA (|bfVar#50| |condition|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#50|)
                (PROGN (SETQ |condition| (CAR |bfVar#50|)) NIL) |iff|)
            (RETURN NIL))
           (#1#
            (COND
             ((AND (CONSP |condition|)
                   (EQ (CAR |condition|) '|isFreeFunction|))
              (SETQ |iff| T)))))
          (SETQ |bfVar#50| (CDR |bfVar#50|))))
       |condList| NIL)
      |iff|))))

; getAllModemapsFromDatabase(op,nargs) ==
;   $getUnexposedOperations: local := true
;   startTimingProcess 'diskread
;   ans := getSystemModemaps(op,nargs)
;   stopTimingProcess 'diskread
;   ans

(DEFUN |getAllModemapsFromDatabase| (|op| |nargs|)
  (PROG (|$getUnexposedOperations| |ans|)
    (DECLARE (SPECIAL |$getUnexposedOperations|))
    (RETURN
     (PROGN
      (SETQ |$getUnexposedOperations| T)
      (|startTimingProcess| '|diskread|)
      (SETQ |ans| (|getSystemModemaps| |op| |nargs|))
      (|stopTimingProcess| '|diskread|)
      |ans|))))

; getModemapsFromDatabase(op,nargs) ==
;   $getUnexposedOperations: local := false
;   startTimingProcess 'diskread
;   ans := getSystemModemaps(op,nargs)
;   stopTimingProcess 'diskread
;   ans

(DEFUN |getModemapsFromDatabase| (|op| |nargs|)
  (PROG (|$getUnexposedOperations| |ans|)
    (DECLARE (SPECIAL |$getUnexposedOperations|))
    (RETURN
     (PROGN
      (SETQ |$getUnexposedOperations| NIL)
      (|startTimingProcess| '|diskread|)
      (SETQ |ans| (|getSystemModemaps| |op| |nargs|))
      (|stopTimingProcess| '|diskread|)
      |ans|))))

; getSystemModemaps(op,nargs) ==
;   mml:= GETDATABASE(op,'OPERATION) =>
;     mms := NIL
;     for (x := [[.,:sig],.]) in mml repeat
;       (NUMBERP nargs) and (nargs ~= #QCDR sig) => 'iterate
;       $getUnexposedOperations or isFreeFunctionFromMm(x) or
;         isExposedConstructor(getDomainFromMm(x)) => mms := [x,:mms]
;       'iterate
;     mms
;   nil

(DEFUN |getSystemModemaps| (|op| |nargs|)
  (PROG (|mml| |mms| |ISTMP#1| |sig| |ISTMP#2|)
    (RETURN
     (COND
      ((SETQ |mml| (GETDATABASE |op| 'OPERATION))
       (PROGN
        (SETQ |mms| NIL)
        ((LAMBDA (|bfVar#51| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#51|) (PROGN (SETQ |x| (CAR |bfVar#51|)) NIL))
              (RETURN NIL))
             (#1='T
              (AND (CONSP |x|)
                   (PROGN
                    (SETQ |ISTMP#1| (CAR |x|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN (SETQ |sig| (CDR |ISTMP#1|)) #1#)))
                   (PROGN
                    (SETQ |ISTMP#2| (CDR |x|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)))
                   (COND
                    ((AND (NUMBERP |nargs|)
                          (NOT (EQL |nargs| (LENGTH (QCDR |sig|)))))
                     '|iterate|)
                    ((OR |$getUnexposedOperations| (|isFreeFunctionFromMm| |x|)
                         (|isExposedConstructor| (|getDomainFromMm| |x|)))
                     (SETQ |mms| (CONS |x| |mms|)))
                    (#1# '|iterate|)))))
            (SETQ |bfVar#51| (CDR |bfVar#51|))))
         |mml| NIL)
        |mms|))
      (#1# NIL)))))

; mkAlistOfExplicitCategoryOps target ==
;   if target is ['add,a,:l] then
;     target:=a
;   target is ['Join,:l] =>
;     "union"/[mkAlistOfExplicitCategoryOps cat for cat in l]
;   target is ['CATEGORY,.,:l] =>
;     l:= flattenSignatureList ['PROGN,:l]
;     u:=
;       [[atomizeOp op,:sig] for x in l | x is ['SIGNATURE,op,sig,:.]]
;             where
;               atomizeOp op ==
;                 atom op => op
;                 op is [a] => a
;                 keyedSystemError("S2GE0016",
;                   ['"mkAlistOfExplicitCategoryOps",'"bad signature"])
;     opList:= REMDUP ASSOCLEFT u
;     [[x,:fn(x,u)] for x in opList] where
;       fn(op,u) ==
;         u is [[a,:b],:c] => (a=op => [b,:fn(op,c)]; fn(op,c))
;   isCategoryForm(target) => nil
;   keyedSystemError("S2GE0016",
;     ['"mkAlistOfExplicitCategoryOps",'"bad signature"])

(DEFUN |mkAlistOfExplicitCategoryOps| (|target|)
  (PROG (|ISTMP#1| |a| |l| |op| |ISTMP#2| |sig| |u| |opList|)
    (RETURN
     (PROGN
      (COND
       ((AND (CONSP |target|) (EQ (CAR |target|) '|add|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |target|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |a| (CAR |ISTMP#1|))
                    (SETQ |l| (CDR |ISTMP#1|))
                    #1='T))))
        (SETQ |target| |a|)))
      (COND
       ((AND (CONSP |target|) (EQ (CAR |target|) '|Join|)
             (PROGN (SETQ |l| (CDR |target|)) #1#))
        ((LAMBDA (|bfVar#53| |bfVar#52| |cat|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#52|) (PROGN (SETQ |cat| (CAR |bfVar#52|)) NIL))
              (RETURN |bfVar#53|))
             (#1#
              (SETQ |bfVar#53|
                      (|union| |bfVar#53|
                       (|mkAlistOfExplicitCategoryOps| |cat|)))))
            (SETQ |bfVar#52| (CDR |bfVar#52|))))
         NIL |l| NIL))
       ((AND (CONSP |target|) (EQ (CAR |target|) 'CATEGORY)
             (PROGN
              (SETQ |ISTMP#1| (CDR |target|))
              (AND (CONSP |ISTMP#1|) (PROGN (SETQ |l| (CDR |ISTMP#1|)) #1#))))
        (PROGN
         (SETQ |l| (|flattenSignatureList| (CONS 'PROGN |l|)))
         (SETQ |u|
                 ((LAMBDA (|bfVar#55| |bfVar#54| |x|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#54|)
                           (PROGN (SETQ |x| (CAR |bfVar#54|)) NIL))
                       (RETURN (NREVERSE |bfVar#55|)))
                      (#1#
                       (AND (CONSP |x|) (EQ (CAR |x|) 'SIGNATURE)
                            (PROGN
                             (SETQ |ISTMP#1| (CDR |x|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN
                                   (SETQ |op| (CAR |ISTMP#1|))
                                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                   (AND (CONSP |ISTMP#2|)
                                        (PROGN
                                         (SETQ |sig| (CAR |ISTMP#2|))
                                         #1#)))))
                            (SETQ |bfVar#55|
                                    (CONS
                                     (CONS
                                      (|mkAlistOfExplicitCategoryOps,atomizeOp|
                                       |op|)
                                      |sig|)
                                     |bfVar#55|)))))
                     (SETQ |bfVar#54| (CDR |bfVar#54|))))
                  NIL |l| NIL))
         (SETQ |opList| (REMDUP (ASSOCLEFT |u|)))
         ((LAMBDA (|bfVar#57| |bfVar#56| |x|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#56|) (PROGN (SETQ |x| (CAR |bfVar#56|)) NIL))
               (RETURN (NREVERSE |bfVar#57|)))
              (#1#
               (SETQ |bfVar#57|
                       (CONS
                        (CONS |x| (|mkAlistOfExplicitCategoryOps,fn| |x| |u|))
                        |bfVar#57|))))
             (SETQ |bfVar#56| (CDR |bfVar#56|))))
          NIL |opList| NIL)))
       ((|isCategoryForm| |target|) NIL)
       (#1#
        (|keyedSystemError| 'S2GE0016
         (LIST "mkAlistOfExplicitCategoryOps" "bad signature"))))))))
(DEFUN |mkAlistOfExplicitCategoryOps,fn| (|op| |u|)
  (PROG (|ISTMP#1| |a| |b| |c|)
    (RETURN
     (COND
      ((AND (CONSP |u|)
            (PROGN
             (SETQ |ISTMP#1| (CAR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |b| (CDR |ISTMP#1|))
                   #1='T)))
            (PROGN (SETQ |c| (CDR |u|)) #1#))
       (IDENTITY
        (COND
         ((EQUAL |a| |op|)
          (CONS |b| (|mkAlistOfExplicitCategoryOps,fn| |op| |c|)))
         (#1# (|mkAlistOfExplicitCategoryOps,fn| |op| |c|)))))))))
(DEFUN |mkAlistOfExplicitCategoryOps,atomizeOp| (|op|)
  (PROG (|a|)
    (RETURN
     (COND ((ATOM |op|) |op|)
           ((AND (CONSP |op|) (EQ (CDR |op|) NIL)
                 (PROGN (SETQ |a| (CAR |op|)) #1='T))
            |a|)
           (#1#
            (|keyedSystemError| 'S2GE0016
             (LIST "mkAlistOfExplicitCategoryOps" "bad signature")))))))

; flattenSignatureList(x) ==
;   atom x => nil
;   x is ['SIGNATURE,:.] => [x]
;   x is ['IF,cond,b1,b2] =>
;      append(flattenSignatureList b1, flattenSignatureList b2)
;   x is ['PROGN,:l] =>
;      ll:= []
;      for x in l repeat
;         x is ['SIGNATURE,:.] => ll:=cons(x,ll)
;         ll:= append(flattenSignatureList x,ll)
;      ll
;   nil

(DEFUN |flattenSignatureList| (|x|)
  (PROG (|ISTMP#1| |cond| |ISTMP#2| |b1| |ISTMP#3| |b2| |l| |ll|)
    (RETURN
     (COND ((ATOM |x|) NIL)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'SIGNATURE)) (LIST |x|))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'IF)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |cond| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |b1| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |b2| (CAR |ISTMP#3|))
                                    #1='T))))))))
            (APPEND (|flattenSignatureList| |b1|)
                    (|flattenSignatureList| |b2|)))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'PROGN)
                 (PROGN (SETQ |l| (CDR |x|)) #1#))
            (PROGN
             (SETQ |ll| NIL)
             ((LAMBDA (|bfVar#58| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#58|)
                       (PROGN (SETQ |x| (CAR |bfVar#58|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (COND
                    ((AND (CONSP |x|) (EQ (CAR |x|) 'SIGNATURE))
                     (SETQ |ll| (CONS |x| |ll|)))
                    (#1#
                     (SETQ |ll| (APPEND (|flattenSignatureList| |x|) |ll|))))))
                 (SETQ |bfVar#58| (CDR |bfVar#58|))))
              |l| NIL)
             |ll|))
           (#1# NIL)))))

; mkDatabasePred [a,t] ==
;   isCategoryForm(t) => ['ofCategory, a, t]
;   ['ofType,a,t]

(DEFUN |mkDatabasePred| (|bfVar#59|)
  (PROG (|a| |t|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR |bfVar#59|))
      (SETQ |t| (CADR |bfVar#59|))
      (COND ((|isCategoryForm| |t|) (LIST '|ofCategory| |a| |t|))
            ('T (LIST '|ofType| |a| |t|)))))))

; formal2Pattern x ==
;   SUBLIS(pairList($FormalMapVariableList,rest $PatternVariableList),x)

(DEFUN |formal2Pattern| (|x|)
  (PROG ()
    (RETURN
     (SUBLIS (|pairList| |$FormalMapVariableList| (CDR |$PatternVariableList|))
             |x|))))

; updateDatabase(cname) ==
;  -- for now in NRUNTIME do database update only if forced
;   not $forceDatabaseUpdate => nil
;   clearClams()
;   clearAllSlams []
;   if constructor? cname then
;     if GET(cname, 'LOADED) then
;       clearConstructorCaches()

(DEFUN |updateDatabase| (|cname|)
  (PROG ()
    (RETURN
     (COND ((NULL |$forceDatabaseUpdate|) NIL)
           ('T
            (PROGN
             (|clearClams|)
             (|clearAllSlams| NIL)
             (COND
              ((|constructor?| |cname|)
               (COND ((GET |cname| 'LOADED) (|clearConstructorCaches|)))))))))))

; REMOVER(lst,item) ==
;   --destructively removes item from lst
;   not PAIRP lst =>
;     lst=item => nil
;     lst
;   first lst=item => rest lst
;   RPLNODE(lst,REMOVER(first lst,item),REMOVER(rest lst,item))

(DEFUN REMOVER (|lst| |item|)
  (PROG ()
    (RETURN
     (COND
      ((NULL (CONSP |lst|)) (COND ((EQUAL |lst| |item|) NIL) (#1='T |lst|)))
      ((EQUAL (CAR |lst|) |item|) (CDR |lst|))
      (#1#
       (RPLNODE |lst| (REMOVER (CAR |lst|) |item|)
        (REMOVER (CDR |lst|) |item|)))))))

; allLASSOCs(op,alist) ==
;   [value for [key,:value] in alist | key = op]

(DEFUN |allLASSOCs| (|op| |alist|)
  (PROG (|key| |value|)
    (RETURN
     ((LAMBDA (|bfVar#62| |bfVar#61| |bfVar#60|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#61|)
               (PROGN (SETQ |bfVar#60| (CAR |bfVar#61|)) NIL))
           (RETURN (NREVERSE |bfVar#62|)))
          (#1='T
           (AND (CONSP |bfVar#60|)
                (PROGN
                 (SETQ |key| (CAR |bfVar#60|))
                 (SETQ |value| (CDR |bfVar#60|))
                 #1#)
                (EQUAL |key| |op|)
                (SETQ |bfVar#62| (CONS |value| |bfVar#62|)))))
         (SETQ |bfVar#61| (CDR |bfVar#61|))))
      NIL |alist| NIL))))

; getOplistForConstructorForm (form := [op,:argl]) ==
;   --  The new form is an op-Alist which has entries (<op> . signature-Alist)
;   --    where signature-Alist has entries (<signature> . item)
;   --      where item has form (<slotNumber> <condition> <kind>)
;   --        where <kind> =  ELT | CONST | (XLAM..) ..
;   pairlis:= [[fv,:arg] for fv in $FormalMapVariableList for arg in argl]
;   opAlist := getOperationAlistFromLisplib op
;   [:getOplistWithUniqueSignatures(op,pairlis,signatureAlist)
;       for [op,:signatureAlist] in opAlist]

(DEFUN |getOplistForConstructorForm| (|form|)
  (PROG (|op| |argl| |pairlis| |opAlist| |signatureAlist|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (SETQ |pairlis|
              ((LAMBDA (|bfVar#65| |bfVar#63| |fv| |bfVar#64| |arg|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#63|)
                        (PROGN (SETQ |fv| (CAR |bfVar#63|)) NIL)
                        (ATOM |bfVar#64|)
                        (PROGN (SETQ |arg| (CAR |bfVar#64|)) NIL))
                    (RETURN (NREVERSE |bfVar#65|)))
                   (#1='T
                    (SETQ |bfVar#65| (CONS (CONS |fv| |arg|) |bfVar#65|))))
                  (SETQ |bfVar#63| (CDR |bfVar#63|))
                  (SETQ |bfVar#64| (CDR |bfVar#64|))))
               NIL |$FormalMapVariableList| NIL |argl| NIL))
      (SETQ |opAlist| (|getOperationAlistFromLisplib| |op|))
      ((LAMBDA (|bfVar#68| |bfVar#67| |bfVar#66|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#67|)
                (PROGN (SETQ |bfVar#66| (CAR |bfVar#67|)) NIL))
            (RETURN (NREVERSE |bfVar#68|)))
           (#1#
            (AND (CONSP |bfVar#66|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#66|))
                  (SETQ |signatureAlist| (CDR |bfVar#66|))
                  #1#)
                 (SETQ |bfVar#68|
                         (APPEND
                          (REVERSE
                           (|getOplistWithUniqueSignatures| |op| |pairlis|
                            |signatureAlist|))
                          |bfVar#68|)))))
          (SETQ |bfVar#67| (CDR |bfVar#67|))))
       NIL |opAlist| NIL)))))

; getOplistWithUniqueSignatures(op,pairlis,signatureAlist) ==
;   alist:= nil
;   for [sig, :[slotNumber, pred, kind]] in signatureAlist repeat
;       key := SUBLIS(pairlis, [op, sig])
;       term := assoc(key, alist)
;       if null term then
;           alist := cons([key, pred, [kind, nil, slotNumber]], alist)
;       else
;           value := rest term
;           oldpred := first value
;           newpred :=
;               oldpred = true or pred = true => true
;               oldpred = pred => oldpred
;               oldpred is ['OR, :predl] =>
;                   member(pred, predl) => oldpred
;                   ['OR, pred, :predl]
;               ['OR, pred, oldpred]
;           RPLACA(value, newpred)
;   alist

(DEFUN |getOplistWithUniqueSignatures| (|op| |pairlis| |signatureAlist|)
  (PROG (|alist| |sig| |ISTMP#1| |slotNumber| |ISTMP#2| |pred| |ISTMP#3| |kind|
         |key| |term| |value| |oldpred| |predl| |newpred|)
    (RETURN
     (PROGN
      (SETQ |alist| NIL)
      ((LAMBDA (|bfVar#70| |bfVar#69|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#70|)
                (PROGN (SETQ |bfVar#69| (CAR |bfVar#70|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#69|)
                 (PROGN
                  (SETQ |sig| (CAR |bfVar#69|))
                  (SETQ |ISTMP#1| (CDR |bfVar#69|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |slotNumber| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|)
                             (PROGN
                              (SETQ |pred| (CAR |ISTMP#2|))
                              (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                              (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                   (PROGN
                                    (SETQ |kind| (CAR |ISTMP#3|))
                                    #1#)))))))
                 (PROGN
                  (SETQ |key| (SUBLIS |pairlis| (LIST |op| |sig|)))
                  (SETQ |term| (|assoc| |key| |alist|))
                  (COND
                   ((NULL |term|)
                    (SETQ |alist|
                            (CONS
                             (LIST |key| |pred| (LIST |kind| NIL |slotNumber|))
                             |alist|)))
                   (#1# (SETQ |value| (CDR |term|))
                    (SETQ |oldpred| (CAR |value|))
                    (SETQ |newpred|
                            (COND ((OR (EQUAL |oldpred| T) (EQUAL |pred| T)) T)
                                  ((EQUAL |oldpred| |pred|) |oldpred|)
                                  ((AND (CONSP |oldpred|)
                                        (EQ (CAR |oldpred|) 'OR)
                                        (PROGN
                                         (SETQ |predl| (CDR |oldpred|))
                                         #1#))
                                   (COND ((|member| |pred| |predl|) |oldpred|)
                                         (#1#
                                          (CONS 'OR (CONS |pred| |predl|)))))
                                  (#1# (LIST 'OR |pred| |oldpred|))))
                    (RPLACA |value| |newpred|)))))))
          (SETQ |bfVar#70| (CDR |bfVar#70|))))
       |signatureAlist| NIL)
      |alist|))))

; dropPrefix(fn) ==
;   member(fn.0,[char "?",char "-",char "+"]) => SUBSTRING(fn,1,nil)
;   fn

(DEFUN |dropPrefix| (|fn|)
  (PROG ()
    (RETURN
     (COND
      ((|member| (ELT |fn| 0) (LIST (|char| '?) (|char| '-) (|char| '+)))
       (SUBSTRING |fn| 1 NIL))
      ('T |fn|)))))

; DEFPARAMETER($globalExposureHash, nil)

(DEFPARAMETER |$globalExposureHash| NIL)

; initExposureHash() ==
;     $globalExposureHash := MAKE_HASHTABLE('EQUAL)
;     for grdata in $globalExposureGroupAlist repeat
;         group := first(grdata)
;         alist := rest(grdata)
;         for pair in alist repeat
;             name := first(pair)
;             ogr := HGET($globalExposureHash, name)
;             HPUT($globalExposureHash, name, [group, :ogr])

(DEFUN |initExposureHash| ()
  (PROG (|ogr| |name| |alist| |group|)
    (RETURN
     (PROGN
      (SETQ |$globalExposureHash| (MAKE_HASHTABLE 'EQUAL))
      ((LAMBDA (|bfVar#71| |grdata|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#71|) (PROGN (SETQ |grdata| (CAR |bfVar#71|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |group| (CAR |grdata|))
             (SETQ |alist| (CDR |grdata|))
             ((LAMBDA (|bfVar#72| |pair|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#72|)
                       (PROGN (SETQ |pair| (CAR |bfVar#72|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |name| (CAR |pair|))
                    (SETQ |ogr| (HGET |$globalExposureHash| |name|))
                    (HPUT |$globalExposureHash| |name| (CONS |group| |ogr|)))))
                 (SETQ |bfVar#72| (CDR |bfVar#72|))))
              |alist| NIL))))
          (SETQ |bfVar#71| (CDR |bfVar#71|))))
       |$globalExposureGroupAlist| NIL)))))

; isExposedConstructor name ==
;   -- this function checks the local exposure data in the frame to
;   -- see if the given constructor is exposed. The format of
;   -- $localExposureData is a vector with
;   --   slot 0: list of groups exposed in the frame
;   --   slot 1: list of constructors explicitly exposed
;   --   slot 2: list of constructors explicitly hidden
;   -- check if it is explicitly hidden
;   MEMQ(name,'(Union Record Mapping)) => true
;   MEMQ(name,$localExposureData.2) => false
;   -- check if it is explicitly exposed
;   MEMQ(name,$localExposureData.1) => true
;   -- check if it is in an exposed group
;   found := NIL
;   if null($globalExposureHash) then
;       initExposureHash()
;   exd := HGET($globalExposureHash, name)
;   for g in $localExposureData.0 while not found repeat
;       null(g in exd) => 'iterate
;       found := true
;   found

(DEFUN |isExposedConstructor| (|name|)
  (PROG (|found| |exd|)
    (RETURN
     (COND ((MEMQ |name| '(|Union| |Record| |Mapping|)) T)
           ((MEMQ |name| (ELT |$localExposureData| 2)) NIL)
           ((MEMQ |name| (ELT |$localExposureData| 1)) T)
           (#1='T
            (PROGN
             (SETQ |found| NIL)
             (COND ((NULL |$globalExposureHash|) (|initExposureHash|)))
             (SETQ |exd| (HGET |$globalExposureHash| |name|))
             ((LAMBDA (|bfVar#73| |g|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#73|)
                       (PROGN (SETQ |g| (CAR |bfVar#73|)) NIL) |found|)
                   (RETURN NIL))
                  (#1#
                   (COND ((NULL (|member| |g| |exd|)) '|iterate|)
                         (#1# (SETQ |found| T)))))
                 (SETQ |bfVar#73| (CDR |bfVar#73|))))
              (ELT |$localExposureData| 0) NIL)
             |found|))))))

; displayExposedGroups() ==
;   sayKeyedMsg("S2IZ0049A",[$interpreterFrameName])
;   if null $localExposureData.0
;     then centerAndHighlight '"there are no exposed groups"
;     else for g in $localExposureData.0 repeat
;       centerAndHighlight g

(DEFUN |displayExposedGroups| ()
  (PROG ()
    (RETURN
     (PROGN
      (|sayKeyedMsg| 'S2IZ0049A (LIST |$interpreterFrameName|))
      (COND
       ((NULL (ELT |$localExposureData| 0))
        (|centerAndHighlight| "there are no exposed groups"))
       (#1='T
        ((LAMBDA (|bfVar#74| |g|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#74|) (PROGN (SETQ |g| (CAR |bfVar#74|)) NIL))
              (RETURN NIL))
             (#1# (|centerAndHighlight| |g|)))
            (SETQ |bfVar#74| (CDR |bfVar#74|))))
         (ELT |$localExposureData| 0) NIL)))))))

; displayExposedConstructors() ==
;   sayKeyedMsg("S2IZ0049B",NIL)
;   if null $localExposureData.1
;     then centerAndHighlight
;       '"there are no explicitly exposed constructors"
;     else for c in $localExposureData.1 repeat
;       centerAndHighlight c

(DEFUN |displayExposedConstructors| ()
  (PROG ()
    (RETURN
     (PROGN
      (|sayKeyedMsg| 'S2IZ0049B NIL)
      (COND
       ((NULL (ELT |$localExposureData| 1))
        (|centerAndHighlight| "there are no explicitly exposed constructors"))
       (#1='T
        ((LAMBDA (|bfVar#75| |c|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#75|) (PROGN (SETQ |c| (CAR |bfVar#75|)) NIL))
              (RETURN NIL))
             (#1# (|centerAndHighlight| |c|)))
            (SETQ |bfVar#75| (CDR |bfVar#75|))))
         (ELT |$localExposureData| 1) NIL)))))))

; displayHiddenConstructors() ==
;   sayKeyedMsg("S2IZ0049C",NIL)
;   if null $localExposureData.2
;     then centerAndHighlight
;       '"there are no explicitly hidden constructors"
;     else for c in $localExposureData.2 repeat
;       centerAndHighlight c

(DEFUN |displayHiddenConstructors| ()
  (PROG ()
    (RETURN
     (PROGN
      (|sayKeyedMsg| 'S2IZ0049C NIL)
      (COND
       ((NULL (ELT |$localExposureData| 2))
        (|centerAndHighlight| "there are no explicitly hidden constructors"))
       (#1='T
        ((LAMBDA (|bfVar#76| |c|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#76|) (PROGN (SETQ |c| (CAR |bfVar#76|)) NIL))
              (RETURN NIL))
             (#1# (|centerAndHighlight| |c|)))
            (SETQ |bfVar#76| (CDR |bfVar#76|))))
         (ELT |$localExposureData| 2) NIL)))))))

; getOperationAlistFromLisplib x ==
;     u := GETDATABASE(x, 'OPERATIONALIST)
;     --  u := removeZeroOneDestructively u
;     null u => u          -- this can happen for Object
;     CAAR u = '_$unique => rest u
;     f := addConsDB '(NIL T ELT)
;     for [op, :sigList] in u repeat
;         for items in tails sigList repeat
;             [sig, :r] := first items
;             if r is [., :s] then
;                 if s is [., :t] then
;                     if t is [.] then nil
;                     else RPLACD(s, QCDDR f)
;                 else RPLACD(r, QCDR f)
;             else RPLACD(first items, f)
;             RPLACA(items, addConsDB first items)
;     u and markUnique u

(DEFUN |getOperationAlistFromLisplib| (|x|)
  (PROG (|u| |f| |op| |sigList| |LETTMP#1| |sig| |r| |s| |t|)
    (RETURN
     (PROGN
      (SETQ |u| (GETDATABASE |x| 'OPERATIONALIST))
      (COND ((NULL |u|) |u|) ((EQ (CAAR |u|) '|$unique|) (CDR |u|))
            (#1='T
             (PROGN
              (SETQ |f| (|addConsDB| '(NIL T ELT)))
              ((LAMBDA (|bfVar#78| |bfVar#77|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#78|)
                        (PROGN (SETQ |bfVar#77| (CAR |bfVar#78|)) NIL))
                    (RETURN NIL))
                   (#1#
                    (AND (CONSP |bfVar#77|)
                         (PROGN
                          (SETQ |op| (CAR |bfVar#77|))
                          (SETQ |sigList| (CDR |bfVar#77|))
                          #1#)
                         ((LAMBDA (|items|)
                            (LOOP
                             (COND ((ATOM |items|) (RETURN NIL))
                                   (#1#
                                    (PROGN
                                     (SETQ |LETTMP#1| (CAR |items|))
                                     (SETQ |sig| (CAR |LETTMP#1|))
                                     (SETQ |r| (CDR |LETTMP#1|))
                                     (COND
                                      ((AND (CONSP |r|)
                                            (PROGN (SETQ |s| (CDR |r|)) #1#))
                                       (COND
                                        ((AND (CONSP |s|)
                                              (PROGN (SETQ |t| (CDR |s|)) #1#))
                                         (COND
                                          ((AND (CONSP |t|) (EQ (CDR |t|) NIL))
                                           NIL)
                                          (#1# (RPLACD |s| (QCDDR |f|)))))
                                        (#1# (RPLACD |r| (QCDR |f|)))))
                                      (#1# (RPLACD (CAR |items|) |f|)))
                                     (RPLACA |items|
                                             (|addConsDB| (CAR |items|))))))
                             (SETQ |items| (CDR |items|))))
                          |sigList|))))
                  (SETQ |bfVar#78| (CDR |bfVar#78|))))
               |u| NIL)
              (AND |u| (|markUnique| |u|)))))))))

; markUnique x ==
;     u := first x
;     RPLACA(x, '(_$unique))
;     RPLACD(x, [u, :rest x])
;     rest x

(DEFUN |markUnique| (|x|)
  (PROG (|u|)
    (RETURN
     (PROGN
      (SETQ |u| (CAR |x|))
      (RPLACA |x| '(|$unique|))
      (RPLACD |x| (CONS |u| (CDR |x|)))
      (CDR |x|)))))

; addConsDB x == x

(DEFUN |addConsDB| (|x|) (PROG () (RETURN |x|)))

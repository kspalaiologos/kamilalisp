
; )package "BOOT"

(IN-PACKAGE "BOOT")

; $returnNowhereFromGoGet := false

(EVAL-WHEN (EVAL LOAD) (SETQ |$returnNowhereFromGoGet| NIL))

; showSummary dom ==
;   showPredicates dom
;   showAttributes dom
;   showFrom dom
;   showImp dom

(DEFUN |showSummary| (|dom|)
  (PROG ()
    (RETURN
     (PROGN
      (|showPredicates| |dom|)
      (|showAttributes| |dom|)
      (|showFrom| |dom|)
      (|showImp| |dom|)))))

; showImp(dom,:options) ==
;   sayBrightly '"-------------Operation summary-----------------"
;   missingOnlyFlag := IFCAR options
;   domainForm := devaluate dom
;   [nam, :.] := domainForm
;   $predicateList: local := GETDATABASE(nam,'PREDICATES)
;   u := getDomainOpTable(dom,true)
;   --sort into 4 groups: domain exports, unexports, default exports, others
;   for (x := [.,.,:key]) in u repeat
;     key = domainForm => domexports := [x,:domexports]
;     FIXP key => unexports := [x,:unexports]
;     isDefaultPackageForm? key => defexports := [x,:defexports]
;     key = 'nowhere => nowheres := [x,:nowheres]
;     key = 'constant => constants := [x,:constants]
;     others := [x,:others]   --add chain domains go here
;   sayBrightly
;     nowheres => ['"Functions exported but not implemented by",
;       :bright form2String domainForm,'":"]
;     [:bright form2String domainForm,'"implements all exported operations"]
;   showDomainsOp1(nowheres,'nowhere)
;   missingOnlyFlag => 'done
;
;   --first display those exported by the domain, then add chain guys
;   u := [:domexports,:constants,:SORTBY('CDDR,others)]
;   while u repeat
;     [., ., :key] := first u
;     sayBrightly
;       key = 'constant =>
;         ["Constants implemented by",:bright form2String key,'":"]
;       ["Functions implemented by",:bright form2String key,'":"]
;     u := showDomainsOp1(u,key)
;   u := SORTBY('CDDR,defexports)
;   while u repeat
;     [., ., :key] := first u
;     defop := INTERN(SUBSTRING((s := PNAME first key), 0, MAXINDEX s))
;     domainForm := [defop,:CDDR key]
;     sayBrightly ["Default functions from",:bright form2String domainForm,'":"]
;     u := showDomainsOp1(u,key)
;   u := SORTBY('CDDR,unexports)
;   while u repeat
;     [., ., :key] := first u
;     sayBrightly ["Not exported: "]
;     u := showDomainsOp1(u,key)

(DEFUN |showImp| (|dom| &REST |options|)
  (PROG (|$predicateList| |defop| |s| |LETTMP#1| |others| |constants|
         |nowheres| |defexports| |unexports| |domexports| |key| |ISTMP#1| |u|
         |nam| |domainForm| |missingOnlyFlag|)
    (DECLARE (SPECIAL |$predicateList|))
    (RETURN
     (PROGN
      (|sayBrightly| "-------------Operation summary-----------------")
      (SETQ |missingOnlyFlag| (IFCAR |options|))
      (SETQ |domainForm| (|devaluate| |dom|))
      (SETQ |nam| (CAR |domainForm|))
      (SETQ |$predicateList| (GETDATABASE |nam| 'PREDICATES))
      (SETQ |u| (|getDomainOpTable| |dom| T))
      ((LAMBDA (|bfVar#1| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |x|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |key| (CDR |ISTMP#1|)) #1#)))
                 (COND
                  ((EQUAL |key| |domainForm|)
                   (SETQ |domexports| (CONS |x| |domexports|)))
                  ((FIXP |key|) (SETQ |unexports| (CONS |x| |unexports|)))
                  ((|isDefaultPackageForm?| |key|)
                   (SETQ |defexports| (CONS |x| |defexports|)))
                  ((EQ |key| '|nowhere|)
                   (SETQ |nowheres| (CONS |x| |nowheres|)))
                  ((EQ |key| '|constant|)
                   (SETQ |constants| (CONS |x| |constants|)))
                  (#1# (SETQ |others| (CONS |x| |others|)))))))
          (SETQ |bfVar#1| (CDR |bfVar#1|))))
       |u| NIL)
      (|sayBrightly|
       (COND
        (|nowheres|
         (CONS "Functions exported but not implemented by"
               (APPEND (|bright| (|form2String| |domainForm|))
                       (CONS ":" NIL))))
        (#1#
         (APPEND (|bright| (|form2String| |domainForm|))
                 (CONS "implements all exported operations" NIL)))))
      (|showDomainsOp1| |nowheres| '|nowhere|)
      (COND (|missingOnlyFlag| '|done|)
            (#1#
             (PROGN
              (SETQ |u|
                      (APPEND |domexports|
                              (APPEND |constants| (SORTBY 'CDDR |others|))))
              ((LAMBDA ()
                 (LOOP
                  (COND ((NOT |u|) (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |LETTMP#1| (CAR |u|))
                          (SETQ |key| (CDDR |LETTMP#1|))
                          (|sayBrightly|
                           (COND
                            ((EQ |key| '|constant|)
                             (CONS '|Constants implemented by|
                                   (APPEND (|bright| (|form2String| |key|))
                                           (CONS ":" NIL))))
                            (#1#
                             (CONS '|Functions implemented by|
                                   (APPEND (|bright| (|form2String| |key|))
                                           (CONS ":" NIL))))))
                          (SETQ |u| (|showDomainsOp1| |u| |key|))))))))
              (SETQ |u| (SORTBY 'CDDR |defexports|))
              ((LAMBDA ()
                 (LOOP
                  (COND ((NOT |u|) (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |LETTMP#1| (CAR |u|))
                          (SETQ |key| (CDDR |LETTMP#1|))
                          (SETQ |defop|
                                  (INTERN
                                   (SUBSTRING (SETQ |s| (PNAME (CAR |key|))) 0
                                              (MAXINDEX |s|))))
                          (SETQ |domainForm| (CONS |defop| (CDDR |key|)))
                          (|sayBrightly|
                           (CONS '|Default functions from|
                                 (APPEND
                                  (|bright| (|form2String| |domainForm|))
                                  (CONS ":" NIL))))
                          (SETQ |u| (|showDomainsOp1| |u| |key|))))))))
              (SETQ |u| (SORTBY 'CDDR |unexports|))
              ((LAMBDA ()
                 (LOOP
                  (COND ((NOT |u|) (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |LETTMP#1| (CAR |u|))
                          (SETQ |key| (CDDR |LETTMP#1|))
                          (|sayBrightly| (LIST '|Not exported: |))
                          (SETQ |u| (|showDomainsOp1| |u| |key|)))))))))))))))

; showFrom(D,:option) ==
;   ops := IFCAR option
;   alist := nil
;   domainForm := devaluate D
;   [nam,:.] := domainForm
;   $predicateList: local := GETDATABASE(nam,'PREDICATES)
;   for (opSig := [op,sig]) in getDomainSigs1(D,ops) repeat
;     u := from?(D,op,sig)
;     x := ASSOC(u,alist) => RPLACD(x,[opSig,:rest x])
;     alist := [[u,opSig],:alist]
;   for [conform,:l] in alist repeat
;     sayBrightly concat('"From ",form2String conform,'":")
;     for [op,sig] in l repeat sayBrightly ['"   ",:formatOpSignature(op,sig)]

(DEFUN |showFrom| (D &REST |option|)
  (PROG (|$predicateList| |l| |conform| |x| |u| |sig| |ISTMP#1| |op| |nam|
         |domainForm| |alist| |ops|)
    (DECLARE (SPECIAL |$predicateList|))
    (RETURN
     (PROGN
      (SETQ |ops| (IFCAR |option|))
      (SETQ |alist| NIL)
      (SETQ |domainForm| (|devaluate| D))
      (SETQ |nam| (CAR |domainForm|))
      (SETQ |$predicateList| (GETDATABASE |nam| 'PREDICATES))
      ((LAMBDA (|bfVar#2| |opSig|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#2|) (PROGN (SETQ |opSig| (CAR |bfVar#2|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |opSig|)
                 (PROGN
                  (SETQ |op| (CAR |opSig|))
                  (SETQ |ISTMP#1| (CDR |opSig|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |sig| (CAR |ISTMP#1|)) #1#)))
                 (PROGN
                  (SETQ |u| (|from?| D |op| |sig|))
                  (COND
                   ((SETQ |x| (ASSOC |u| |alist|))
                    (RPLACD |x| (CONS |opSig| (CDR |x|))))
                   (#1# (SETQ |alist| (CONS (LIST |u| |opSig|) |alist|))))))))
          (SETQ |bfVar#2| (CDR |bfVar#2|))))
       (|getDomainSigs1| D |ops|) NIL)
      ((LAMBDA (|bfVar#4| |bfVar#3|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#4|) (PROGN (SETQ |bfVar#3| (CAR |bfVar#4|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#3|)
                 (PROGN
                  (SETQ |conform| (CAR |bfVar#3|))
                  (SETQ |l| (CDR |bfVar#3|))
                  #1#)
                 (PROGN
                  (|sayBrightly|
                   (|concat| "From " (|form2String| |conform|) ":"))
                  ((LAMBDA (|bfVar#6| |bfVar#5|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#6|)
                            (PROGN (SETQ |bfVar#5| (CAR |bfVar#6|)) NIL))
                        (RETURN NIL))
                       (#1#
                        (AND (CONSP |bfVar#5|)
                             (PROGN
                              (SETQ |op| (CAR |bfVar#5|))
                              (SETQ |ISTMP#1| (CDR |bfVar#5|))
                              (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                   (PROGN (SETQ |sig| (CAR |ISTMP#1|)) #1#)))
                             (|sayBrightly|
                              (CONS "   " (|formatOpSignature| |op| |sig|))))))
                      (SETQ |bfVar#6| (CDR |bfVar#6|))))
                   |l| NIL)))))
          (SETQ |bfVar#4| (CDR |bfVar#4|))))
       |alist| NIL)))))

; getDomainOps D ==
;   domname := D.0
;   conname := first domname
;   $predicateList: local := GETDATABASE(conname,'PREDICATES)
;   REMDUP listSort(function GLESSEQP,ASSOCLEFT getDomainOpTable(D,nil))

(DEFUN |getDomainOps| (D)
  (PROG (|$predicateList| |conname| |domname|)
    (DECLARE (SPECIAL |$predicateList|))
    (RETURN
     (PROGN
      (SETQ |domname| (ELT D 0))
      (SETQ |conname| (CAR |domname|))
      (SETQ |$predicateList| (GETDATABASE |conname| 'PREDICATES))
      (REMDUP
       (|listSort| #'GLESSEQP (ASSOCLEFT (|getDomainOpTable| D NIL))))))))

; getDomainSigs(D,:option) ==
;   domname := D.0
;   conname := first domname
;   $predicateList: local := GETDATABASE(conname,'PREDICATES)
;   getDomainSigs1(D,first option)

(DEFUN |getDomainSigs| (D &REST |option|)
  (PROG (|$predicateList| |conname| |domname|)
    (DECLARE (SPECIAL |$predicateList|))
    (RETURN
     (PROGN
      (SETQ |domname| (ELT D 0))
      (SETQ |conname| (CAR |domname|))
      (SETQ |$predicateList| (GETDATABASE |conname| 'PREDICATES))
      (|getDomainSigs1| D (CAR |option|))))))

; getDomainSigs1(D,ops) == listSort(function GLESSEQP,u) where
;   u == [x for x in getDomainOpTable(D, nil) |
;           null ops or MEMQ(first x, ops)]

(DEFUN |getDomainSigs1| (D |ops|)
  (PROG ()
    (RETURN
     (|listSort| #'GLESSEQP
      ((LAMBDA (|bfVar#8| |bfVar#7| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#7|) (PROGN (SETQ |x| (CAR |bfVar#7|)) NIL))
            (RETURN (NREVERSE |bfVar#8|)))
           ('T
            (AND (OR (NULL |ops|) (MEMQ (CAR |x|) |ops|))
                 (SETQ |bfVar#8| (CONS |x| |bfVar#8|)))))
          (SETQ |bfVar#7| (CDR |bfVar#7|))))
       NIL (|getDomainOpTable| D NIL) NIL)))))

; getDomainDocs(D,:option) ==
;   domname := D.0
;   conname := first domname
;   $predicateList: local := GETDATABASE(conname,'PREDICATES)
;   ops := IFCAR option
;   [[op,sig,:getInheritanceByDoc(D,op,sig)] for [op,sig] in getDomainSigs1(D,ops)]

(DEFUN |getDomainDocs| (D &REST |option|)
  (PROG (|$predicateList| |sig| |ISTMP#1| |op| |ops| |conname| |domname|)
    (DECLARE (SPECIAL |$predicateList|))
    (RETURN
     (PROGN
      (SETQ |domname| (ELT D 0))
      (SETQ |conname| (CAR |domname|))
      (SETQ |$predicateList| (GETDATABASE |conname| 'PREDICATES))
      (SETQ |ops| (IFCAR |option|))
      ((LAMBDA (|bfVar#11| |bfVar#10| |bfVar#9|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#10|)
                (PROGN (SETQ |bfVar#9| (CAR |bfVar#10|)) NIL))
            (RETURN (NREVERSE |bfVar#11|)))
           (#1='T
            (AND (CONSP |bfVar#9|)
                 (PROGN
                  (SETQ |op| (CAR |bfVar#9|))
                  (SETQ |ISTMP#1| (CDR |bfVar#9|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |sig| (CAR |ISTMP#1|)) #1#)))
                 (SETQ |bfVar#11|
                         (CONS
                          (CONS |op|
                                (CONS |sig|
                                      (|getInheritanceByDoc| D |op| |sig|)))
                          |bfVar#11|)))))
          (SETQ |bfVar#10| (CDR |bfVar#10|))))
       NIL (|getDomainSigs1| D |ops|) NIL)))))

; from?(D, op, sig) == IFCAR IFCDR getInheritanceByDoc(D, op, sig)

(DEFUN |from?| (D |op| |sig|)
  (PROG () (RETURN (IFCAR (IFCDR (|getInheritanceByDoc| D |op| |sig|))))))

; getExtensionsOfDomain domain ==
;   u := getDomainExtensionsOfDomain domain
;   cats := getCategoriesOfDomain domain
;   for x in u repeat
;     cats := union(cats,getCategoriesOfDomain EVAL x)
;   [:u,:cats]

(DEFUN |getExtensionsOfDomain| (|domain|)
  (PROG (|u| |cats|)
    (RETURN
     (PROGN
      (SETQ |u| (|getDomainExtensionsOfDomain| |domain|))
      (SETQ |cats| (|getCategoriesOfDomain| |domain|))
      ((LAMBDA (|bfVar#12| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#12|) (PROGN (SETQ |x| (CAR |bfVar#12|)) NIL))
            (RETURN NIL))
           ('T
            (SETQ |cats|
                    (|union| |cats| (|getCategoriesOfDomain| (EVAL |x|))))))
          (SETQ |bfVar#12| (CDR |bfVar#12|))))
       |u| NIL)
      (APPEND |u| |cats|)))))

; getDomainExtensionsOfDomain domain ==
;   acc := nil
;   d := domain
;   while (u := devaluateSlotDomain(5,d)) repeat
;     acc := [u,:acc]
;     d := EVAL u
;   acc

(DEFUN |getDomainExtensionsOfDomain| (|domain|)
  (PROG (|acc| |d| |u|)
    (RETURN
     (PROGN
      (SETQ |acc| NIL)
      (SETQ |d| |domain|)
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (SETQ |u| (|devaluateSlotDomain| 5 |d|))) (RETURN NIL))
                ('T
                 (PROGN
                  (SETQ |acc| (CONS |u| |acc|))
                  (SETQ |d| (EVAL |u|))))))))
      |acc|))))

; devaluateSlotDomain(u,dollar) ==
;   u = '$ => devaluate dollar
;   FIXP u and VECP (y := dollar.u) => devaluate y
;   u is ['NRTEVAL,y] => MKQ eval y
;   u is ['QUOTE,y] => u
;   u is [op,:argl] => [op,:[devaluateSlotDomain(x,dollar) for x in argl]]
;   devaluate evalSlotDomain(u,dollar)

(DEFUN |devaluateSlotDomain| (|u| |dollar|)
  (PROG (|y| |ISTMP#1| |op| |argl|)
    (RETURN
     (COND ((EQ |u| '$) (|devaluate| |dollar|))
           ((AND (FIXP |u|) (VECP (SETQ |y| (ELT |dollar| |u|))))
            (|devaluate| |y|))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'NRTEVAL)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1='T))))
            (MKQ (|eval| |y|)))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'QUOTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
            |u|)
           ((AND (CONSP |u|)
                 (PROGN (SETQ |op| (CAR |u|)) (SETQ |argl| (CDR |u|)) #1#))
            (CONS |op|
                  ((LAMBDA (|bfVar#14| |bfVar#13| |x|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#13|)
                            (PROGN (SETQ |x| (CAR |bfVar#13|)) NIL))
                        (RETURN (NREVERSE |bfVar#14|)))
                       (#1#
                        (SETQ |bfVar#14|
                                (CONS (|devaluateSlotDomain| |x| |dollar|)
                                      |bfVar#14|))))
                      (SETQ |bfVar#13| (CDR |bfVar#13|))))
                   NIL |argl| NIL)))
           (#1# (|devaluate| (|evalSlotDomain| |u| |dollar|)))))))

; getCategoriesOfDomain domain ==
;   predkeyVec := domain.4.0
;   catforms := CADR domain.4
;   [fn for i in 0..MAXINDEX predkeyVec | test] where
;      test == predkeyVec.i and
;        (x := catforms . i) isnt ['DomainSubstitutionMacro,:.]
;      fn ==
;        VECP x => devaluate x
;        devaluateSlotDomain(x,domain)

(DEFUN |getCategoriesOfDomain| (|domain|)
  (PROG (|predkeyVec| |catforms| |x| |ISTMP#1|)
    (RETURN
     (PROGN
      (SETQ |predkeyVec| (ELT (ELT |domain| 4) 0))
      (SETQ |catforms| (CADR (ELT |domain| 4)))
      ((LAMBDA (|bfVar#16| |bfVar#15| |i|)
         (LOOP
          (COND ((> |i| |bfVar#15|) (RETURN (NREVERSE |bfVar#16|)))
                (#1='T
                 (AND
                  (AND (ELT |predkeyVec| |i|)
                       (NOT
                        (PROGN
                         (SETQ |ISTMP#1| (SETQ |x| (ELT |catforms| |i|)))
                         (AND (CONSP |ISTMP#1|)
                              (EQ (CAR |ISTMP#1|)
                                  '|DomainSubstitutionMacro|)))))
                  (SETQ |bfVar#16|
                          (CONS
                           (COND ((VECP |x|) (|devaluate| |x|))
                                 (#1# (|devaluateSlotDomain| |x| |domain|)))
                           |bfVar#16|)))))
          (SETQ |i| (+ |i| 1))))
       NIL (MAXINDEX |predkeyVec|) 0)))))

; getInheritanceByDoc(D,op,sig,:options) ==
; --gets inheritance and documentation information by looking in the LISPLIB
; --for each ancestor of the domain
;   catList := IFCAR options or getExtensionsOfDomain D
;   getDocDomainForOpSig(op,sig,devaluate D,D) or
;     or/[fn for x in catList] or '(NIL NIL)
;       where fn == getDocDomainForOpSig(op,sig,substDomainArgs(D,x),D)

(DEFUN |getInheritanceByDoc| (D |op| |sig| &REST |options|)
  (PROG (|catList|)
    (RETURN
     (PROGN
      (SETQ |catList| (OR (IFCAR |options|) (|getExtensionsOfDomain| D)))
      (OR (|getDocDomainForOpSig| |op| |sig| (|devaluate| D) D)
          ((LAMBDA (|bfVar#18| |bfVar#17| |x|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#17|) (PROGN (SETQ |x| (CAR |bfVar#17|)) NIL))
                (RETURN |bfVar#18|))
               ('T
                (PROGN
                 (SETQ |bfVar#18|
                         (|getDocDomainForOpSig| |op| |sig|
                          (|substDomainArgs| D |x|) D))
                 (COND (|bfVar#18| (RETURN |bfVar#18|))))))
              (SETQ |bfVar#17| (CDR |bfVar#17|))))
           NIL |catList| NIL)
          '(NIL NIL))))))

; getDocDomainForOpSig(op,sig,dollar,D) ==
;   (u := LASSOC(op, GETDATABASE(first dollar, 'DOCUMENTATION)))
;     and (doc := or/[[d,dollar] for [s,:d] in u | compareSig(sig,s,D,dollar)])

(DEFUN |getDocDomainForOpSig| (|op| |sig| |dollar| D)
  (PROG (|u| |s| |d| |doc|)
    (RETURN
     (AND (SETQ |u| (LASSOC |op| (GETDATABASE (CAR |dollar|) 'DOCUMENTATION)))
          (SETQ |doc|
                  ((LAMBDA (|bfVar#21| |bfVar#20| |bfVar#19|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#20|)
                            (PROGN (SETQ |bfVar#19| (CAR |bfVar#20|)) NIL))
                        (RETURN |bfVar#21|))
                       (#1='T
                        (AND (CONSP |bfVar#19|)
                             (PROGN
                              (SETQ |s| (CAR |bfVar#19|))
                              (SETQ |d| (CDR |bfVar#19|))
                              #1#)
                             (|compareSig| |sig| |s| D |dollar|)
                             (PROGN
                              (SETQ |bfVar#21| (LIST |d| |dollar|))
                              (COND (|bfVar#21| (RETURN |bfVar#21|)))))))
                      (SETQ |bfVar#20| (CDR |bfVar#20|))))
                   NIL |u| NIL))))))

; showDomainsOp1(u,key) ==
;   while u and first u is [op, sig, : =key] repeat
;     sayBrightly ['"   ",:formatOpSignature(op,sig)]
;     u := rest u
;   u

(DEFUN |showDomainsOp1| (|u| |key|)
  (PROG (|ISTMP#1| |op| |ISTMP#2| |sig|)
    (RETURN
     (PROGN
      ((LAMBDA ()
         (LOOP
          (COND
           ((NOT
             (AND |u|
                  (PROGN
                   (SETQ |ISTMP#1| (CAR |u|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |op| (CAR |ISTMP#1|))
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1='T)
                              (EQUAL (CDR |ISTMP#2|) |key|)))))))
            (RETURN NIL))
           (#1#
            (PROGN
             (|sayBrightly| (CONS "   " (|formatOpSignature| |op| |sig|)))
             (SETQ |u| (CDR |u|))))))))
      |u|))))

; getDomainRefName(dom,nam) ==
;   PAIRP nam => [getDomainRefName(dom,x) for x in nam]
;   not FIXP nam => nam
;   slot := dom.nam
;   VECP slot => slot.0
;   slot is ['SETELT,:.] => getDomainRefName(dom,getDomainSeteltForm slot)
;   slot

(DEFUN |getDomainRefName| (|dom| |nam|)
  (PROG (|slot|)
    (RETURN
     (COND
      ((CONSP |nam|)
       ((LAMBDA (|bfVar#23| |bfVar#22| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#22|) (PROGN (SETQ |x| (CAR |bfVar#22|)) NIL))
             (RETURN (NREVERSE |bfVar#23|)))
            (#1='T
             (SETQ |bfVar#23|
                     (CONS (|getDomainRefName| |dom| |x|) |bfVar#23|))))
           (SETQ |bfVar#22| (CDR |bfVar#22|))))
        NIL |nam| NIL))
      ((NULL (FIXP |nam|)) |nam|)
      (#1#
       (PROGN
        (SETQ |slot| (ELT |dom| |nam|))
        (COND ((VECP |slot|) (ELT |slot| 0))
              ((AND (CONSP |slot|) (EQ (CAR |slot|) 'SETELT))
               (|getDomainRefName| |dom| (|getDomainSeteltForm| |slot|)))
              (#1# |slot|))))))))

; getDomainSeteltForm ['SETELT,.,.,form] ==
;   form is ['evalSlotDomain,u,d] => devaluateSlotDomain(u,d)
;   VECP form => systemError()
;   form

(DEFUN |getDomainSeteltForm| (|bfVar#24|)
  (PROG (|form| |ISTMP#1| |u| |ISTMP#2| |d|)
    (RETURN
     (PROGN
      (SETQ |form| (CADDDR |bfVar#24|))
      (COND
       ((AND (CONSP |form|) (EQ (CAR |form|) '|evalSlotDomain|)
             (PROGN
              (SETQ |ISTMP#1| (CDR |form|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |u| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN (SETQ |d| (CAR |ISTMP#2|)) #1='T))))))
        (|devaluateSlotDomain| |u| |d|))
       ((VECP |form|) (|systemError|)) (#1# |form|))))))

; showPredicates dom ==
;   sayBrightly '"--------------------Predicate summary-------------------"
;   conname := first(dom.0)
;   predvector := dom.3
;   predicateList := GETDATABASE(conname,'PREDICATES)
;   for i in 1.. for p in predicateList repeat
;     prefix :=
;       testBitVector(predvector,i) => '"true : "
;       '"false: "
;     sayBrightly [prefix,:pred2English p]

(DEFUN |showPredicates| (|dom|)
  (PROG (|conname| |predvector| |predicateList| |prefix|)
    (RETURN
     (PROGN
      (|sayBrightly|
       "--------------------Predicate summary-------------------")
      (SETQ |conname| (CAR (ELT |dom| 0)))
      (SETQ |predvector| (ELT |dom| 3))
      (SETQ |predicateList| (GETDATABASE |conname| 'PREDICATES))
      ((LAMBDA (|i| |bfVar#25| |p|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#25|) (PROGN (SETQ |p| (CAR |bfVar#25|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |prefix|
                     (COND ((|testBitVector| |predvector| |i|) "true : ")
                           (#1# "false: ")))
             (|sayBrightly| (CONS |prefix| (|pred2English| |p|))))))
          (SETQ |i| (+ |i| 1))
          (SETQ |bfVar#25| (CDR |bfVar#25|))))
       1 |predicateList| NIL)))))

; showAttributes dom ==
;   sayBrightly '"--------------------Attribute summary-------------------"
;   conname := first(dom.0)
;   abb := getConstructorAbbreviation conname
;   predvector := dom.3
;   for [a,:p] in dom.2 repeat
;     prefix :=
;       testBitVector(predvector,p) => '"true : "
;       '"false: "
;     sayBrightly concat(prefix,form2String a)

(DEFUN |showAttributes| (|dom|)
  (PROG (|conname| |abb| |predvector| |a| |p| |prefix|)
    (RETURN
     (PROGN
      (|sayBrightly|
       "--------------------Attribute summary-------------------")
      (SETQ |conname| (CAR (ELT |dom| 0)))
      (SETQ |abb| (|getConstructorAbbreviation| |conname|))
      (SETQ |predvector| (ELT |dom| 3))
      ((LAMBDA (|bfVar#27| |bfVar#26|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#27|)
                (PROGN (SETQ |bfVar#26| (CAR |bfVar#27|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#26|)
                 (PROGN
                  (SETQ |a| (CAR |bfVar#26|))
                  (SETQ |p| (CDR |bfVar#26|))
                  #1#)
                 (PROGN
                  (SETQ |prefix|
                          (COND ((|testBitVector| |predvector| |p|) "true : ")
                                (#1# "false: ")))
                  (|sayBrightly| (|concat| |prefix| (|form2String| |a|)))))))
          (SETQ |bfVar#27| (CDR |bfVar#27|))))
       (ELT |dom| 2) NIL)))))

; showGoGet dom ==
;   numvec := CDDR dom.4
;   for i in 6..MAXINDEX dom | (slot := dom.i) is [=FUNCTION newGoGet,dol,index,:op] repeat
;     numOfArgs := numvec.index
;     whereNumber := numvec.(index := index + 1)
;     signumList :=
;       [formatLazyDomainForm(dom,numvec.(index + i)) for i in 0..numOfArgs]
;     index := index + numOfArgs + 1
;     namePart :=
;       concat(bright "from",form2String formatLazyDomainForm(dom,whereNumber))
;     sayBrightly [i,'": ",:formatOpSignature(op,signumList),:namePart]

(DEFUN |showGoGet| (|dom|)
  (PROG (|numvec| |slot| |ISTMP#1| |ISTMP#2| |dol| |ISTMP#3| |index| |op|
         |numOfArgs| |whereNumber| |signumList| |namePart|)
    (RETURN
     (PROGN
      (SETQ |numvec| (CDDR (ELT |dom| 4)))
      ((LAMBDA (|bfVar#28| |i|)
         (LOOP
          (COND ((> |i| |bfVar#28|) (RETURN NIL))
                (#1='T
                 (AND
                  (PROGN
                   (SETQ |ISTMP#1| (SETQ |slot| (ELT |dom| |i|)))
                   (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) #'|newGoGet|)
                        (PROGN
                         (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                         (AND (CONSP |ISTMP#2|)
                              (PROGN
                               (SETQ |dol| (CAR |ISTMP#2|))
                               (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                               (AND (CONSP |ISTMP#3|)
                                    (PROGN
                                     (SETQ |index| (CAR |ISTMP#3|))
                                     (SETQ |op| (CDR |ISTMP#3|))
                                     #1#)))))))
                  (PROGN
                   (SETQ |numOfArgs| (ELT |numvec| |index|))
                   (SETQ |whereNumber|
                           (ELT |numvec| (SETQ |index| (+ |index| 1))))
                   (SETQ |signumList|
                           ((LAMBDA (|bfVar#29| |i|)
                              (LOOP
                               (COND
                                ((> |i| |numOfArgs|)
                                 (RETURN (NREVERSE |bfVar#29|)))
                                (#1#
                                 (SETQ |bfVar#29|
                                         (CONS
                                          (|formatLazyDomainForm| |dom|
                                           (ELT |numvec| (+ |index| |i|)))
                                          |bfVar#29|))))
                               (SETQ |i| (+ |i| 1))))
                            NIL 0))
                   (SETQ |index| (+ (+ |index| |numOfArgs|) 1))
                   (SETQ |namePart|
                           (|concat| (|bright| '|from|)
                            (|form2String|
                             (|formatLazyDomainForm| |dom| |whereNumber|))))
                   (|sayBrightly|
                    (CONS |i|
                          (CONS ": "
                                (APPEND (|formatOpSignature| |op| |signumList|)
                                        |namePart|))))))))
          (SETQ |i| (+ |i| 1))))
       (MAXINDEX |dom|) 6)))))

; formatLazyDomain(dom,x) ==
;   VECP x => devaluate x
;   x is [dollar,slotNumber,:form] => formatLazyDomainForm(dom,form)
;   systemError nil

(DEFUN |formatLazyDomain| (|dom| |x|)
  (PROG (|dollar| |ISTMP#1| |slotNumber| |form|)
    (RETURN
     (COND ((VECP |x|) (|devaluate| |x|))
           ((AND (CONSP |x|)
                 (PROGN
                  (SETQ |dollar| (CAR |x|))
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |slotNumber| (CAR |ISTMP#1|))
                        (SETQ |form| (CDR |ISTMP#1|))
                        #1='T))))
            (|formatLazyDomainForm| |dom| |form|))
           (#1# (|systemError| NIL))))))

; formatLazyDomainForm(dom,x) ==
;   x = 0 => ["$"]
;   FIXP x => formatLazyDomain(dom,dom.x)
;   atom x => x
;   x is ['NRTEVAL,y] => (atom y => [y]; y)
;   [first x,:[formatLazyDomainForm(dom,y) for y in rest x]]

(DEFUN |formatLazyDomainForm| (|dom| |x|)
  (PROG (|ISTMP#1| |y|)
    (RETURN
     (COND ((EQL |x| 0) (LIST '$))
           ((FIXP |x|) (|formatLazyDomain| |dom| (ELT |dom| |x|)))
           ((ATOM |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'NRTEVAL)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1='T))))
            (COND ((ATOM |y|) (LIST |y|)) (#1# |y|)))
           (#1#
            (CONS (CAR |x|)
                  ((LAMBDA (|bfVar#31| |bfVar#30| |y|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#30|)
                            (PROGN (SETQ |y| (CAR |bfVar#30|)) NIL))
                        (RETURN (NREVERSE |bfVar#31|)))
                       (#1#
                        (SETQ |bfVar#31|
                                (CONS (|formatLazyDomainForm| |dom| |y|)
                                      |bfVar#31|))))
                      (SETQ |bfVar#30| (CDR |bfVar#30|))))
                   NIL (CDR |x|) NIL)))))))

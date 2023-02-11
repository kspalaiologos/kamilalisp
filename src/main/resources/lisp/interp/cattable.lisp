
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFVAR($has_category_hash, nil)

(DEFVAR |$has_category_hash| NIL)

; DEFVAR($ancestor_hash, nil)

(DEFVAR |$ancestor_hash| NIL)

; compressHashTable(ht) == ht

(DEFUN |compressHashTable| (|ht|) (PROG () (RETURN |ht|)))

; hasCat(domainOrCatName,catName) ==
;   catName='Type  -- every domain is a Type
;    or GETDATABASE([domainOrCatName,:catName],'HASCATEGORY)

(DEFUN |hasCat| (|domainOrCatName| |catName|)
  (PROG ()
    (RETURN
     (OR (EQ |catName| '|Type|)
         (GETDATABASE (CONS |domainOrCatName| |catName|) 'HASCATEGORY)))))

; showCategoryTable con ==
;   [[b,:val] for (key :=[a,:b]) in HKEYS $has_category_hash
;      | a = con and (val := HGET($has_category_hash, key))]

(DEFUN |showCategoryTable| (|con|)
  (PROG (|a| |b| |val|)
    (RETURN
     ((LAMBDA (|bfVar#2| |bfVar#1| |key|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#1|) (PROGN (SETQ |key| (CAR |bfVar#1|)) NIL))
           (RETURN (NREVERSE |bfVar#2|)))
          (#1='T
           (AND (CONSP |key|)
                (PROGN (SETQ |a| (CAR |key|)) (SETQ |b| (CDR |key|)) #1#)
                (EQUAL |a| |con|)
                (SETQ |val| (HGET |$has_category_hash| |key|))
                (SETQ |bfVar#2| (CONS (CONS |b| |val|) |bfVar#2|)))))
         (SETQ |bfVar#1| (CDR |bfVar#1|))))
      NIL (HKEYS |$has_category_hash|) NIL))))

; displayCategoryTable(:options) ==
;     conList := IFCAR options
;     ct := MAKE_HASHTABLE('ID)
;     for (key := [a, :b]) in HKEYS $has_category_hash repeat
;         HPUT(ct, a, [[b, :HGET($has_category_hash, key)], :HGET(ct, a)])
;     for id in HKEYS ct | null conList or MEMQ(id,conList) repeat
;         sayMSG [:bright id, '"extends:"]
;         PRINT HGET(ct, id)

(DEFUN |displayCategoryTable| (&REST |options|)
  (PROG (|conList| |ct| |a| |b|)
    (RETURN
     (PROGN
      (SETQ |conList| (IFCAR |options|))
      (SETQ |ct| (MAKE_HASHTABLE 'ID))
      ((LAMBDA (|bfVar#3| |key|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#3|) (PROGN (SETQ |key| (CAR |bfVar#3|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |key|)
                 (PROGN (SETQ |a| (CAR |key|)) (SETQ |b| (CDR |key|)) #1#)
                 (HPUT |ct| |a|
                       (CONS (CONS |b| (HGET |$has_category_hash| |key|))
                             (HGET |ct| |a|))))))
          (SETQ |bfVar#3| (CDR |bfVar#3|))))
       (HKEYS |$has_category_hash|) NIL)
      ((LAMBDA (|bfVar#4| |id|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#4|) (PROGN (SETQ |id| (CAR |bfVar#4|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (OR (NULL |conList|) (MEMQ |id| |conList|))
                 (PROGN
                  (|sayMSG| (APPEND (|bright| |id|) (CONS "extends:" NIL)))
                  (PRINT (HGET |ct| |id|))))))
          (SETQ |bfVar#4| (CDR |bfVar#4|))))
       (HKEYS |ct|) NIL)))))

; genCategoryTable() ==
;   $ancestors_hash := MAKE_HASHTABLE('ID)
;   $has_category_hash := MAKE_HASHTABLE('UEQUAL)
;   genTempCategoryTable()
;   domainList:=
;     [con for con in allConstructors()
;       | GETDATABASE(con,'CONSTRUCTORKIND) = 'domain]
;   domainTable:= [addDomainToTable(con,getConstrCat catl) for con
;     in domainList | catl := GETDATABASE(con,'CONSTRUCTORCATEGORY)]
;   -- $nonLisplibDomains, $noCategoryDomains are set in BUILDOM BOOT
;   specialDs := SETDIFFERENCE($nonLisplibDomains,$noCategoryDomains)
;   domainTable:= [:[addDomainToTable(id, getConstrCat (eval [id]).3)
;     for id in specialDs], :domainTable]
;   for [id,:entry] in domainTable repeat
;     for [a,:b] in encodeCategoryAlist(id,entry) repeat
;       HPUT($has_category_hash, [id, :a], b)
;   simpTempCategoryTable()
;   compressHashTable $ancestors_hash
;   simpCategoryTable()
;   compressHashTable $has_category_hash

(DEFUN |genCategoryTable| ()
  (PROG (|b| |a| |entry| |id| |specialDs| |domainTable| |catl| |domainList|)
    (RETURN
     (PROGN
      (SETQ |$ancestors_hash| (MAKE_HASHTABLE 'ID))
      (SETQ |$has_category_hash| (MAKE_HASHTABLE 'UEQUAL))
      (|genTempCategoryTable|)
      (SETQ |domainList|
              ((LAMBDA (|bfVar#6| |bfVar#5| |con|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#5|)
                        (PROGN (SETQ |con| (CAR |bfVar#5|)) NIL))
                    (RETURN (NREVERSE |bfVar#6|)))
                   (#1='T
                    (AND (EQ (GETDATABASE |con| 'CONSTRUCTORKIND) '|domain|)
                         (SETQ |bfVar#6| (CONS |con| |bfVar#6|)))))
                  (SETQ |bfVar#5| (CDR |bfVar#5|))))
               NIL (|allConstructors|) NIL))
      (SETQ |domainTable|
              ((LAMBDA (|bfVar#8| |bfVar#7| |con|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#7|)
                        (PROGN (SETQ |con| (CAR |bfVar#7|)) NIL))
                    (RETURN (NREVERSE |bfVar#8|)))
                   (#1#
                    (AND (SETQ |catl| (GETDATABASE |con| 'CONSTRUCTORCATEGORY))
                         (SETQ |bfVar#8|
                                 (CONS
                                  (|addDomainToTable| |con|
                                   (|getConstrCat| |catl|))
                                  |bfVar#8|)))))
                  (SETQ |bfVar#7| (CDR |bfVar#7|))))
               NIL |domainList| NIL))
      (SETQ |specialDs|
              (SETDIFFERENCE |$nonLisplibDomains| |$noCategoryDomains|))
      (SETQ |domainTable|
              (APPEND
               ((LAMBDA (|bfVar#10| |bfVar#9| |id|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#9|)
                         (PROGN (SETQ |id| (CAR |bfVar#9|)) NIL))
                     (RETURN (NREVERSE |bfVar#10|)))
                    (#1#
                     (SETQ |bfVar#10|
                             (CONS
                              (|addDomainToTable| |id|
                               (|getConstrCat| (ELT (|eval| (LIST |id|)) 3)))
                              |bfVar#10|))))
                   (SETQ |bfVar#9| (CDR |bfVar#9|))))
                NIL |specialDs| NIL)
               |domainTable|))
      ((LAMBDA (|bfVar#12| |bfVar#11|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#12|)
                (PROGN (SETQ |bfVar#11| (CAR |bfVar#12|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#11|)
                 (PROGN
                  (SETQ |id| (CAR |bfVar#11|))
                  (SETQ |entry| (CDR |bfVar#11|))
                  #1#)
                 ((LAMBDA (|bfVar#14| |bfVar#13|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#14|)
                           (PROGN (SETQ |bfVar#13| (CAR |bfVar#14|)) NIL))
                       (RETURN NIL))
                      (#1#
                       (AND (CONSP |bfVar#13|)
                            (PROGN
                             (SETQ |a| (CAR |bfVar#13|))
                             (SETQ |b| (CDR |bfVar#13|))
                             #1#)
                            (HPUT |$has_category_hash| (CONS |id| |a|) |b|))))
                     (SETQ |bfVar#14| (CDR |bfVar#14|))))
                  (|encodeCategoryAlist| |id| |entry|) NIL))))
          (SETQ |bfVar#12| (CDR |bfVar#12|))))
       |domainTable| NIL)
      (|simpTempCategoryTable|)
      (|compressHashTable| |$ancestors_hash|)
      (|simpCategoryTable|)
      (|compressHashTable| |$has_category_hash|)))))

; simpTempCategoryTable() ==
;   for id in HKEYS $ancestors_hash repeat
;     for (u:=[a,:b]) in GETDATABASE(id,'ANCESTORS) repeat
;       RPLACD(u,simpHasPred b)

(DEFUN |simpTempCategoryTable| ()
  (PROG (|b| |a|)
    (RETURN
     ((LAMBDA (|bfVar#15| |id|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#15|) (PROGN (SETQ |id| (CAR |bfVar#15|)) NIL))
           (RETURN NIL))
          (#1='T
           ((LAMBDA (|bfVar#16| |u|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#16|) (PROGN (SETQ |u| (CAR |bfVar#16|)) NIL))
                 (RETURN NIL))
                (#1#
                 (AND (CONSP |u|)
                      (PROGN (SETQ |a| (CAR |u|)) (SETQ |b| (CDR |u|)) #1#)
                      (RPLACD |u| (|simpHasPred| |b|)))))
               (SETQ |bfVar#16| (CDR |bfVar#16|))))
            (GETDATABASE |id| 'ANCESTORS) NIL)))
         (SETQ |bfVar#15| (CDR |bfVar#15|))))
      (HKEYS |$ancestors_hash|) NIL))))

; simpCategoryTable() == main where
;   main ==
;     for key in HKEYS $has_category_hash repeat
;       entry := HGET($has_category_hash, key)
;       null entry => HREM($has_category_hash, key)
;       change :=
;         atom opOf entry => simpHasPred entry
;         [[x,:npred] for [x,:pred] in entry | npred := simpHasPred pred]
;       HPUT($has_category_hash, key, change)

(DEFUN |simpCategoryTable| ()
  (PROG (|change| |npred| |pred| |x| |entry|)
    (RETURN
     ((LAMBDA (|bfVar#17| |key|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#17|) (PROGN (SETQ |key| (CAR |bfVar#17|)) NIL))
           (RETURN NIL))
          (#1='T
           (PROGN
            (SETQ |entry| (HGET |$has_category_hash| |key|))
            (COND ((NULL |entry|) (HREM |$has_category_hash| |key|))
                  (#1#
                   (PROGN
                    (SETQ |change|
                            (COND
                             ((ATOM (|opOf| |entry|)) (|simpHasPred| |entry|))
                             (#1#
                              ((LAMBDA (|bfVar#20| |bfVar#19| |bfVar#18|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#19|)
                                        (PROGN
                                         (SETQ |bfVar#18| (CAR |bfVar#19|))
                                         NIL))
                                    (RETURN (NREVERSE |bfVar#20|)))
                                   (#1#
                                    (AND (CONSP |bfVar#18|)
                                         (PROGN
                                          (SETQ |x| (CAR |bfVar#18|))
                                          (SETQ |pred| (CDR |bfVar#18|))
                                          #1#)
                                         (SETQ |npred| (|simpHasPred| |pred|))
                                         (SETQ |bfVar#20|
                                                 (CONS (CONS |x| |npred|)
                                                       |bfVar#20|)))))
                                  (SETQ |bfVar#19| (CDR |bfVar#19|))))
                               NIL |entry| NIL))))
                    (HPUT |$has_category_hash| |key| |change|)))))))
         (SETQ |bfVar#17| (CDR |bfVar#17|))))
      (HKEYS |$has_category_hash|) NIL))))

; simpHasPred(pred) == simpHasPred2(pred, [])

(DEFUN |simpHasPred| (|pred|) (PROG () (RETURN (|simpHasPred2| |pred| NIL))))

; simpHasPred2(pred, options) == main where
;   main ==
;     $hasArgs: local := IFCDR IFCAR options
;     simp pred
;   simp pred ==
;     pred is [op,:r] =>
;       op = 'has => simpHas(pred,first r,first rest r)
;       op = 'HasCategory => simp ['has, first r, simpDevaluate CADR r]
;       op = 'HasSignature =>
;          [op,sig] := simpDevaluate CADR r
;          ['has, first r, ['SIGNATURE, op, sig]]
;       op = 'HasAttribute => BREAK()
;       MEMQ(op,'(AND OR NOT)) =>
;         null (u := MKPF([simp p for p in r],op)) => nil
;         u is '(QUOTE T) => true
;         simpBool u
;       op = 'hasArgs => ($hasArgs => $hasArgs = r; pred)
;       null r and opOf op = 'has => simp first pred
;       pred is '(QUOTE T) => true
;       op1 := LASSOC(op,'((and . AND)(or . OR)(not . NOT))) => simp [op1,:r]
;     pred in '(T etc) => pred
;     null pred => nil
;     pred
;   simpDevaluate a == EVAL SUBST('QUOTE,'devaluate,a)
;   simpHas(pred,a,b) ==
;     b is ['ATTRIBUTE,attr] => BREAK()
;     b is ['SIGNATURE,op,sig] => simpHasSignature(pred,a,op,sig)
;     STRINGP(a) => pred
;     IDENTP a or hasIdent b => pred
;     npred := eval pred
;     IDENTP npred or null hasIdent npred => npred
;     pred
;   eval (pred := ['has,d,cat]) ==
;     x := hasCat(first d, first cat)
;     y := rest cat =>
;       npred := or/[p for [args,:p] in x | y = args] => simp npred
;       false  --if not there, it is false
;     x

(DEFUN |simpHasPred2| (|pred| |options|)
  (PROG (|$hasArgs|)
    (DECLARE (SPECIAL |$hasArgs|))
    (RETURN
     (PROGN
      (SETQ |$hasArgs| (IFCDR (IFCAR |options|)))
      (|simpHasPred2,simp| |pred|)))))
(DEFUN |simpHasPred2,simp| (|pred|)
  (PROG (|op| |r| |LETTMP#1| |sig| |u| |op1|)
    (RETURN
     (COND
      ((AND (CONSP |pred|)
            (PROGN (SETQ |op| (CAR |pred|)) (SETQ |r| (CDR |pred|)) #1='T))
       (COND
        ((EQ |op| '|has|)
         (|simpHasPred2,simpHas| |pred| (CAR |r|) (CAR (CDR |r|))))
        ((EQ |op| '|HasCategory|)
         (|simpHasPred2,simp|
          (LIST '|has| (CAR |r|) (|simpHasPred2,simpDevaluate| (CADR |r|)))))
        ((EQ |op| '|HasSignature|)
         (PROGN
          (SETQ |LETTMP#1| (|simpHasPred2,simpDevaluate| (CADR |r|)))
          (SETQ |op| (CAR |LETTMP#1|))
          (SETQ |sig| (CADR |LETTMP#1|))
          (LIST '|has| (CAR |r|) (LIST 'SIGNATURE |op| |sig|))))
        ((EQ |op| '|HasAttribute|) (BREAK))
        ((MEMQ |op| '(AND OR NOT))
         (COND
          ((NULL
            (SETQ |u|
                    (MKPF
                     ((LAMBDA (|bfVar#22| |bfVar#21| |p|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#21|)
                               (PROGN (SETQ |p| (CAR |bfVar#21|)) NIL))
                           (RETURN (NREVERSE |bfVar#22|)))
                          (#1#
                           (SETQ |bfVar#22|
                                   (CONS (|simpHasPred2,simp| |p|)
                                         |bfVar#22|))))
                         (SETQ |bfVar#21| (CDR |bfVar#21|))))
                      NIL |r| NIL)
                     |op|)))
           NIL)
          ((EQUAL |u| ''T) T) (#1# (|simpBool| |u|))))
        ((EQ |op| '|hasArgs|)
         (COND (|$hasArgs| (EQUAL |$hasArgs| |r|)) (#1# |pred|)))
        ((AND (NULL |r|) (EQ (|opOf| |op|) '|has|))
         (|simpHasPred2,simp| (CAR |pred|)))
        ((EQUAL |pred| ''T) T)
        ((SETQ |op1| (LASSOC |op| '((|and| . AND) (|or| . OR) (|not| . NOT))))
         (|simpHasPred2,simp| (CONS |op1| |r|)))))
      ((|member| |pred| '(T |etc|)) |pred|) ((NULL |pred|) NIL) (#1# |pred|)))))
(DEFUN |simpHasPred2,simpDevaluate| (|a|)
  (PROG () (RETURN (EVAL (SUBST 'QUOTE '|devaluate| |a|)))))
(DEFUN |simpHasPred2,simpHas| (|pred| |a| |b|)
  (PROG (|ISTMP#1| |attr| |op| |ISTMP#2| |sig| |npred|)
    (RETURN
     (COND
      ((AND (CONSP |b|) (EQ (CAR |b|) 'ATTRIBUTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |b|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |attr| (CAR |ISTMP#1|)) #1='T))))
       (BREAK))
      ((AND (CONSP |b|) (EQ (CAR |b|) 'SIGNATURE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |b|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |op| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1#))))))
       (|simpHasSignature| |pred| |a| |op| |sig|))
      ((STRINGP |a|) |pred|) ((OR (IDENTP |a|) (|hasIdent| |b|)) |pred|)
      (#1#
       (PROGN
        (SETQ |npred| (|simpHasPred2,eval| |pred|))
        (COND ((OR (IDENTP |npred|) (NULL (|hasIdent| |npred|))) |npred|)
              (#1# |pred|))))))))
(DEFUN |simpHasPred2,eval| (|pred|)
  (PROG (|d| |cat| |x| |y| |args| |p| |npred|)
    (RETURN
     (PROGN
      (SETQ |d| (CADR . #1=(|pred|)))
      (SETQ |cat| (CADDR . #1#))
      (SETQ |x| (|hasCat| (CAR |d|) (CAR |cat|)))
      (COND
       ((SETQ |y| (CDR |cat|))
        (COND
         ((SETQ |npred|
                  ((LAMBDA (|bfVar#25| |bfVar#24| |bfVar#23|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#24|)
                            (PROGN (SETQ |bfVar#23| (CAR |bfVar#24|)) NIL))
                        (RETURN |bfVar#25|))
                       (#2='T
                        (AND (CONSP |bfVar#23|)
                             (PROGN
                              (SETQ |args| (CAR |bfVar#23|))
                              (SETQ |p| (CDR |bfVar#23|))
                              #2#)
                             (EQUAL |y| |args|)
                             (PROGN
                              (SETQ |bfVar#25| |p|)
                              (COND (|bfVar#25| (RETURN |bfVar#25|)))))))
                      (SETQ |bfVar#24| (CDR |bfVar#24|))))
                   NIL |x| NIL))
          (|simpHasPred2,simp| |npred|))
         (#2# NIL)))
       (#2# |x|))))))

; simpHasSignature(pred,conform,op,sig) == --eval w/o loading
;   IDENTP conform => pred
;   [conname,:args] := conform
;   n := #sig
;   u := LASSOC(op,GETDATABASE(conname,'OPERATIONALIST))
;   candidates := [x for (x := [sig1,:.]) in u | #sig1 = #sig]  or return false
;   match := or/[x for (x := [sig1,:.]) in candidates
;                 | sig = sublisFormal(args,sig1)] or return false
;   simpHasPred(match is [sig,., p, :.] and sublisFormal(args,p) or true)

(DEFUN |simpHasSignature| (|pred| |conform| |op| |sig|)
  (PROG (|conname| |args| |n| |u| |sig1| |candidates| |match| |ISTMP#1|
         |ISTMP#2| |p|)
    (RETURN
     (COND ((IDENTP |conform|) |pred|)
           (#1='T
            (PROGN
             (SETQ |conname| (CAR |conform|))
             (SETQ |args| (CDR |conform|))
             (SETQ |n| (LENGTH |sig|))
             (SETQ |u| (LASSOC |op| (GETDATABASE |conname| 'OPERATIONALIST)))
             (SETQ |candidates|
                     (OR
                      ((LAMBDA (|bfVar#27| |bfVar#26| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#26|)
                                (PROGN (SETQ |x| (CAR |bfVar#26|)) NIL))
                            (RETURN (NREVERSE |bfVar#27|)))
                           (#1#
                            (AND (CONSP |x|)
                                 (PROGN (SETQ |sig1| (CAR |x|)) #1#)
                                 (EQL (LENGTH |sig1|) (LENGTH |sig|))
                                 (SETQ |bfVar#27| (CONS |x| |bfVar#27|)))))
                          (SETQ |bfVar#26| (CDR |bfVar#26|))))
                       NIL |u| NIL)
                      (RETURN NIL)))
             (SETQ |match|
                     (OR
                      ((LAMBDA (|bfVar#29| |bfVar#28| |x|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#28|)
                                (PROGN (SETQ |x| (CAR |bfVar#28|)) NIL))
                            (RETURN |bfVar#29|))
                           (#1#
                            (AND (CONSP |x|)
                                 (PROGN (SETQ |sig1| (CAR |x|)) #1#)
                                 (EQUAL |sig| (|sublisFormal| |args| |sig1|))
                                 (PROGN
                                  (SETQ |bfVar#29| |x|)
                                  (COND (|bfVar#29| (RETURN |bfVar#29|)))))))
                          (SETQ |bfVar#28| (CDR |bfVar#28|))))
                       NIL |candidates| NIL)
                      (RETURN NIL)))
             (|simpHasPred|
              (OR
               (AND (CONSP |match|)
                    (PROGN
                     (SETQ |sig| (CAR |match|))
                     (SETQ |ISTMP#1| (CDR |match|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|)
                                (PROGN (SETQ |p| (CAR |ISTMP#2|)) #1#)))))
                    (|sublisFormal| |args| |p|))
               T))))))))

; hasIdent pred ==
;   pred is [op,:r] =>
;     op = 'QUOTE => false
;     or/[hasIdent x for x in r]
;   pred = '_$ => false
;   IDENTP pred => true
;   false

(DEFUN |hasIdent| (|pred|)
  (PROG (|op| |r|)
    (RETURN
     (COND
      ((AND (CONSP |pred|)
            (PROGN (SETQ |op| (CAR |pred|)) (SETQ |r| (CDR |pred|)) #1='T))
       (COND ((EQ |op| 'QUOTE) NIL)
             (#1#
              ((LAMBDA (|bfVar#31| |bfVar#30| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#30|)
                        (PROGN (SETQ |x| (CAR |bfVar#30|)) NIL))
                    (RETURN |bfVar#31|))
                   (#1#
                    (PROGN
                     (SETQ |bfVar#31| (|hasIdent| |x|))
                     (COND (|bfVar#31| (RETURN |bfVar#31|))))))
                  (SETQ |bfVar#30| (CDR |bfVar#30|))))
               NIL |r| NIL))))
      ((EQ |pred| '$) NIL) ((IDENTP |pred|) T) (#1# NIL)))))

; addDomainToTable(id,catl) ==
;   alist:= nil
;   for cat in catl repeat
;     cat is ['CATEGORY,:.] => nil
;     cat is ['IF,pred,cat1,:.] =>
;       newAlist:=
;         [[a,:quickAnd(pred,b)] for [a,:b] in getCategoryExtensionAlist0 cat1]
;       alist:= [:alist,:newAlist]
;     alist:= [:alist,:getCategoryExtensionAlist0 cat]
;   [id,:alist]

(DEFUN |addDomainToTable| (|id| |catl|)
  (PROG (|alist| |ISTMP#1| |pred| |ISTMP#2| |cat1| |a| |b| |newAlist|)
    (RETURN
     (PROGN
      (SETQ |alist| NIL)
      ((LAMBDA (|bfVar#32| |cat|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#32|) (PROGN (SETQ |cat| (CAR |bfVar#32|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND ((AND (CONSP |cat|) (EQ (CAR |cat|) 'CATEGORY)) NIL)
                  ((AND (CONSP |cat|) (EQ (CAR |cat|) 'IF)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR |cat|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN
                               (SETQ |pred| (CAR |ISTMP#1|))
                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                               (AND (CONSP |ISTMP#2|)
                                    (PROGN
                                     (SETQ |cat1| (CAR |ISTMP#2|))
                                     #1#))))))
                   (PROGN
                    (SETQ |newAlist|
                            ((LAMBDA (|bfVar#35| |bfVar#34| |bfVar#33|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#34|)
                                      (PROGN
                                       (SETQ |bfVar#33| (CAR |bfVar#34|))
                                       NIL))
                                  (RETURN (NREVERSE |bfVar#35|)))
                                 (#1#
                                  (AND (CONSP |bfVar#33|)
                                       (PROGN
                                        (SETQ |a| (CAR |bfVar#33|))
                                        (SETQ |b| (CDR |bfVar#33|))
                                        #1#)
                                       (SETQ |bfVar#35|
                                               (CONS
                                                (CONS |a|
                                                      (|quickAnd| |pred| |b|))
                                                |bfVar#35|)))))
                                (SETQ |bfVar#34| (CDR |bfVar#34|))))
                             NIL (|getCategoryExtensionAlist0| |cat1|) NIL))
                    (SETQ |alist| (APPEND |alist| |newAlist|))))
                  (#1#
                   (SETQ |alist|
                           (APPEND |alist|
                                   (|getCategoryExtensionAlist0| |cat|)))))))
          (SETQ |bfVar#32| (CDR |bfVar#32|))))
       |catl| NIL)
      (CONS |id| |alist|)))))

; genTempCategoryTable() ==
;   --generates hashtable with key=categoryName and value of the form
;   --     ((form . pred) ..) meaning that
;   --           "IF pred THEN ofCategory(key,form)"
;   --  where form can involve #1, #2, ... the parameters of key
;   for con in allConstructors()  repeat
;     GETDATABASE(con,'CONSTRUCTORKIND) = 'category =>
;       addToCategoryTable con
;   for id in HKEYS $ancestors_hash repeat
;     item := HGET($ancestors_hash, id)
;     for (u:=[.,:b]) in item repeat
;       RPLACD(u,simpCatPredicate simpBool b)
;     HPUT($ancestors_hash, id, listSort(function GLESSEQP, item))

(DEFUN |genTempCategoryTable| ()
  (PROG (|b| |item|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#36| |con|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#36|) (PROGN (SETQ |con| (CAR |bfVar#36|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((EQ (GETDATABASE |con| 'CONSTRUCTORKIND) '|category|)
              (IDENTITY (|addToCategoryTable| |con|))))))
          (SETQ |bfVar#36| (CDR |bfVar#36|))))
       (|allConstructors|) NIL)
      ((LAMBDA (|bfVar#37| |id|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#37|) (PROGN (SETQ |id| (CAR |bfVar#37|)) NIL))
            (RETURN NIL))
           (#1#
            (PROGN
             (SETQ |item| (HGET |$ancestors_hash| |id|))
             ((LAMBDA (|bfVar#38| |u|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#38|)
                       (PROGN (SETQ |u| (CAR |bfVar#38|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |u|) (PROGN (SETQ |b| (CDR |u|)) #1#)
                        (RPLACD |u| (|simpCatPredicate| (|simpBool| |b|))))))
                 (SETQ |bfVar#38| (CDR |bfVar#38|))))
              |item| NIL)
             (HPUT |$ancestors_hash| |id| (|listSort| #'GLESSEQP |item|)))))
          (SETQ |bfVar#37| (CDR |bfVar#37|))))
       (HKEYS |$ancestors_hash|) NIL)))))

; addToCategoryTable con ==
;   u := CAAR GETDATABASE(con,'CONSTRUCTORMODEMAP) --domain
;   alist := getCategoryExtensionAlist u
;   HPUT($ancestors_hash, first u, alist)
;   alist

(DEFUN |addToCategoryTable| (|con|)
  (PROG (|u| |alist|)
    (RETURN
     (PROGN
      (SETQ |u| (CAAR (GETDATABASE |con| 'CONSTRUCTORMODEMAP)))
      (SETQ |alist| (|getCategoryExtensionAlist| |u|))
      (HPUT |$ancestors_hash| (CAR |u|) |alist|)
      |alist|))))

; encodeCategoryAlist(id,alist) ==
;   newAl:= nil
;   for [a,:b] in alist repeat
;     [key,:argl] := a
;     newEntry:=
;       argl => [[argl,:b]]
;       b
;     u:= assoc(key,newAl) =>
;       argl => RPLACD(u,encodeUnion(id,first newEntry,rest u))
;       if newEntry ~= rest u then
;         p := moreGeneralCategoryPredicate(newEntry, rest(u)) => RPLACD(u, p)
;         sayMSG '"Duplicate entries:"
;         PRINT [newEntry,rest u]
;     newAl:= [[key,:newEntry],:newAl]
;   newAl

(DEFUN |encodeCategoryAlist| (|id| |alist|)
  (PROG (|newAl| |a| |b| |key| |argl| |newEntry| |u| |p|)
    (RETURN
     (PROGN
      (SETQ |newAl| NIL)
      ((LAMBDA (|bfVar#40| |bfVar#39|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#40|)
                (PROGN (SETQ |bfVar#39| (CAR |bfVar#40|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#39|)
                 (PROGN
                  (SETQ |a| (CAR |bfVar#39|))
                  (SETQ |b| (CDR |bfVar#39|))
                  #1#)
                 (PROGN
                  (SETQ |key| (CAR |a|))
                  (SETQ |argl| (CDR |a|))
                  (SETQ |newEntry|
                          (COND (|argl| (LIST (CONS |argl| |b|))) (#1# |b|)))
                  (COND
                   ((SETQ |u| (|assoc| |key| |newAl|))
                    (COND
                     (|argl|
                      (RPLACD |u|
                              (|encodeUnion| |id| (CAR |newEntry|) (CDR |u|))))
                     (#1#
                      (COND
                       ((NOT (EQUAL |newEntry| (CDR |u|)))
                        (COND
                         ((SETQ |p|
                                  (|moreGeneralCategoryPredicate| |newEntry|
                                   (CDR |u|)))
                          (RPLACD |u| |p|))
                         (#1#
                          (PROGN
                           (|sayMSG| "Duplicate entries:")
                           (PRINT (LIST |newEntry| (CDR |u|)))))))))))
                   (#1#
                    (SETQ |newAl| (CONS (CONS |key| |newEntry|) |newAl|))))))))
          (SETQ |bfVar#40| (CDR |bfVar#40|))))
       |alist| NIL)
      |newAl|))))

; encodeUnion(id,new:=[a,:b],alist) ==
;   u := assoc(a,alist) =>
;     RPLACD(u, moreGeneralCategoryPredicate(b, rest(u)))
;     alist
;   [new,:alist]

(DEFUN |encodeUnion| (|id| |new| |alist|)
  (PROG (|a| |b| |u|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR |new|))
      (SETQ |b| (CDR |new|))
      (COND
       ((SETQ |u| (|assoc| |a| |alist|))
        (PROGN
         (RPLACD |u| (|moreGeneralCategoryPredicate| |b| (CDR |u|)))
         |alist|))
       ('T (CONS |new| |alist|)))))))

; moreGeneralCategoryPredicate(new, old) ==
;   old = 'T or new = 'T => 'T
;   old is ['has,a,b] and new is ['has,=a,c] =>
;     tempExtendsCat(b,c) => new
;     tempExtendsCat(c,b) => old
;     ['OR,old,new]
;   mkCategoryOr(new,old)

(DEFUN |moreGeneralCategoryPredicate| (|new| |old|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |c|)
    (RETURN
     (COND ((OR (EQ |old| 'T) (EQ |new| 'T)) 'T)
           ((AND (CONSP |old|) (EQ (CAR |old|) '|has|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |old|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |a| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T)))))
                 (CONSP |new|) (EQ (CAR |new|) '|has|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |new|))
                  (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |a|)
                       (PROGN
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |c| (CAR |ISTMP#2|)) #1#))))))
            (COND ((|tempExtendsCat| |b| |c|) |new|)
                  ((|tempExtendsCat| |c| |b|) |old|)
                  (#1# (LIST 'OR |old| |new|))))
           (#1# (|mkCategoryOr| |new| |old|))))))

; mkCategoryOr(new,old) ==
;   old is ['OR,:l] => simpCategoryOr(new,l)
;   ['OR,old,new]

(DEFUN |mkCategoryOr| (|new| |old|)
  (PROG (|l|)
    (RETURN
     (COND
      ((AND (CONSP |old|) (EQ (CAR |old|) 'OR)
            (PROGN (SETQ |l| (CDR |old|)) #1='T))
       (|simpCategoryOr| |new| |l|))
      (#1# (LIST 'OR |old| |new|))))))

; simpCategoryOr(new,l) ==
;   newExtendsAnOld:= false
;   ['has,a,b] := new
;   newList:= nil
;   for pred in l repeat
;     pred is ['has,=a,c] =>
;       tempExtendsCat(c,b) => "iterate"
;       if tempExtendsCat(b,c) then newExtendsAnOld:= true
;       newList:= [pred,:newList]
;     newList:= [pred,:newList]
;   if not newExtendsAnOld then newList:= [new,:newList]
;   newList is [.] => first newList
;   ['OR,:newList]

(DEFUN |simpCategoryOr| (|new| |l|)
  (PROG (|newExtendsAnOld| |a| |b| |newList| |ISTMP#1| |ISTMP#2| |c|)
    (RETURN
     (PROGN
      (SETQ |newExtendsAnOld| NIL)
      (SETQ |a| (CADR . #1=(|new|)))
      (SETQ |b| (CADDR . #1#))
      (SETQ |newList| NIL)
      ((LAMBDA (|bfVar#41| |pred|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#41|) (PROGN (SETQ |pred| (CAR |bfVar#41|)) NIL))
            (RETURN NIL))
           (#2='T
            (COND
             ((AND (CONSP |pred|) (EQ (CAR |pred|) '|has|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |pred|))
                    (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |a|)
                         (PROGN
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                               (PROGN (SETQ |c| (CAR |ISTMP#2|)) #2#))))))
              (COND ((|tempExtendsCat| |c| |b|) '|iterate|)
                    (#2#
                     (PROGN
                      (COND
                       ((|tempExtendsCat| |b| |c|) (SETQ |newExtendsAnOld| T)))
                      (SETQ |newList| (CONS |pred| |newList|))))))
             (#2# (SETQ |newList| (CONS |pred| |newList|))))))
          (SETQ |bfVar#41| (CDR |bfVar#41|))))
       |l| NIL)
      (COND ((NULL |newExtendsAnOld|) (SETQ |newList| (CONS |new| |newList|))))
      (COND ((AND (CONSP |newList|) (EQ (CDR |newList|) NIL)) (CAR |newList|))
            (#2# (CONS 'OR |newList|)))))))

; tempExtendsCat(b,c) ==
;   or/[first c = a for [[a,:.],:.] in GETDATABASE(first b,'ANCESTORS)]

(DEFUN |tempExtendsCat| (|b| |c|)
  (PROG (|ISTMP#1| |a|)
    (RETURN
     ((LAMBDA (|bfVar#44| |bfVar#43| |bfVar#42|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#43|)
               (PROGN (SETQ |bfVar#42| (CAR |bfVar#43|)) NIL))
           (RETURN |bfVar#44|))
          (#1='T
           (AND (CONSP |bfVar#42|)
                (PROGN
                 (SETQ |ISTMP#1| (CAR |bfVar#42|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN (SETQ |a| (CAR |ISTMP#1|)) #1#)))
                (PROGN
                 (SETQ |bfVar#44| (EQUAL (CAR |c|) |a|))
                 (COND (|bfVar#44| (RETURN |bfVar#44|)))))))
         (SETQ |bfVar#43| (CDR |bfVar#43|))))
      NIL (GETDATABASE (CAR |b|) 'ANCESTORS) NIL))))

; getCategoryExtensionAlist0 cform ==
;   [[cform,:'T],:getCategoryExtensionAlist cform]

(DEFUN |getCategoryExtensionAlist0| (|cform|)
  (PROG ()
    (RETURN (CONS (CONS |cform| 'T) (|getCategoryExtensionAlist| |cform|)))))

; getCategoryExtensionAlist cform ==
;   --avoids substitution as much as possible
;   u:= GETDATABASE(first cform,'ANCESTORS) => formalSubstitute(cform,u)
;   mkCategoryExtensionAlist cform

(DEFUN |getCategoryExtensionAlist| (|cform|)
  (PROG (|u|)
    (RETURN
     (COND
      ((SETQ |u| (GETDATABASE (CAR |cform|) 'ANCESTORS))
       (|formalSubstitute| |cform| |u|))
      ('T (|mkCategoryExtensionAlist| |cform|))))))

; formalSubstitute(form:=[.,:argl],u) ==
;   isFormalArgumentList argl => u
;   EQSUBSTLIST(argl,$FormalMapVariableList,u)

(DEFUN |formalSubstitute| (|form| |u|)
  (PROG (|argl|)
    (RETURN
     (PROGN
      (SETQ |argl| (CDR |form|))
      (COND ((|isFormalArgumentList| |argl|) |u|)
            ('T (EQSUBSTLIST |argl| |$FormalMapVariableList| |u|)))))))

; isFormalArgumentList argl ==
;   and/[x=fa for x in argl for fa in $FormalMapVariableList]

(DEFUN |isFormalArgumentList| (|argl|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#47| |bfVar#45| |x| |bfVar#46| |fa|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#45|) (PROGN (SETQ |x| (CAR |bfVar#45|)) NIL)
               (ATOM |bfVar#46|) (PROGN (SETQ |fa| (CAR |bfVar#46|)) NIL))
           (RETURN |bfVar#47|))
          ('T
           (PROGN
            (SETQ |bfVar#47| (EQUAL |x| |fa|))
            (COND ((NOT |bfVar#47|) (RETURN NIL))))))
         (SETQ |bfVar#45| (CDR |bfVar#45|))
         (SETQ |bfVar#46| (CDR |bfVar#46|))))
      T |argl| NIL |$FormalMapVariableList| NIL))))

; mkCategoryExtensionAlist cform ==
;   not CONSP cform => nil
;   cop := first cform
;   MEMQ(cop, $CategoryNames) => mkCategoryExtensionAlistBasic cform
;   catlist := formalSubstitute(cform, first getConstructorExports(cform, true))
;   extendsList:= nil
;   for [cat,:pred] in catlist repeat
;     newList := getCategoryExtensionAlist0 cat
;     finalList :=
;       pred = 'T => newList
;       [[a,:quickAnd(b,pred)] for [a,:b] in newList]
;     extendsList := catPairUnion(extendsList, finalList)
;   extendsList

(DEFUN |mkCategoryExtensionAlist| (|cform|)
  (PROG (|cop| |catlist| |extendsList| |cat| |pred| |newList| |a| |b|
         |finalList|)
    (RETURN
     (COND ((NULL (CONSP |cform|)) NIL)
           (#1='T
            (PROGN
             (SETQ |cop| (CAR |cform|))
             (COND
              ((MEMQ |cop| |$CategoryNames|)
               (|mkCategoryExtensionAlistBasic| |cform|))
              (#1#
               (PROGN
                (SETQ |catlist|
                        (|formalSubstitute| |cform|
                         (CAR (|getConstructorExports| |cform| T))))
                (SETQ |extendsList| NIL)
                ((LAMBDA (|bfVar#49| |bfVar#48|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#49|)
                          (PROGN (SETQ |bfVar#48| (CAR |bfVar#49|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (AND (CONSP |bfVar#48|)
                           (PROGN
                            (SETQ |cat| (CAR |bfVar#48|))
                            (SETQ |pred| (CDR |bfVar#48|))
                            #1#)
                           (PROGN
                            (SETQ |newList|
                                    (|getCategoryExtensionAlist0| |cat|))
                            (SETQ |finalList|
                                    (COND ((EQ |pred| 'T) |newList|)
                                          (#1#
                                           ((LAMBDA
                                                (|bfVar#52| |bfVar#51|
                                                 |bfVar#50|)
                                              (LOOP
                                               (COND
                                                ((OR (ATOM |bfVar#51|)
                                                     (PROGN
                                                      (SETQ |bfVar#50|
                                                              (CAR |bfVar#51|))
                                                      NIL))
                                                 (RETURN
                                                  (NREVERSE |bfVar#52|)))
                                                (#1#
                                                 (AND (CONSP |bfVar#50|)
                                                      (PROGN
                                                       (SETQ |a|
                                                               (CAR
                                                                |bfVar#50|))
                                                       (SETQ |b|
                                                               (CDR
                                                                |bfVar#50|))
                                                       #1#)
                                                      (SETQ |bfVar#52|
                                                              (CONS
                                                               (CONS |a|
                                                                     (|quickAnd|
                                                                      |b|
                                                                      |pred|))
                                                               |bfVar#52|)))))
                                               (SETQ |bfVar#51|
                                                       (CDR |bfVar#51|))))
                                            NIL |newList| NIL))))
                            (SETQ |extendsList|
                                    (|catPairUnion| |extendsList|
                                     |finalList|))))))
                    (SETQ |bfVar#49| (CDR |bfVar#49|))))
                 |catlist| NIL)
                |extendsList|)))))))))

; mkCategoryExtensionAlistBasic cform ==
;   cop := first cform
; --category:= eval cform
;   category :=      -- changed by RSS on 7/29/87
;     macrop cop => eval cform
;     APPLY(cop, rest cform)
;   extendsList:= [[x,:'T] for x in category.4.0]
;   for [cat,pred,:.] in category.4.1 repeat
;     newList := getCategoryExtensionAlist0 cat
;     finalList :=
;       pred = 'T => newList
;       [[a,:quickAnd(b,pred)] for [a,:b] in newList]
;     extendsList := catPairUnion(extendsList, finalList)
;   extendsList

(DEFUN |mkCategoryExtensionAlistBasic| (|cform|)
  (PROG (|cop| |category| |extendsList| |cat| |ISTMP#1| |pred| |newList| |a|
         |b| |finalList|)
    (RETURN
     (PROGN
      (SETQ |cop| (CAR |cform|))
      (SETQ |category|
              (COND ((|macrop| |cop|) (|eval| |cform|))
                    (#1='T (APPLY |cop| (CDR |cform|)))))
      (SETQ |extendsList|
              ((LAMBDA (|bfVar#54| |bfVar#53| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#53|)
                        (PROGN (SETQ |x| (CAR |bfVar#53|)) NIL))
                    (RETURN (NREVERSE |bfVar#54|)))
                   (#1# (SETQ |bfVar#54| (CONS (CONS |x| 'T) |bfVar#54|))))
                  (SETQ |bfVar#53| (CDR |bfVar#53|))))
               NIL (ELT (ELT |category| 4) 0) NIL))
      ((LAMBDA (|bfVar#56| |bfVar#55|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#56|)
                (PROGN (SETQ |bfVar#55| (CAR |bfVar#56|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#55|)
                 (PROGN
                  (SETQ |cat| (CAR |bfVar#55|))
                  (SETQ |ISTMP#1| (CDR |bfVar#55|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |pred| (CAR |ISTMP#1|)) #1#)))
                 (PROGN
                  (SETQ |newList| (|getCategoryExtensionAlist0| |cat|))
                  (SETQ |finalList|
                          (COND ((EQ |pred| 'T) |newList|)
                                (#1#
                                 ((LAMBDA (|bfVar#59| |bfVar#58| |bfVar#57|)
                                    (LOOP
                                     (COND
                                      ((OR (ATOM |bfVar#58|)
                                           (PROGN
                                            (SETQ |bfVar#57| (CAR |bfVar#58|))
                                            NIL))
                                       (RETURN (NREVERSE |bfVar#59|)))
                                      (#1#
                                       (AND (CONSP |bfVar#57|)
                                            (PROGN
                                             (SETQ |a| (CAR |bfVar#57|))
                                             (SETQ |b| (CDR |bfVar#57|))
                                             #1#)
                                            (SETQ |bfVar#59|
                                                    (CONS
                                                     (CONS |a|
                                                           (|quickAnd| |b|
                                                            |pred|))
                                                     |bfVar#59|)))))
                                     (SETQ |bfVar#58| (CDR |bfVar#58|))))
                                  NIL |newList| NIL))))
                  (SETQ |extendsList|
                          (|catPairUnion| |extendsList| |finalList|))))))
          (SETQ |bfVar#56| (CDR |bfVar#56|))))
       (ELT (ELT |category| 4) 1) NIL)
      |extendsList|))))

; catPairUnion(oldList, newList) ==
;   for pair in newList repeat
;     u:= assoc(first pair,oldList) =>
;       rest u = rest pair => nil
;       RPLACD(u,addConflict(rest pair,rest u)) where addConflict(new,old) ==
;         quickOr(new,old)
;     oldList:= [pair,:oldList]
;   oldList

(DEFUN |catPairUnion| (|oldList| |newList|)
  (PROG (|u|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#60| |pair|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#60|) (PROGN (SETQ |pair| (CAR |bfVar#60|)) NIL))
            (RETURN NIL))
           (#1='T
            (COND
             ((SETQ |u| (|assoc| (CAR |pair|) |oldList|))
              (COND ((EQUAL (CDR |u|) (CDR |pair|)) NIL)
                    (#1#
                     (RPLACD |u|
                             (|catPairUnion,addConflict| (CDR |pair|)
                              (CDR |u|))))))
             (#1# (SETQ |oldList| (CONS |pair| |oldList|))))))
          (SETQ |bfVar#60| (CDR |bfVar#60|))))
       |newList| NIL)
      |oldList|))))
(DEFUN |catPairUnion,addConflict| (|new| |old|)
  (PROG () (RETURN (|quickOr| |new| |old|))))

; simpCatPredicate p ==
;   p is ['OR,:l] =>
;     (u:= simpOrUnion l) is [p] => p
;     ['OR,:u]
;   p

(DEFUN |simpCatPredicate| (|p|)
  (PROG (|l| |u| |ISTMP#1|)
    (RETURN
     (COND
      ((AND (CONSP |p|) (EQ (CAR |p|) 'OR) (PROGN (SETQ |l| (CDR |p|)) #1='T))
       (COND
        ((PROGN
          (SETQ |ISTMP#1| (SETQ |u| (|simpOrUnion| |l|)))
          (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
               (PROGN (SETQ |p| (CAR |ISTMP#1|)) #1#)))
         |p|)
        (#1# (CONS 'OR |u|))))
      (#1# |p|)))))

; simpOrUnion l ==
;   if l then simpOrUnion1(first l,simpOrUnion rest l)
;   else l

(DEFUN |simpOrUnion| (|l|)
  (PROG ()
    (RETURN
     (COND (|l| (|simpOrUnion1| (CAR |l|) (|simpOrUnion| (CDR |l|))))
           ('T |l|)))))

; simpOrUnion1(x,l) ==
;   null l => [x]
;   p:= mergeOr(x,first l) => [p,:rest l]
;   [first l,:simpOrUnion1(x,rest l)]

(DEFUN |simpOrUnion1| (|x| |l|)
  (PROG (|p|)
    (RETURN
     (COND ((NULL |l|) (LIST |x|))
           ((SETQ |p| (|mergeOr| |x| (CAR |l|))) (CONS |p| (CDR |l|)))
           ('T (CONS (CAR |l|) (|simpOrUnion1| |x| (CDR |l|))))))))

; mergeOr(x,y) ==
;   x is ['has,a,b] and y is ['has,=a,c] =>
;     testExtend(b,c) => y
;     testExtend(c,b) => x
;     nil
;   nil

(DEFUN |mergeOr| (|x| |y|)
  (PROG (|ISTMP#1| |a| |ISTMP#2| |b| |c|)
    (RETURN
     (COND
      ((AND (CONSP |x|) (EQ (CAR |x|) '|has|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |x|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |a| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |b| (CAR |ISTMP#2|)) #1='T)))))
            (CONSP |y|) (EQ (CAR |y|) '|has|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |y|))
             (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |a|)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |c| (CAR |ISTMP#2|)) #1#))))))
       (COND ((|testExtend| |b| |c|) |y|) ((|testExtend| |c| |b|) |x|)
             (#1# NIL)))
      (#1# NIL)))))

; testExtend(a:=[op,:argl],b) ==
;   (u:= GETDATABASE(op,'ANCESTORS)) and (val:= LASSOC(b,u)) =>
;     formalSubstitute(a,val)
;   nil

(DEFUN |testExtend| (|a| |b|)
  (PROG (|op| |argl| |u| |val|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |a|))
      (SETQ |argl| (CDR |a|))
      (COND
       ((AND (SETQ |u| (GETDATABASE |op| 'ANCESTORS))
             (SETQ |val| (LASSOC |b| |u|)))
        (|formalSubstitute| |a| |val|))
       ('T NIL))))))

; getConstrCat(x) ==
; -- gets a different representation of the constructorCategory from the
; -- lisplib, which is a list of named categories or conditions
;   x:= if x is ['Join,:y] then y else [x]
;   cats:= NIL
;   for y in x repeat
;     y is ['CATEGORY,.,:z] =>
;       for zz in z repeat cats := makeCatPred(zz, cats, true)
;     cats:= CONS(y,cats)
;   cats:= nreverse cats
;   cats

(DEFUN |getConstrCat| (|x|)
  (PROG (|y| |cats| |ISTMP#1| |z|)
    (RETURN
     (PROGN
      (SETQ |x|
              (COND
               ((AND (CONSP |x|) (EQ (CAR |x|) '|Join|)
                     (PROGN (SETQ |y| (CDR |x|)) #1='T))
                |y|)
               (#1# (LIST |x|))))
      (SETQ |cats| NIL)
      ((LAMBDA (|bfVar#61| |y|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#61|) (PROGN (SETQ |y| (CAR |bfVar#61|)) NIL))
            (RETURN NIL))
           (#1#
            (COND
             ((AND (CONSP |y|) (EQ (CAR |y|) 'CATEGORY)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |y|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN (SETQ |z| (CDR |ISTMP#1|)) #1#))))
              ((LAMBDA (|bfVar#62| |zz|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#62|)
                        (PROGN (SETQ |zz| (CAR |bfVar#62|)) NIL))
                    (RETURN NIL))
                   (#1# (SETQ |cats| (|makeCatPred| |zz| |cats| T))))
                  (SETQ |bfVar#62| (CDR |bfVar#62|))))
               |z| NIL))
             (#1# (SETQ |cats| (CONS |y| |cats|))))))
          (SETQ |bfVar#61| (CDR |bfVar#61|))))
       |x| NIL)
      (SETQ |cats| (NREVERSE |cats|))
      |cats|))))

; makeCatPred(zz, cats, thePred) ==
;   if zz is ['IF,curPred := ['has,z1,z2],ats,.] then
;     ats := if ats is ['PROGN,:atl] then atl else [ats]
;     for at in ats repeat
; --      at is ['ATTRIBUTE,z3] =>
; --          BREAK()
;       if at is ['ATTRIBUTE,z3] and not atom z3 and
;         constructor? first z3 then
;           cats:= CONS(['IF,quickAnd(['has,z1,z2], thePred),z3,'noBranch],cats)
;       at is ['IF, pred, :.] =>
;         cats := makeCatPred(at, cats, curPred)
;   cats

(DEFUN |makeCatPred| (|zz| |cats| |thePred|)
  (PROG (|ISTMP#1| |ISTMP#2| |ISTMP#3| |z1| |ISTMP#4| |z2| |curPred| |ISTMP#5|
         |ats| |ISTMP#6| |atl| |z3| |pred|)
    (RETURN
     (PROGN
      (COND
       ((AND (CONSP |zz|) (EQ (CAR |zz|) 'IF)
             (PROGN
              (SETQ |ISTMP#1| (CDR |zz|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |ISTMP#2| #1=(CAR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CAR |ISTMP#2|) '|has|)
                         (PROGN
                          (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|)
                               (PROGN
                                (SETQ |z1| (CAR |ISTMP#3|))
                                (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                     (PROGN
                                      (SETQ |z2| (CAR |ISTMP#4|))
                                      #2='T)))))))
                   (PROGN (SETQ |curPred| #1#) #2#)
                   (PROGN
                    (SETQ |ISTMP#5| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#5|)
                         (PROGN
                          (SETQ |ats| (CAR |ISTMP#5|))
                          (SETQ |ISTMP#6| (CDR |ISTMP#5|))
                          (AND (CONSP |ISTMP#6|)
                               (EQ (CDR |ISTMP#6|) NIL))))))))
        (SETQ |ats|
                (COND
                 ((AND (CONSP |ats|) (EQ (CAR |ats|) 'PROGN)
                       (PROGN (SETQ |atl| (CDR |ats|)) #2#))
                  |atl|)
                 (#2# (LIST |ats|))))
        ((LAMBDA (|bfVar#63| |at|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#63|) (PROGN (SETQ |at| (CAR |bfVar#63|)) NIL))
              (RETURN NIL))
             (#2#
              (PROGN
               (COND
                ((AND (CONSP |at|) (EQ (CAR |at|) 'ATTRIBUTE)
                      (PROGN
                       (SETQ |ISTMP#1| (CDR |at|))
                       (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                            (PROGN (SETQ |z3| (CAR |ISTMP#1|)) #2#)))
                      (NULL (ATOM |z3|)) (|constructor?| (CAR |z3|)))
                 (SETQ |cats|
                         (CONS
                          (LIST 'IF
                                (|quickAnd| (LIST '|has| |z1| |z2|) |thePred|)
                                |z3| '|noBranch|)
                          |cats|))))
               (COND
                ((AND (CONSP |at|) (EQ (CAR |at|) 'IF)
                      (PROGN
                       (SETQ |ISTMP#1| (CDR |at|))
                       (AND (CONSP |ISTMP#1|)
                            (PROGN (SETQ |pred| (CAR |ISTMP#1|)) #2#))))
                 (SETQ |cats| (|makeCatPred| |at| |cats| |curPred|)))))))
            (SETQ |bfVar#63| (CDR |bfVar#63|))))
         |ats| NIL)))
      |cats|))))

; getConstructorExports(conform, do_constr) == categoryParts(conform,
;   GETDATABASE(opOf conform, 'CONSTRUCTORCATEGORY), do_constr)

(DEFUN |getConstructorExports| (|conform| |do_constr|)
  (PROG ()
    (RETURN
     (|categoryParts| |conform|
      (GETDATABASE (|opOf| |conform|) 'CONSTRUCTORCATEGORY) |do_constr|))))

; DEFVAR($oplist)

(DEFVAR |$oplist|)

; DEFVAR($conslist)

(DEFVAR |$conslist|)

; categoryParts(conform, category, do_constr) ==
;     kind := GETDATABASE(opOf(conform), 'CONSTRUCTORKIND)
;     categoryParts1(kind, conform, category, do_constr)

(DEFUN |categoryParts| (|conform| |category| |do_constr|)
  (PROG (|kind|)
    (RETURN
     (PROGN
      (SETQ |kind| (GETDATABASE (|opOf| |conform|) 'CONSTRUCTORKIND))
      (|categoryParts1| |kind| |conform| |category| |do_constr|)))))

; categoryParts1(kind, conform, category, do_constr) == main where
;   main ==
;     $oplist  : local := nil
;     $conslist: local := nil
;     for x in exportsOf(category) repeat build(x,true)
;     $oplist   := listSort(function GLESSEQP,$oplist)
;     res :=
;         do_constr => listSort(function GLESSEQP, $conslist)
;         []
;     res := [res, :$oplist]
;     if kind = 'category then
;       tvl := TAKE(#rest conform,$TriangleVariableList)
;       res := SUBLISLIS($FormalMapVariableList,tvl,res)
;     res
;   build(item,pred) ==
;     item is ['SIGNATURE,op,sig,:.] => $oplist   := [[opOf op,sig,:pred],:$oplist]
;     --note: opOf is needed!!! Bug in compiler puts in (One) and (Zero)
;     item is ['ATTRIBUTE, attr] =>
;       constructor? opOf attr =>
;         $conslist := [[attr,:pred],:$conslist]
;         nil
;       BREAK()
;     item is ['TYPE,op,type] =>
;         BREAK()
;         $oplist := [[op,[type],:pred],:$oplist]
;     item is ['IF,pred1,s1,s2] =>
;       build(s1,quickAnd(pred,pred1))
;       s2 => build(s2,quickAnd(pred,['NOT,pred1]))
;     item is ['PROGN,:r] => for x in r repeat build(x,pred)
;     item is ['CATEGORY, ., :l] => for x in l repeat build(x, pred)
;     item in '(noBranch) => 'ok
;     null item => 'ok
;     systemError '"build error"
;   exportsOf(target) ==
;     target is ['CATEGORY,.,:r] => r
;     target is ['Join,:r,f] =>
;       for x in r repeat $conslist := [[x,:true],:$conslist]
;       exportsOf f
;     $conslist := [[target,:true],:$conslist]
;     nil

(DEFUN |categoryParts1| (|kind| |conform| |category| |do_constr|)
  (PROG (|$conslist| |$oplist| |tvl| |res|)
    (DECLARE (SPECIAL |$conslist| |$oplist|))
    (RETURN
     (PROGN
      (SETQ |$oplist| NIL)
      (SETQ |$conslist| NIL)
      ((LAMBDA (|bfVar#64| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#64|) (PROGN (SETQ |x| (CAR |bfVar#64|)) NIL))
            (RETURN NIL))
           (#1='T (|categoryParts1,build| |x| T)))
          (SETQ |bfVar#64| (CDR |bfVar#64|))))
       (|categoryParts1,exportsOf| |category|) NIL)
      (SETQ |$oplist| (|listSort| #'GLESSEQP |$oplist|))
      (SETQ |res|
              (COND (|do_constr| (|listSort| #'GLESSEQP |$conslist|))
                    (#1# NIL)))
      (SETQ |res| (CONS |res| |$oplist|))
      (COND
       ((EQ |kind| '|category|)
        (SETQ |tvl| (TAKE (LENGTH (CDR |conform|)) |$TriangleVariableList|))
        (SETQ |res| (SUBLISLIS |$FormalMapVariableList| |tvl| |res|))))
      |res|))))
(DEFUN |categoryParts1,build| (|item| |pred|)
  (PROG (|ISTMP#1| |op| |ISTMP#2| |sig| |attr| |type| |pred1| |s1| |ISTMP#3|
         |s2| |r| |l|)
    (RETURN
     (COND
      ((AND (CONSP |item|) (EQ (CAR |item|) 'SIGNATURE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |item|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |op| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1='T))))))
       (SETQ |$oplist|
               (CONS (CONS (|opOf| |op|) (CONS |sig| |pred|)) |$oplist|)))
      ((AND (CONSP |item|) (EQ (CAR |item|) 'ATTRIBUTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |item|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |attr| (CAR |ISTMP#1|)) #1#))))
       (COND
        ((|constructor?| (|opOf| |attr|))
         (PROGN
          (SETQ |$conslist| (CONS (CONS |attr| |pred|) |$conslist|))
          NIL))
        (#1# (BREAK))))
      ((AND (CONSP |item|) (EQ (CAR |item|) 'TYPE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |item|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |op| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |type| (CAR |ISTMP#2|)) #1#))))))
       (PROGN
        (BREAK)
        (SETQ |$oplist|
                (CONS (CONS |op| (CONS (LIST |type|) |pred|)) |$oplist|))))
      ((AND (CONSP |item|) (EQ (CAR |item|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |item|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |pred1| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |s1| (CAR |ISTMP#2|))
                         (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                              (PROGN (SETQ |s2| (CAR |ISTMP#3|)) #1#))))))))
       (PROGN
        (|categoryParts1,build| |s1| (|quickAnd| |pred| |pred1|))
        (COND
         (|s2|
          (|categoryParts1,build| |s2|
           (|quickAnd| |pred| (LIST 'NOT |pred1|)))))))
      ((AND (CONSP |item|) (EQ (CAR |item|) 'PROGN)
            (PROGN (SETQ |r| (CDR |item|)) #1#))
       ((LAMBDA (|bfVar#65| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#65|) (PROGN (SETQ |x| (CAR |bfVar#65|)) NIL))
             (RETURN NIL))
            (#1# (|categoryParts1,build| |x| |pred|)))
           (SETQ |bfVar#65| (CDR |bfVar#65|))))
        |r| NIL))
      ((AND (CONSP |item|) (EQ (CAR |item|) 'CATEGORY)
            (PROGN
             (SETQ |ISTMP#1| (CDR |item|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |l| (CDR |ISTMP#1|)) #1#))))
       ((LAMBDA (|bfVar#66| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#66|) (PROGN (SETQ |x| (CAR |bfVar#66|)) NIL))
             (RETURN NIL))
            (#1# (|categoryParts1,build| |x| |pred|)))
           (SETQ |bfVar#66| (CDR |bfVar#66|))))
        |l| NIL))
      ((|member| |item| '(|noBranch|)) '|ok|) ((NULL |item|) '|ok|)
      (#1# (|systemError| "build error"))))))
(DEFUN |categoryParts1,exportsOf| (|target|)
  (PROG (|ISTMP#1| |r| |ISTMP#2| |f|)
    (RETURN
     (COND
      ((AND (CONSP |target|) (EQ (CAR |target|) 'CATEGORY)
            (PROGN
             (SETQ |ISTMP#1| (CDR |target|))
             (AND (CONSP |ISTMP#1|) (PROGN (SETQ |r| (CDR |ISTMP#1|)) #1='T))))
       |r|)
      ((AND (CONSP |target|) (EQ (CAR |target|) '|Join|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |target|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN (SETQ |ISTMP#2| (REVERSE |ISTMP#1|)) #1#)
                  (CONSP |ISTMP#2|)
                  (PROGN
                   (SETQ |f| (CAR |ISTMP#2|))
                   (SETQ |r| (CDR |ISTMP#2|))
                   #1#)
                  (PROGN (SETQ |r| (NREVERSE |r|)) #1#))))
       (PROGN
        ((LAMBDA (|bfVar#67| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#67|) (PROGN (SETQ |x| (CAR |bfVar#67|)) NIL))
              (RETURN NIL))
             (#1# (SETQ |$conslist| (CONS (CONS |x| T) |$conslist|))))
            (SETQ |bfVar#67| (CDR |bfVar#67|))))
         |r| NIL)
        (|categoryParts1,exportsOf| |f|)))
      (#1#
       (PROGN (SETQ |$conslist| (CONS (CONS |target| T) |$conslist|)) NIL))))))

; updateCategoryTable(cname,kind) ==
;   kind = 'domain =>
;     updateCategoryTableForDomain(cname,getConstrCat(
;       GETDATABASE(cname,'CONSTRUCTORCATEGORY)))

(DEFUN |updateCategoryTable| (|cname| |kind|)
  (PROG ()
    (RETURN
     (COND
      ((EQ |kind| '|domain|)
       (IDENTITY
        (|updateCategoryTableForDomain| |cname|
         (|getConstrCat| (GETDATABASE |cname| 'CONSTRUCTORCATEGORY)))))))))

; updateCategoryTableForDomain(cname,category) ==
;   clearCategoryTable(cname)
;   [cname,:domainEntry]:= addDomainToTable(cname,category)
;   for [a,:b] in encodeCategoryAlist(cname,domainEntry) repeat
;     HPUT($has_category_hash, [cname, :a], b)
;   $doNotCompressHashTableIfTrue = true => $has_category_hash
;   compressHashTable $has_category_hash

(DEFUN |updateCategoryTableForDomain| (|cname| |category|)
  (PROG (|LETTMP#1| |domainEntry| |a| |b|)
    (RETURN
     (PROGN
      (|clearCategoryTable| |cname|)
      (SETQ |LETTMP#1| (|addDomainToTable| |cname| |category|))
      (SETQ |cname| (CAR |LETTMP#1|))
      (SETQ |domainEntry| (CDR |LETTMP#1|))
      ((LAMBDA (|bfVar#69| |bfVar#68|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#69|)
                (PROGN (SETQ |bfVar#68| (CAR |bfVar#69|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#68|)
                 (PROGN
                  (SETQ |a| (CAR |bfVar#68|))
                  (SETQ |b| (CDR |bfVar#68|))
                  #1#)
                 (HPUT |$has_category_hash| (CONS |cname| |a|) |b|))))
          (SETQ |bfVar#69| (CDR |bfVar#69|))))
       (|encodeCategoryAlist| |cname| |domainEntry|) NIL)
      (COND ((EQUAL |$doNotCompressHashTableIfTrue| T) |$has_category_hash|)
            (#1# (|compressHashTable| |$has_category_hash|)))))))

; clearCategoryTable($cname) ==
;   MAPHASH('clearCategoryTable1, $has_category_hash)

(DEFUN |clearCategoryTable| (|$cname|)
  (DECLARE (SPECIAL |$cname|))
  (PROG () (RETURN (MAPHASH '|clearCategoryTable1| |$has_category_hash|))))

; clearCategoryTable1(key,val) ==
;   (first key = $cname) => HREM($has_category_hash, key)
;   nil

(DEFUN |clearCategoryTable1| (|key| |val|)
  (PROG ()
    (RETURN
     (COND ((EQUAL (CAR |key|) |$cname|) (HREM |$has_category_hash| |key|))
           ('T NIL)))))

; clearTempCategoryTable(catNames) ==
;   for key in HKEYS($ancestors_hash) repeat
;     MEMQ(key,catNames) => nil
;     extensions:= nil
;     for (extension:= [catForm,:.]) in GETDATABASE(key,'ANCESTORS)
;       repeat
;         MEMQ(first catForm, catNames) => nil
;         extensions:= [extension,:extensions]
;     HPUT($ancestors_hash, key, extensions)

(DEFUN |clearTempCategoryTable| (|catNames|)
  (PROG (|extensions| |catForm|)
    (RETURN
     ((LAMBDA (|bfVar#70| |key|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#70|) (PROGN (SETQ |key| (CAR |bfVar#70|)) NIL))
           (RETURN NIL))
          (#1='T
           (COND ((MEMQ |key| |catNames|) NIL)
                 (#1#
                  (PROGN
                   (SETQ |extensions| NIL)
                   ((LAMBDA (|bfVar#71| |extension|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#71|)
                             (PROGN (SETQ |extension| (CAR |bfVar#71|)) NIL))
                         (RETURN NIL))
                        (#1#
                         (AND (CONSP |extension|)
                              (PROGN (SETQ |catForm| (CAR |extension|)) #1#)
                              (COND ((MEMQ (CAR |catForm|) |catNames|) NIL)
                                    (#1#
                                     (SETQ |extensions|
                                             (CONS |extension|
                                                   |extensions|)))))))
                       (SETQ |bfVar#71| (CDR |bfVar#71|))))
                    (GETDATABASE |key| 'ANCESTORS) NIL)
                   (HPUT |$ancestors_hash| |key| |extensions|))))))
         (SETQ |bfVar#70| (CDR |bfVar#70|))))
      (HKEYS |$ancestors_hash|) NIL))))

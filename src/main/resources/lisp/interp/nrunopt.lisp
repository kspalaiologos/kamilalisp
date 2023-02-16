
; )package "BOOT"

(IN-PACKAGE "BOOT")

; getInfovecCode(NRTslot1Info, et) ==
; --Function called by compDefineFunctor1 to create infovec at compile time
;   ['LIST,
;     MKQ makeDomainTemplate $template,
;       MKQ makeCompactDirect(NRTslot1Info, et),
;         MKQ [],
;           NRTmakeCategoryAlist(et),
;             MKQ $lookupFunction]

(DEFUN |getInfovecCode| (|NRTslot1Info| |et|)
  (PROG ()
    (RETURN
     (LIST 'LIST (MKQ (|makeDomainTemplate| |$template|))
           (MKQ (|makeCompactDirect| |NRTslot1Info| |et|)) (MKQ NIL)
           (|NRTmakeCategoryAlist| |et|) (MKQ |$lookupFunction|)))))

; makeDomainTemplate vec ==
; --NOTES: This function is called at compile time to create the template
; --  (slot 0 of the infovec); called by getInfovecCode from compDefineFunctor1
;   newVec := GETREFV SIZE vec
;   for index in 0..MAXINDEX vec repeat
;     item := vec.index
;     null item => nil
;     newVec.index :=
;       atom item => item
;       null atom first item => makeGoGetSlot(item,index)
;       item
;   $byteVec := "append"/NREVERSE $byteVec
;   newVec

(DEFUN |makeDomainTemplate| (|vec|)
  (PROG (|newVec| |item|)
    (RETURN
     (PROGN
      (SETQ |newVec| (GETREFV (SIZE |vec|)))
      ((LAMBDA (|bfVar#1| |index|)
         (LOOP
          (COND ((> |index| |bfVar#1|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |item| (ELT |vec| |index|))
                  (COND ((NULL |item|) NIL)
                        (#1#
                         (SETF (ELT |newVec| |index|)
                                 (COND ((ATOM |item|) |item|)
                                       ((NULL (ATOM (CAR |item|)))
                                        (|makeGoGetSlot| |item| |index|))
                                       (#1# |item|))))))))
          (SETQ |index| (+ |index| 1))))
       (MAXINDEX |vec|) 0)
      (SETQ |$byteVec|
              ((LAMBDA (|bfVar#2| |bfVar#4| |bfVar#3|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#4|)
                        (PROGN (SETQ |bfVar#3| (CAR |bfVar#4|)) NIL))
                    (RETURN |bfVar#2|))
                   (#1# (SETQ |bfVar#2| (APPEND |bfVar#2| |bfVar#3|))))
                  (SETQ |bfVar#4| (CDR |bfVar#4|))))
               NIL (NREVERSE |$byteVec|) NIL))
      |newVec|))))

; makeGoGetSlot(item,index) ==
; --NOTES: creates byte vec strings for LATCH slots
; --these parts of the $byteVec are created first; see also makeCompactDirect
;   [sig,whereToGo,op,:flag] := item
;   n := #sig - 1
;   newcode := [n,whereToGo,:makeCompactSigCode(sig),index]
;   $byteVec := [newcode,:$byteVec]
;   curAddress := $byteAddress
;   $byteAddress := $byteAddress + n + 4
;   [curAddress,:op]

(DEFUN |makeGoGetSlot| (|item| |index|)
  (PROG (|sig| |whereToGo| |op| |flag| |n| |newcode| |curAddress|)
    (RETURN
     (PROGN
      (SETQ |sig| (CAR |item|))
      (SETQ |whereToGo| (CADR . #1=(|item|)))
      (SETQ |op| (CADDR . #1#))
      (SETQ |flag| (CDDDR . #1#))
      (SETQ |n| (- (LENGTH |sig|) 1))
      (SETQ |newcode|
              (CONS |n|
                    (CONS |whereToGo|
                          (APPEND (|makeCompactSigCode| |sig|)
                                  (CONS |index| NIL)))))
      (SETQ |$byteVec| (CONS |newcode| |$byteVec|))
      (SETQ |curAddress| |$byteAddress|)
      (SETQ |$byteAddress| (+ (+ |$byteAddress| |n|) 4))
      (CONS |curAddress| |op|)))))

; makeCompactDirect(u, et) ==
;   $predListLength :local := LENGTH $NRTslot1PredicateList
;   $byteVecAcc: local := nil
;   [nam,[addForm,:opList]] := u
;   --pp opList
;   d := [[op, y] for [op, :items] in opList
;         | y := makeCompactDirect1(op, items, et)]
;   $byteVec := [:$byteVec,:"append"/NREVERSE $byteVecAcc]
;   LIST2VEC ("append"/d)

(DEFUN |makeCompactDirect| (|u| |et|)
  (PROG (|$byteVecAcc| |$predListLength| |d| |y| |items| |op| |opList|
         |addForm| |nam|)
    (DECLARE (SPECIAL |$byteVecAcc| |$predListLength|))
    (RETURN
     (PROGN
      (SETQ |$predListLength| (LENGTH |$NRTslot1PredicateList|))
      (SETQ |$byteVecAcc| NIL)
      (SETQ |nam| (CAR |u|))
      (SETQ |addForm| (CAADR . #1=(|u|)))
      (SETQ |opList| (CDADR . #1#))
      (SETQ |d|
              ((LAMBDA (|bfVar#7| |bfVar#6| |bfVar#5|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#6|)
                        (PROGN (SETQ |bfVar#5| (CAR |bfVar#6|)) NIL))
                    (RETURN (NREVERSE |bfVar#7|)))
                   (#2='T
                    (AND (CONSP |bfVar#5|)
                         (PROGN
                          (SETQ |op| (CAR |bfVar#5|))
                          (SETQ |items| (CDR |bfVar#5|))
                          #2#)
                         (SETQ |y| (|makeCompactDirect1| |op| |items| |et|))
                         (SETQ |bfVar#7| (CONS (LIST |op| |y|) |bfVar#7|)))))
                  (SETQ |bfVar#6| (CDR |bfVar#6|))))
               NIL |opList| NIL))
      (SETQ |$byteVec|
              (APPEND |$byteVec|
                      ((LAMBDA (|bfVar#8| |bfVar#10| |bfVar#9|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#10|)
                                (PROGN (SETQ |bfVar#9| (CAR |bfVar#10|)) NIL))
                            (RETURN |bfVar#8|))
                           (#2# (SETQ |bfVar#8| (APPEND |bfVar#8| |bfVar#9|))))
                          (SETQ |bfVar#10| (CDR |bfVar#10|))))
                       NIL (NREVERSE |$byteVecAcc|) NIL)))
      (LIST2VEC
       ((LAMBDA (|bfVar#11| |bfVar#13| |bfVar#12|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#13|)
                 (PROGN (SETQ |bfVar#12| (CAR |bfVar#13|)) NIL))
             (RETURN |bfVar#11|))
            (#2# (SETQ |bfVar#11| (APPEND |bfVar#11| |bfVar#12|))))
           (SETQ |bfVar#13| (CDR |bfVar#13|))))
        NIL |d| NIL))))))

; makeCompactDirect1(op, items, et) ==
; --NOTES: creates byte codes for ops implemented by the domain
;     curAddress := $byteAddress
;     newcodes :=
;       "append"/[u for y in orderBySubsumption items
;                   | u := fn(y, et)] or return nil
;     $byteVecAcc := [newcodes,:$byteVecAcc]
;     curAddress
;  where fn(y, et) ==
;   [sig,:r] := y
;   if r is [n,:s] then
;     slot :=
;       n is [p, :.] => p  --the rest is linenumber of function definition
;       n
;     predCode :=
;       s is [pred, :.] => predicateBitIndex(pred, et)
;       0
;   --> drop items which are not present (predCode = -1)
;   predCode = -1 => return nil
;   --> drop items with NIL slots if lookup function is incomplete
;   if null slot then
;      $lookupFunction = 'lookupIncomplete => return nil
;      slot := 1   --signals that operation is not present
;   n := #sig - 1
;   $byteAddress := $byteAddress + n + 4
;   res := [n,predCode,:makeCompactSigCode(sig),slot]
;   res

(DEFUN |makeCompactDirect1| (|op| |items| |et|)
  (PROG (|curAddress| |u| |newcodes|)
    (RETURN
     (PROGN
      (SETQ |curAddress| |$byteAddress|)
      (SETQ |newcodes|
              (OR
               ((LAMBDA (|bfVar#15| |bfVar#14| |y|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#14|)
                         (PROGN (SETQ |y| (CAR |bfVar#14|)) NIL))
                     (RETURN |bfVar#15|))
                    ('T
                     (AND (SETQ |u| (|makeCompactDirect1,fn| |y| |et|))
                          (SETQ |bfVar#15| (APPEND |bfVar#15| |u|)))))
                   (SETQ |bfVar#14| (CDR |bfVar#14|))))
                NIL (|orderBySubsumption| |items|) NIL)
               (RETURN NIL)))
      (SETQ |$byteVecAcc| (CONS |newcodes| |$byteVecAcc|))
      |curAddress|))))
(DEFUN |makeCompactDirect1,fn| (|y| |et|)
  (PROG (|sig| |r| |n| |s| |p| |slot| |pred| |predCode| |res|)
    (RETURN
     (PROGN
      (SETQ |sig| (CAR |y|))
      (SETQ |r| (CDR |y|))
      (COND
       ((AND (CONSP |r|)
             (PROGN (SETQ |n| (CAR |r|)) (SETQ |s| (CDR |r|)) #1='T))
        (SETQ |slot|
                (COND ((AND (CONSP |n|) (PROGN (SETQ |p| (CAR |n|)) #1#)) |p|)
                      (#1# |n|)))
        (SETQ |predCode|
                (COND
                 ((AND (CONSP |s|) (PROGN (SETQ |pred| (CAR |s|)) #1#))
                  (|predicateBitIndex| |pred| |et|))
                 (#1# 0)))))
      (COND ((EQUAL |predCode| (- 1)) (RETURN NIL))
            (#1#
             (PROGN
              (COND
               ((NULL |slot|)
                (COND ((EQ |$lookupFunction| '|lookupIncomplete|) (RETURN NIL))
                      (#1# (SETQ |slot| 1)))))
              (SETQ |n| (- (LENGTH |sig|) 1))
              (SETQ |$byteAddress| (+ (+ |$byteAddress| |n|) 4))
              (SETQ |res|
                      (CONS |n|
                            (CONS |predCode|
                                  (APPEND (|makeCompactSigCode| |sig|)
                                          (CONS |slot| NIL)))))
              |res|)))))))

; orderBySubsumption items == reverse(items)

(DEFUN |orderBySubsumption| (|items|) (PROG () (RETURN (REVERSE |items|))))

; makeCompactSigCode(sig) == [fn for x in sig] where
;   fn ==
;     x = '_$_$ => 2
;     x = '$ => 0
;     NULL INTEGERP x => systemError ['"code vector slot is ",x,"; must be number"]
;     x

(DEFUN |makeCompactSigCode| (|sig|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#17| |bfVar#16| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#16|) (PROGN (SETQ |x| (CAR |bfVar#16|)) NIL))
           (RETURN (NREVERSE |bfVar#17|)))
          (#1='T
           (SETQ |bfVar#17|
                   (CONS
                    (COND ((EQ |x| '$$) 2) ((EQ |x| '$) 0)
                          ((NULL (INTEGERP |x|))
                           (|systemError|
                            (LIST "code vector slot is " |x|
                                  '|; must be number|)))
                          (#1# |x|))
                    |bfVar#17|))))
         (SETQ |bfVar#16| (CDR |bfVar#16|))))
      NIL |sig| NIL))))

; stuffDomainSlots dollar ==
;   domname := devaluate dollar
;   infovec := GET(opOf domname, 'infovec)
;   lookupFunction := getLookupFun infovec
;   lookupFunction :=
;     lookupFunction = 'lookupIncomplete => function lookupIncomplete
;     function lookupComplete
;   template := infovec.0
;   if template.5 then stuffSlot(dollar,5,template.5)
;   for i in (6 + # rest domname)..MAXINDEX template | item := template.i repeat
;     stuffSlot(dollar,i,item)
;   dollar.1 := LIST(lookupFunction,dollar,infovec.1)
;   dollar.2 := infovec.2
;   proto4 := infovec.3
;   dollar.4 :=
;     VECP CDDR proto4 => BREAK()
;     bitVector := dollar.3
;     predvec := first proto4
;     packagevec := CADR proto4
;     auxvec := LIST2VEC [fn for i in 0..MAXINDEX predvec] where fn ==
;       null testBitVector(bitVector,predvec.i) => nil
;       packagevec.i or 'T
;     [auxvec,:CDDR proto4]

(DEFUN |stuffDomainSlots| (|dollar|)
  (PROG (|domname| |infovec| |lookupFunction| |template| |item| |proto4|
         |bitVector| |predvec| |packagevec| |auxvec|)
    (RETURN
     (PROGN
      (SETQ |domname| (|devaluate| |dollar|))
      (SETQ |infovec| (GET (|opOf| |domname|) '|infovec|))
      (SETQ |lookupFunction| (|getLookupFun| |infovec|))
      (SETQ |lookupFunction|
              (COND
               ((EQ |lookupFunction| '|lookupIncomplete|) #'|lookupIncomplete|)
               (#1='T #'|lookupComplete|)))
      (SETQ |template| (ELT |infovec| 0))
      (COND ((ELT |template| 5) (|stuffSlot| |dollar| 5 (ELT |template| 5))))
      ((LAMBDA (|bfVar#18| |i|)
         (LOOP
          (COND ((> |i| |bfVar#18|) (RETURN NIL))
                (#1#
                 (AND (SETQ |item| (ELT |template| |i|))
                      (|stuffSlot| |dollar| |i| |item|))))
          (SETQ |i| (+ |i| 1))))
       (MAXINDEX |template|) (+ 6 (LENGTH (CDR |domname|))))
      (SETF (ELT |dollar| 1)
              (LIST |lookupFunction| |dollar| (ELT |infovec| 1)))
      (SETF (ELT |dollar| 2) (ELT |infovec| 2))
      (SETQ |proto4| (ELT |infovec| 3))
      (SETF (ELT |dollar| 4)
              (COND ((VECP (CDDR |proto4|)) (BREAK))
                    (#1#
                     (PROGN
                      (SETQ |bitVector| (ELT |dollar| 3))
                      (SETQ |predvec| (CAR |proto4|))
                      (SETQ |packagevec| (CADR |proto4|))
                      (SETQ |auxvec|
                              (LIST2VEC
                               ((LAMBDA (|bfVar#20| |bfVar#19| |i|)
                                  (LOOP
                                   (COND
                                    ((> |i| |bfVar#19|)
                                     (RETURN (NREVERSE |bfVar#20|)))
                                    (#1#
                                     (SETQ |bfVar#20|
                                             (CONS
                                              (COND
                                               ((NULL
                                                 (|testBitVector| |bitVector|
                                                  (ELT |predvec| |i|)))
                                                NIL)
                                               (#1#
                                                (OR (ELT |packagevec| |i|)
                                                    'T)))
                                              |bfVar#20|))))
                                   (SETQ |i| (+ |i| 1))))
                                NIL (MAXINDEX |predvec|) 0)))
                      (CONS |auxvec| (CDDR |proto4|))))))))))

; getLookupFun infovec ==
;   MAXINDEX infovec = 4 => infovec.4
;   'lookupIncomplete

(DEFUN |getLookupFun| (|infovec|)
  (PROG ()
    (RETURN
     (COND ((EQL (MAXINDEX |infovec|) 4) (ELT |infovec| 4))
           ('T '|lookupIncomplete|)))))

; stuffSlot(dollar,i,item) ==
;   dollar.i :=
;     atom item => [SYMBOL_-FUNCTION item,:dollar]
;     item is [n,:op] and INTEGERP n => [FUNCTION newGoGet,dollar,:item]
;     item is ['CONS,.,['FUNCALL,a,b]] =>
;       b = '$ => [FUNCTION makeSpadConstant,eval a,dollar,i]
;       sayBrightlyNT '"Unexpected constant environment!!"
;       pp devaluate b
;       nil
;     item                --new form

(DEFUN |stuffSlot| (|dollar| |i| |item|)
  (PROG (|n| |op| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4| |a| |ISTMP#5| |b|)
    (RETURN
     (SETF (ELT |dollar| |i|)
             (COND ((ATOM |item|) (CONS (SYMBOL-FUNCTION |item|) |dollar|))
                   ((AND (CONSP |item|)
                         (PROGN
                          (SETQ |n| (CAR |item|))
                          (SETQ |op| (CDR |item|))
                          #1='T)
                         (INTEGERP |n|))
                    (CONS #'|newGoGet| (CONS |dollar| |item|)))
                   ((AND (CONSP |item|) (EQ (CAR |item|) 'CONS)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |item|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                      (AND (CONSP |ISTMP#3|)
                                           (EQ (CAR |ISTMP#3|) 'FUNCALL)
                                           (PROGN
                                            (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                            (AND (CONSP |ISTMP#4|)
                                                 (PROGN
                                                  (SETQ |a| (CAR |ISTMP#4|))
                                                  (SETQ |ISTMP#5|
                                                          (CDR |ISTMP#4|))
                                                  (AND (CONSP |ISTMP#5|)
                                                       (EQ (CDR |ISTMP#5|) NIL)
                                                       (PROGN
                                                        (SETQ |b|
                                                                (CAR
                                                                 |ISTMP#5|))
                                                        #1#))))))))))))
                    (COND
                     ((EQ |b| '$)
                      (LIST #'|makeSpadConstant| (|eval| |a|) |dollar| |i|))
                     (#1#
                      (PROGN
                       (|sayBrightlyNT| "Unexpected constant environment!!")
                       (|pp| (|devaluate| |b|))
                       NIL))))
                   (#1# |item|))))))

; predicateBitIndex(x, et) ==
;       u := simpBool(transHasCode(x, et))
;       u = 'T  =>  0
;       u = nil => -1
;       p := POSN1(u,$NRTslot1PredicateList) => p + 1
;       systemError nil

(DEFUN |predicateBitIndex| (|x| |et|)
  (PROG (|u| |p|)
    (RETURN
     (PROGN
      (SETQ |u| (|simpBool| (|transHasCode| |x| |et|)))
      (COND ((EQ |u| 'T) 0) ((NULL |u|) (- 1))
            ((SETQ |p| (POSN1 |u| |$NRTslot1PredicateList|)) (+ |p| 1))
            ('T (|systemError| NIL)))))))

; predicateBitRef(x, et) ==
;   x = 'T => 'T
;   ['testBitVector, 'pv_$, predicateBitIndex(x, et)]

(DEFUN |predicateBitRef| (|x| |et|)
  (PROG ()
    (RETURN
     (COND ((EQ |x| 'T) 'T)
           ('T
            (LIST '|testBitVector| '|pv$| (|predicateBitIndex| |x| |et|)))))))

; makePrefixForm(u,op) ==
;   u := MKPF(u,op)
;   u = ''T => 'T
;   u

(DEFUN |makePrefixForm| (|u| |op|)
  (PROG ()
    (RETURN
     (PROGN (SETQ |u| (MKPF |u| |op|)) (COND ((EQUAL |u| ''T) 'T) ('T |u|))))))

; makePredicateBitVector(pl, et) ==   --called by buildFunctor
;   if $insideCategoryPackageIfTrue = true then
;     pl := union(pl,$categoryPredicateList)
;   $predGensymAlist := nil
;   for p in removeAttributePredicates pl repeat
;     pred := simpBool(transHasCode(p, et))
;     atom pred => 'skip                --skip over T and NIL
;     if isHasDollarPred pred then
;       lasts := insert(pred,lasts)
;       for q in stripOutNonDollarPreds pred repeat firsts := insert(q,firsts)
;     else
;       firsts := insert(pred,firsts)
;   firstPl := SUBLIS($pairlis,NREVERSE orderByContainment firsts)
;   lastPl  := SUBLIS($pairlis,NREVERSE orderByContainment lasts)
;   firstCode:=
;     ['buildPredVector,0,0,mungeAddGensyms(firstPl,$predGensymAlist)]
;   lastCode := augmentPredCode(# firstPl,lastPl)
;   $lisplibPredicates := [:firstPl,:lastPl] --what is stored under 'predicates
;   [$lisplibPredicates,firstCode,:lastCode]  --$pairlis set by compDefineFunctor1

(DEFUN |makePredicateBitVector| (|pl| |et|)
  (PROG (|pred| |lasts| |firsts| |firstPl| |lastPl| |firstCode| |lastCode|)
    (RETURN
     (PROGN
      (COND
       ((EQUAL |$insideCategoryPackageIfTrue| T)
        (SETQ |pl| (|union| |pl| |$categoryPredicateList|))))
      (SETQ |$predGensymAlist| NIL)
      ((LAMBDA (|bfVar#21| |p|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#21|) (PROGN (SETQ |p| (CAR |bfVar#21|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |pred| (|simpBool| (|transHasCode| |p| |et|)))
             (COND ((ATOM |pred|) '|skip|)
                   (#1#
                    (COND
                     ((|isHasDollarPred| |pred|)
                      (SETQ |lasts| (|insert| |pred| |lasts|))
                      ((LAMBDA (|bfVar#22| |q|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#22|)
                                (PROGN (SETQ |q| (CAR |bfVar#22|)) NIL))
                            (RETURN NIL))
                           (#1# (SETQ |firsts| (|insert| |q| |firsts|))))
                          (SETQ |bfVar#22| (CDR |bfVar#22|))))
                       (|stripOutNonDollarPreds| |pred|) NIL))
                     (#1# (SETQ |firsts| (|insert| |pred| |firsts|)))))))))
          (SETQ |bfVar#21| (CDR |bfVar#21|))))
       (|removeAttributePredicates| |pl|) NIL)
      (SETQ |firstPl|
              (SUBLIS |$pairlis| (NREVERSE (|orderByContainment| |firsts|))))
      (SETQ |lastPl|
              (SUBLIS |$pairlis| (NREVERSE (|orderByContainment| |lasts|))))
      (SETQ |firstCode|
              (LIST '|buildPredVector| 0 0
                    (|mungeAddGensyms| |firstPl| |$predGensymAlist|)))
      (SETQ |lastCode| (|augmentPredCode| (LENGTH |firstPl|) |lastPl|))
      (SETQ |$lisplibPredicates| (APPEND |firstPl| |lastPl|))
      (CONS |$lisplibPredicates| (CONS |firstCode| |lastCode|))))))

; augmentPredCode(n,lastPl) ==
;   ['LIST,:pl] := mungeAddGensyms(lastPl,$predGensymAlist)
;   delta := 2^n
;   l := [(u := MKPF([x, ['augmentPredVector, '$, delta]], 'AND);
;          delta:=2 * delta; u) for x in pl]

(DEFUN |augmentPredCode| (|n| |lastPl|)
  (PROG (|LETTMP#1| |pl| |delta| |u| |l|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (|mungeAddGensyms| |lastPl| |$predGensymAlist|))
      (SETQ |pl| (CDR |LETTMP#1|))
      (SETQ |delta| (EXPT 2 |n|))
      (SETQ |l|
              ((LAMBDA (|bfVar#24| |bfVar#23| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#23|)
                        (PROGN (SETQ |x| (CAR |bfVar#23|)) NIL))
                    (RETURN (NREVERSE |bfVar#24|)))
                   ('T
                    (SETQ |bfVar#24|
                            (CONS
                             (PROGN
                              (SETQ |u|
                                      (MKPF
                                       (LIST |x|
                                             (LIST '|augmentPredVector| '$
                                                   |delta|))
                                       'AND))
                              (SETQ |delta| (* 2 |delta|))
                              |u|)
                             |bfVar#24|))))
                  (SETQ |bfVar#23| (CDR |bfVar#23|))))
               NIL |pl| NIL))))))

; augmentPredVector(dollar,value) ==
;   QSETREFV(dollar,3,value + QVELT(dollar,3))

(DEFUN |augmentPredVector| (|dollar| |value|)
  (PROG () (RETURN (QSETREFV |dollar| 3 (+ |value| (QVELT |dollar| 3))))))

; isHasDollarPred pred ==
;   pred is [op,:r] =>
;     MEMQ(op,'(AND and OR or NOT not)) => or/[isHasDollarPred x for x in r]
;     op is "HasCategory" => first r = '$
;     false
;   false

(DEFUN |isHasDollarPred| (|pred|)
  (PROG (|op| |r|)
    (RETURN
     (COND
      ((AND (CONSP |pred|)
            (PROGN (SETQ |op| (CAR |pred|)) (SETQ |r| (CDR |pred|)) #1='T))
       (COND
        ((MEMQ |op| '(AND |and| OR |or| NOT |not|))
         ((LAMBDA (|bfVar#26| |bfVar#25| |x|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#25|) (PROGN (SETQ |x| (CAR |bfVar#25|)) NIL))
               (RETURN |bfVar#26|))
              (#1#
               (PROGN
                (SETQ |bfVar#26| (|isHasDollarPred| |x|))
                (COND (|bfVar#26| (RETURN |bfVar#26|))))))
             (SETQ |bfVar#25| (CDR |bfVar#25|))))
          NIL |r| NIL))
        ((EQ |op| '|HasCategory|) (EQ (CAR |r|) '$)) (#1# NIL)))
      (#1# NIL)))))

; stripOutNonDollarPreds pred ==
;   pred is [op,:r] and MEMQ(op,'(AND and OR or NOT not)) =>
;     "append"/[stripOutNonDollarPreds x for x in r]
;   not isHasDollarPred pred => [pred]
;   nil

(DEFUN |stripOutNonDollarPreds| (|pred|)
  (PROG (|op| |r|)
    (RETURN
     (COND
      ((AND (CONSP |pred|)
            (PROGN (SETQ |op| (CAR |pred|)) (SETQ |r| (CDR |pred|)) #1='T)
            (MEMQ |op| '(AND |and| OR |or| NOT |not|)))
       ((LAMBDA (|bfVar#28| |bfVar#27| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#27|) (PROGN (SETQ |x| (CAR |bfVar#27|)) NIL))
             (RETURN |bfVar#28|))
            (#1#
             (SETQ |bfVar#28|
                     (APPEND |bfVar#28| (|stripOutNonDollarPreds| |x|)))))
           (SETQ |bfVar#27| (CDR |bfVar#27|))))
        NIL |r| NIL))
      ((NULL (|isHasDollarPred| |pred|)) (LIST |pred|)) (#1# NIL)))))

; removeAttributePredicates pl ==
;   [fn p for p in pl] where
;     fn p ==
;       p is [op,:argl] and op in '(AND and OR or NOT not) =>
;           makePrefixForm(fnl argl,op)
;       p is ['has,'$,['ATTRIBUTE,a]] => BREAK()
;       p
;     fnl p == [fn x for x in p]

(DEFUN |removeAttributePredicates| (|pl|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#30| |bfVar#29| |p|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#29|) (PROGN (SETQ |p| (CAR |bfVar#29|)) NIL))
           (RETURN (NREVERSE |bfVar#30|)))
          ('T
           (SETQ |bfVar#30|
                   (CONS (|removeAttributePredicates,fn| |p|) |bfVar#30|))))
         (SETQ |bfVar#29| (CDR |bfVar#29|))))
      NIL |pl| NIL))))
(DEFUN |removeAttributePredicates,fn| (|p|)
  (PROG (|op| |argl| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4| |a|)
    (RETURN
     (COND
      ((AND (CONSP |p|)
            (PROGN (SETQ |op| (CAR |p|)) (SETQ |argl| (CDR |p|)) #1='T)
            (|member| |op| '(AND |and| OR |or| NOT |not|)))
       (|makePrefixForm| (|removeAttributePredicates,fnl| |argl|) |op|))
      ((AND (CONSP |p|) (EQ (CAR |p|) '|has|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |p|))
             (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '$)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN
                         (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) 'ATTRIBUTE)
                              (PROGN
                               (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                               (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                    (PROGN
                                     (SETQ |a| (CAR |ISTMP#4|))
                                     #1#))))))))))
       (BREAK))
      (#1# |p|)))))
(DEFUN |removeAttributePredicates,fnl| (|p|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#32| |bfVar#31| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#31|) (PROGN (SETQ |x| (CAR |bfVar#31|)) NIL))
           (RETURN (NREVERSE |bfVar#32|)))
          ('T
           (SETQ |bfVar#32|
                   (CONS (|removeAttributePredicates,fn| |x|) |bfVar#32|))))
         (SETQ |bfVar#31| (CDR |bfVar#31|))))
      NIL |p| NIL))))

; transHasCode(x, et) ==
;   atom x => x
;   op := QCAR x
;   op is "HasCategory" => x
;   EQ(op, 'has) => compHasFormat(x, et)
;   [transHasCode(y, et) for y in x]

(DEFUN |transHasCode| (|x| |et|)
  (PROG (|op|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           (#1='T
            (PROGN
             (SETQ |op| (QCAR |x|))
             (COND ((EQ |op| '|HasCategory|) |x|)
                   ((EQ |op| '|has|) (|compHasFormat| |x| |et|))
                   (#1#
                    ((LAMBDA (|bfVar#34| |bfVar#33| |y|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#33|)
                              (PROGN (SETQ |y| (CAR |bfVar#33|)) NIL))
                          (RETURN (NREVERSE |bfVar#34|)))
                         (#1#
                          (SETQ |bfVar#34|
                                  (CONS (|transHasCode| |y| |et|)
                                        |bfVar#34|))))
                        (SETQ |bfVar#33| (CDR |bfVar#33|))))
                     NIL |x| NIL)))))))))

; mungeAddGensyms(u,gal) ==
;   ['LIST,:[fn(x,gal,0) for x in u]] where fn(x,gal,n) ==
;     atom x => x
;     g := LASSOC(x,gal) =>
;       n = 0 => ['LET,g,x]
;       g
;     [first x,:[fn(y,gal,n + 1) for y in rest x]]

(DEFUN |mungeAddGensyms| (|u| |gal|)
  (PROG ()
    (RETURN
     (CONS 'LIST
           ((LAMBDA (|bfVar#36| |bfVar#35| |x|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#35|) (PROGN (SETQ |x| (CAR |bfVar#35|)) NIL))
                 (RETURN (NREVERSE |bfVar#36|)))
                ('T
                 (SETQ |bfVar#36|
                         (CONS (|mungeAddGensyms,fn| |x| |gal| 0)
                               |bfVar#36|))))
               (SETQ |bfVar#35| (CDR |bfVar#35|))))
            NIL |u| NIL)))))
(DEFUN |mungeAddGensyms,fn| (|x| |gal| |n|)
  (PROG (|g|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           ((SETQ |g| (LASSOC |x| |gal|))
            (COND ((EQL |n| 0) (LIST 'LET |g| |x|)) (#1='T |g|)))
           (#1#
            (CONS (CAR |x|)
                  ((LAMBDA (|bfVar#38| |bfVar#37| |y|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#37|)
                            (PROGN (SETQ |y| (CAR |bfVar#37|)) NIL))
                        (RETURN (NREVERSE |bfVar#38|)))
                       (#1#
                        (SETQ |bfVar#38|
                                (CONS
                                 (|mungeAddGensyms,fn| |y| |gal| (+ |n| 1))
                                 |bfVar#38|))))
                      (SETQ |bfVar#37| (CDR |bfVar#37|))))
                   NIL (CDR |x|) NIL)))))))

; orderByContainment pl ==
;   null pl or null rest pl => pl
;   max := first pl
;   for x in rest pl repeat
;     if (y := CONTAINED(max,x)) then
;       if null assoc(max,$predGensymAlist)
;       then $predGensymAlist := [[max,:GENSYM()],:$predGensymAlist]
;     else if CONTAINED(x,max)
;          then if null assoc(x,$predGensymAlist) then $predGensymAlist := [[x,:GENSYM()],:$predGensymAlist]
;     if y then max := x
;   [max,:orderByContainment delete(max,pl)]

(DEFUN |orderByContainment| (|pl|)
  (PROG (|max| |y|)
    (RETURN
     (COND ((OR (NULL |pl|) (NULL (CDR |pl|))) |pl|)
           (#1='T
            (PROGN
             (SETQ |max| (CAR |pl|))
             ((LAMBDA (|bfVar#39| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#39|)
                       (PROGN (SETQ |x| (CAR |bfVar#39|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (COND
                     ((SETQ |y| (CONTAINED |max| |x|))
                      (COND
                       ((NULL (|assoc| |max| |$predGensymAlist|))
                        (SETQ |$predGensymAlist|
                                (CONS (CONS |max| (GENSYM))
                                      |$predGensymAlist|)))
                       ((CONTAINED |x| |max|)
                        (COND
                         ((NULL (|assoc| |x| |$predGensymAlist|))
                          (SETQ |$predGensymAlist|
                                  (CONS (CONS |x| (GENSYM))
                                        |$predGensymAlist|))))))))
                    (COND (|y| (SETQ |max| |x|))))))
                 (SETQ |bfVar#39| (CDR |bfVar#39|))))
              (CDR |pl|) NIL)
             (CONS |max| (|orderByContainment| (|delete| |max| |pl|)))))))))

; buildBitTable(:l) == fn(REVERSE l,0) where fn(l,n) ==
;   null l => n
;   n := n + n
;   if QCAR l then n := n + 1
;   fn(rest l,n)

(DEFUN |buildBitTable| (&REST |l|)
  (PROG () (RETURN (|buildBitTable,fn| (REVERSE |l|) 0))))
(DEFUN |buildBitTable,fn| (|l| |n|)
  (PROG ()
    (RETURN
     (COND ((NULL |l|) |n|)
           ('T
            (PROGN
             (SETQ |n| (+ |n| |n|))
             (COND ((QCAR |l|) (SETQ |n| (+ |n| 1))))
             (|buildBitTable,fn| (CDR |l|) |n|)))))))

; buildPredVector(init, n, l) == fn(init, 2^n, l) where fn(acc, n, l) ==
;   null l => acc
;   if first l then acc := acc + n
;   fn(acc,n + n,rest l)

(DEFUN |buildPredVector| (|init| |n| |l|)
  (PROG () (RETURN (|buildPredVector,fn| |init| (EXPT 2 |n|) |l|))))
(DEFUN |buildPredVector,fn| (|acc| |n| |l|)
  (PROG ()
    (RETURN
     (COND ((NULL |l|) |acc|)
           ('T
            (PROGN
             (COND ((CAR |l|) (SETQ |acc| (+ |acc| |n|))))
             (|buildPredVector,fn| |acc| (+ |n| |n|) (CDR |l|))))))))

; testBitVector(vec,i) ==
; --bit vector indices are always 1 larger than position in vector
;   EQ(i,0) => true
;   LOGBITP(i - 1,vec)

(DEFUN |testBitVector| (|vec| |i|)
  (PROG () (RETURN (COND ((EQ |i| 0) T) ('T (LOGBITP (- |i| 1) |vec|))))))

; bitsOf n ==
;   n = 0 => 0
;   1 + bitsOf(QUOTIENT(n, 2))

(DEFUN |bitsOf| (|n|)
  (PROG ()
    (RETURN (COND ((EQL |n| 0) 0) ('T (+ 1 (|bitsOf| (QUOTIENT |n| 2))))))))

; NRTmakeCategoryAlist(et) ==
;   $depthAssocCache : local := MAKE_HASHTABLE('ID)
;   $catAncestorAlist: local := NIL
;   pcAlist := [:[[x,:'T] for x in $uncondAlist],:$condAlist]
;   $levelAlist: local := depthAssocList [CAAR x for x in pcAlist]
;   opcAlist := NREVERSE SORTBY(function NRTcatCompare,pcAlist)
;   slot1 := [[a,:k] for [a,:b] in SUBLIS($pairlis,opcAlist)
;                    | (k := predicateBitIndex(b, et)) ~= -1]
;   slot0 := [hasDefaultPackage opOf a for [a,:b] in slot1]
;   sixEtc := [5 + i for i in 1..#$pairlis]
;   formals := ASSOCRIGHT $pairlis
;   for x in slot1 repeat
;       RPLACA(x, EQSUBSTLIST(["$$"], ["$"], first x))
;   -----------code to make a new style slot4 -----------------
;   predList := ASSOCRIGHT slot1  --is list of predicate indices
;   maxPredList := "MAX"/predList
;   catformvec := [encodeCatform(x, sixEtc, formals)
;                    for x in ASSOCLEFT slot1]
;   maxElement := "MAX"/$byteVec
;   ['CONS, ['makeByteWordVec2,MAX(maxPredList,1),MKQ predList],
;     ['CONS, MKQ LIST2VEC slot0,
;       ['CONS, MKQ LIST2VEC catformvec,
;         ['makeByteWordVec2,maxElement,MKQ $byteVec]]]]

(DEFUN |NRTmakeCategoryAlist| (|et|)
  (PROG (|$levelAlist| |$catAncestorAlist| |$depthAssocCache| |maxElement|
         |catformvec| |maxPredList| |predList| |formals| |sixEtc| |slot0|
         |slot1| |k| |b| |a| |opcAlist| |pcAlist|)
    (DECLARE (SPECIAL |$levelAlist| |$catAncestorAlist| |$depthAssocCache|))
    (RETURN
     (PROGN
      (SETQ |$depthAssocCache| (MAKE_HASHTABLE 'ID))
      (SETQ |$catAncestorAlist| NIL)
      (SETQ |pcAlist|
              (APPEND
               ((LAMBDA (|bfVar#41| |bfVar#40| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#40|)
                         (PROGN (SETQ |x| (CAR |bfVar#40|)) NIL))
                     (RETURN (NREVERSE |bfVar#41|)))
                    (#1='T (SETQ |bfVar#41| (CONS (CONS |x| 'T) |bfVar#41|))))
                   (SETQ |bfVar#40| (CDR |bfVar#40|))))
                NIL |$uncondAlist| NIL)
               |$condAlist|))
      (SETQ |$levelAlist|
              (|depthAssocList|
               ((LAMBDA (|bfVar#43| |bfVar#42| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#42|)
                         (PROGN (SETQ |x| (CAR |bfVar#42|)) NIL))
                     (RETURN (NREVERSE |bfVar#43|)))
                    (#1# (SETQ |bfVar#43| (CONS (CAAR |x|) |bfVar#43|))))
                   (SETQ |bfVar#42| (CDR |bfVar#42|))))
                NIL |pcAlist| NIL)))
      (SETQ |opcAlist| (NREVERSE (SORTBY #'|NRTcatCompare| |pcAlist|)))
      (SETQ |slot1|
              ((LAMBDA (|bfVar#46| |bfVar#45| |bfVar#44|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#45|)
                        (PROGN (SETQ |bfVar#44| (CAR |bfVar#45|)) NIL))
                    (RETURN (NREVERSE |bfVar#46|)))
                   (#1#
                    (AND (CONSP |bfVar#44|)
                         (PROGN
                          (SETQ |a| (CAR |bfVar#44|))
                          (SETQ |b| (CDR |bfVar#44|))
                          #1#)
                         (NOT
                          (EQUAL (SETQ |k| (|predicateBitIndex| |b| |et|))
                                 (- 1)))
                         (SETQ |bfVar#46| (CONS (CONS |a| |k|) |bfVar#46|)))))
                  (SETQ |bfVar#45| (CDR |bfVar#45|))))
               NIL (SUBLIS |$pairlis| |opcAlist|) NIL))
      (SETQ |slot0|
              ((LAMBDA (|bfVar#49| |bfVar#48| |bfVar#47|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#48|)
                        (PROGN (SETQ |bfVar#47| (CAR |bfVar#48|)) NIL))
                    (RETURN (NREVERSE |bfVar#49|)))
                   (#1#
                    (AND (CONSP |bfVar#47|)
                         (PROGN
                          (SETQ |a| (CAR |bfVar#47|))
                          (SETQ |b| (CDR |bfVar#47|))
                          #1#)
                         (SETQ |bfVar#49|
                                 (CONS (|hasDefaultPackage| (|opOf| |a|))
                                       |bfVar#49|)))))
                  (SETQ |bfVar#48| (CDR |bfVar#48|))))
               NIL |slot1| NIL))
      (SETQ |sixEtc|
              ((LAMBDA (|bfVar#51| |bfVar#50| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#50|) (RETURN (NREVERSE |bfVar#51|)))
                        (#1# (SETQ |bfVar#51| (CONS (+ 5 |i|) |bfVar#51|))))
                  (SETQ |i| (+ |i| 1))))
               NIL (LENGTH |$pairlis|) 1))
      (SETQ |formals| (ASSOCRIGHT |$pairlis|))
      ((LAMBDA (|bfVar#52| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#52|) (PROGN (SETQ |x| (CAR |bfVar#52|)) NIL))
            (RETURN NIL))
           (#1# (RPLACA |x| (EQSUBSTLIST (LIST '$$) (LIST '$) (CAR |x|)))))
          (SETQ |bfVar#52| (CDR |bfVar#52|))))
       |slot1| NIL)
      (SETQ |predList| (ASSOCRIGHT |slot1|))
      (SETQ |maxPredList|
              ((LAMBDA (|bfVar#53| |bfVar#55| |bfVar#54|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#55|)
                        (PROGN (SETQ |bfVar#54| (CAR |bfVar#55|)) NIL))
                    (RETURN |bfVar#53|))
                   (#1# (SETQ |bfVar#53| (MAX |bfVar#53| |bfVar#54|))))
                  (SETQ |bfVar#55| (CDR |bfVar#55|))))
               -999999 |predList| NIL))
      (SETQ |catformvec|
              ((LAMBDA (|bfVar#57| |bfVar#56| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#56|)
                        (PROGN (SETQ |x| (CAR |bfVar#56|)) NIL))
                    (RETURN (NREVERSE |bfVar#57|)))
                   (#1#
                    (SETQ |bfVar#57|
                            (CONS (|encodeCatform| |x| |sixEtc| |formals|)
                                  |bfVar#57|))))
                  (SETQ |bfVar#56| (CDR |bfVar#56|))))
               NIL (ASSOCLEFT |slot1|) NIL))
      (SETQ |maxElement|
              ((LAMBDA (|bfVar#58| |bfVar#60| |bfVar#59|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#60|)
                        (PROGN (SETQ |bfVar#59| (CAR |bfVar#60|)) NIL))
                    (RETURN |bfVar#58|))
                   (#1# (SETQ |bfVar#58| (MAX |bfVar#58| |bfVar#59|))))
                  (SETQ |bfVar#60| (CDR |bfVar#60|))))
               -999999 |$byteVec| NIL))
      (LIST 'CONS
            (LIST '|makeByteWordVec2| (MAX |maxPredList| 1) (MKQ |predList|))
            (LIST 'CONS (MKQ (LIST2VEC |slot0|))
                  (LIST 'CONS (MKQ (LIST2VEC |catformvec|))
                        (LIST '|makeByteWordVec2| |maxElement|
                              (MKQ |$byteVec|)))))))))

; encodeCatform(x, inds, formals) ==
;     k := NRTassocIndex x => k
;     atom x =>
;         res := nil
;         for ind in inds for formal in formals while not(res) repeat
;             if EQ(x, formal) then res := ind
;         res => res
;         SYMBOLP(x) => x
;         ["QUOTE", x]
;     atom rest x => x
;     [first(x), :[encodeCatform(y, inds, formals) for y in rest x]]

(DEFUN |encodeCatform| (|x| |inds| |formals|)
  (PROG (|k| |res|)
    (RETURN
     (COND ((SETQ |k| (|NRTassocIndex| |x|)) |k|)
           ((ATOM |x|)
            (PROGN
             (SETQ |res| NIL)
             ((LAMBDA (|bfVar#61| |ind| |bfVar#62| |formal|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#61|)
                       (PROGN (SETQ |ind| (CAR |bfVar#61|)) NIL)
                       (ATOM |bfVar#62|)
                       (PROGN (SETQ |formal| (CAR |bfVar#62|)) NIL) |res|)
                   (RETURN NIL))
                  (#1='T (COND ((EQ |x| |formal|) (SETQ |res| |ind|)))))
                 (SETQ |bfVar#61| (CDR |bfVar#61|))
                 (SETQ |bfVar#62| (CDR |bfVar#62|))))
              |inds| NIL |formals| NIL)
             (COND (|res| |res|) ((SYMBOLP |x|) |x|) (#1# (LIST 'QUOTE |x|)))))
           ((ATOM (CDR |x|)) |x|)
           (#1#
            (CONS (CAR |x|)
                  ((LAMBDA (|bfVar#64| |bfVar#63| |y|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#63|)
                            (PROGN (SETQ |y| (CAR |bfVar#63|)) NIL))
                        (RETURN (NREVERSE |bfVar#64|)))
                       (#1#
                        (SETQ |bfVar#64|
                                (CONS (|encodeCatform| |y| |inds| |formals|)
                                      |bfVar#64|))))
                      (SETQ |bfVar#63| (CDR |bfVar#63|))))
                   NIL (CDR |x|) NIL)))))))

; NRTcatCompare [catform,:pred] == LASSOC(first catform,$levelAlist)

(DEFUN |NRTcatCompare| (|bfVar#65|)
  (PROG (|catform| |pred|)
    (RETURN
     (PROGN
      (SETQ |catform| (CAR |bfVar#65|))
      (SETQ |pred| (CDR |bfVar#65|))
      (LASSOC (CAR |catform|) |$levelAlist|)))))

; hasDefaultPackage catname ==
;   defname := INTERN STRCONC(catname,'"&")
;   constructor? defname => defname
; --MEMQ(defname,allConstructors()) => defname
;   nil

(DEFUN |hasDefaultPackage| (|catname|)
  (PROG (|defname|)
    (RETURN
     (PROGN
      (SETQ |defname| (INTERN (STRCONC |catname| "&")))
      (COND ((|constructor?| |defname|) |defname|) ('T NIL))))))

; depthAssocList u ==
;   MEMQ('DomainSubstitutionMacro,u) => BREAK()
;   REMDUP ("append"/[depthAssoc(y) for y in u])

(DEFUN |depthAssocList| (|u|)
  (PROG ()
    (RETURN
     (COND ((MEMQ '|DomainSubstitutionMacro| |u|) (BREAK))
           (#1='T
            (REMDUP
             ((LAMBDA (|bfVar#67| |bfVar#66| |y|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#66|)
                       (PROGN (SETQ |y| (CAR |bfVar#66|)) NIL))
                   (RETURN |bfVar#67|))
                  (#1#
                   (SETQ |bfVar#67| (APPEND |bfVar#67| (|depthAssoc| |y|)))))
                 (SETQ |bfVar#66| (CDR |bfVar#66|))))
              NIL |u| NIL)))))))

; depthAssoc x ==
;   y := HGET($depthAssocCache,x) => y
;   x is ['Join,:u] or (u := getCatAncestors x) =>
;     v := depthAssocList u
;     HPUT($depthAssocCache,x,[[x,:n],:v])
;       where n == 1 + "MAX"/[rest y for y in v]
;   HPUT($depthAssocCache,x,[[x,:0]])

(DEFUN |depthAssoc| (|x|)
  (PROG (|y| |u| |v|)
    (RETURN
     (COND ((SETQ |y| (HGET |$depthAssocCache| |x|)) |y|)
           ((OR
             (AND (CONSP |x|) (EQ (CAR |x|) '|Join|)
                  (PROGN (SETQ |u| (CDR |x|)) #1='T))
             (SETQ |u| (|getCatAncestors| |x|)))
            (PROGN
             (SETQ |v| (|depthAssocList| |u|))
             (HPUT |$depthAssocCache| |x|
                   (CONS
                    (CONS |x|
                          (+ 1
                             ((LAMBDA (|bfVar#69| |bfVar#68| |y|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#68|)
                                       (PROGN (SETQ |y| (CAR |bfVar#68|)) NIL))
                                   (RETURN |bfVar#69|))
                                  (#1#
                                   (SETQ |bfVar#69|
                                           (MAX |bfVar#69| (CDR |y|)))))
                                 (SETQ |bfVar#68| (CDR |bfVar#68|))))
                              -999999 |v| NIL)))
                    |v|))))
           (#1# (HPUT |$depthAssocCache| |x| (LIST (CONS |x| 0))))))))

; getCatAncestors x ==  [CAAR y for y in parentsOf opOf x]

(DEFUN |getCatAncestors| (|x|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#71| |bfVar#70| |y|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#70|) (PROGN (SETQ |y| (CAR |bfVar#70|)) NIL))
           (RETURN (NREVERSE |bfVar#71|)))
          ('T (SETQ |bfVar#71| (CONS (CAAR |y|) |bfVar#71|))))
         (SETQ |bfVar#70| (CDR |bfVar#70|))))
      NIL (|parentsOf| (|opOf| |x|)) NIL))))

; dc(:r) ==
;   con := IFCAR r
;   options := IFCDR r
;   ok := MEMQ(con,allConstructors()) or (con := abbreviation? con)
;   null ok =>
;     sayBrightly '"Format is: dc(<constructor name or abbreviation>,option)"
;     sayBrightly
;       '"options are: all (default), slots, preds, cats, data, ops, optable"
;   option := IFCAR options
;   option = 'all or null option => dcAll con
;   option = 'slots   =>  dcSlots con
;   option = 'preds   =>  dcPreds  con
;   option = 'cats    =>  dcCats  con
;   option = 'data    =>  dcData  con
;   option = 'ops     =>  dcOps   con
;   option = 'size    =>  dcSize( con,'full)
;   option = 'optable =>  dcOpTable con

(DEFUN |dc| (&REST |r|)
  (PROG (|con| |options| |ok| |option|)
    (RETURN
     (PROGN
      (SETQ |con| (IFCAR |r|))
      (SETQ |options| (IFCDR |r|))
      (SETQ |ok|
              (OR (MEMQ |con| (|allConstructors|))
                  (SETQ |con| (|abbreviation?| |con|))))
      (COND
       ((NULL |ok|)
        (PROGN
         (|sayBrightly|
          "Format is: dc(<constructor name or abbreviation>,option)")
         (|sayBrightly|
          "options are: all (default), slots, preds, cats, data, ops, optable")))
       ('T
        (PROGN
         (SETQ |option| (IFCAR |options|))
         (COND ((OR (EQ |option| '|all|) (NULL |option|)) (|dcAll| |con|))
               ((EQ |option| '|slots|) (|dcSlots| |con|))
               ((EQ |option| '|preds|) (|dcPreds| |con|))
               ((EQ |option| '|cats|) (|dcCats| |con|))
               ((EQ |option| '|data|) (|dcData| |con|))
               ((EQ |option| '|ops|) (|dcOps| |con|))
               ((EQ |option| '|size|) (|dcSize| |con| '|full|))
               ((EQ |option| '|optable|) (|dcOpTable| |con|))))))))))

; dcSlots con ==
;   name := abbreviation? con or con
;   $infovec: local := getInfovec name
;   template := $infovec.0
;   for i in 5..MAXINDEX template repeat
;     sayBrightlyNT bright i
;     item := template.i
;     item is [n,:op] and INTEGERP n => dcOpLatchPrint(op,n)
;     null item and i > 5 => sayBrightly ['"arg  ",STRCONC('"#",STRINGIMAGE(i - 5))]
;     atom item => sayBrightly ['"fun  ",item]
;     item is ['CONS,.,['FUNCALL,[.,a],b]] => sayBrightly ['"constant ",a]
;     sayBrightly concat('"lazy ",form2String formatSlotDomain i)

(DEFUN |dcSlots| (|con|)
  (PROG (|$infovec| |b| |ISTMP#7| |a| |ISTMP#6| |ISTMP#5| |ISTMP#4| |ISTMP#3|
         |ISTMP#2| |ISTMP#1| |op| |n| |item| |template| |name|)
    (DECLARE (SPECIAL |$infovec|))
    (RETURN
     (PROGN
      (SETQ |name| (OR (|abbreviation?| |con|) |con|))
      (SETQ |$infovec| (|getInfovec| |name|))
      (SETQ |template| (ELT |$infovec| 0))
      ((LAMBDA (|bfVar#72| |i|)
         (LOOP
          (COND ((> |i| |bfVar#72|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (|sayBrightlyNT| (|bright| |i|))
                  (SETQ |item| (ELT |template| |i|))
                  (COND
                   ((AND (CONSP |item|)
                         (PROGN
                          (SETQ |n| (CAR |item|))
                          (SETQ |op| (CDR |item|))
                          #1#)
                         (INTEGERP |n|))
                    (|dcOpLatchPrint| |op| |n|))
                   ((AND (NULL |item|) (< 5 |i|))
                    (|sayBrightly|
                     (LIST "arg  " (STRCONC "#" (STRINGIMAGE (- |i| 5))))))
                   ((ATOM |item|) (|sayBrightly| (LIST "fun  " |item|)))
                   ((AND (CONSP |item|) (EQ (CAR |item|) 'CONS)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |item|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                      (AND (CONSP |ISTMP#3|)
                                           (EQ (CAR |ISTMP#3|) 'FUNCALL)
                                           (PROGN
                                            (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                            (AND (CONSP |ISTMP#4|)
                                                 (PROGN
                                                  (SETQ |ISTMP#5|
                                                          (CAR |ISTMP#4|))
                                                  (AND (CONSP |ISTMP#5|)
                                                       (PROGN
                                                        (SETQ |ISTMP#6|
                                                                (CDR
                                                                 |ISTMP#5|))
                                                        (AND (CONSP |ISTMP#6|)
                                                             (EQ
                                                              (CDR |ISTMP#6|)
                                                              NIL)
                                                             (PROGN
                                                              (SETQ |a|
                                                                      (CAR
                                                                       |ISTMP#6|))
                                                              #1#)))))
                                                 (PROGN
                                                  (SETQ |ISTMP#7|
                                                          (CDR |ISTMP#4|))
                                                  (AND (CONSP |ISTMP#7|)
                                                       (EQ (CDR |ISTMP#7|) NIL)
                                                       (PROGN
                                                        (SETQ |b|
                                                                (CAR
                                                                 |ISTMP#7|))
                                                        #1#))))))))))))
                    (|sayBrightly| (LIST "constant " |a|)))
                   (#1#
                    (|sayBrightly|
                     (|concat| "lazy "
                      (|form2String| (|formatSlotDomain| |i|)))))))))
          (SETQ |i| (+ |i| 1))))
       (MAXINDEX |template|) 5)))))

; dcOpLatchPrint(op,index) ==
;   numvec := getCodeVector()
;   numOfArgs := numvec.index
;   whereNumber := numvec.(index := index + 1)
;   signumList := dcSig(numvec,index + 1,numOfArgs)
;   index := index + numOfArgs + 1
;   namePart := concat(bright "from",
;     dollarPercentTran form2String formatSlotDomain whereNumber)
;   sayBrightly ['"latch",:formatOpSignature(op,signumList),:namePart]

(DEFUN |dcOpLatchPrint| (|op| |index|)
  (PROG (|numvec| |numOfArgs| |whereNumber| |signumList| |namePart|)
    (RETURN
     (PROGN
      (SETQ |numvec| (|getCodeVector|))
      (SETQ |numOfArgs| (ELT |numvec| |index|))
      (SETQ |whereNumber| (ELT |numvec| (SETQ |index| (+ |index| 1))))
      (SETQ |signumList| (|dcSig| |numvec| (+ |index| 1) |numOfArgs|))
      (SETQ |index| (+ (+ |index| |numOfArgs|) 1))
      (SETQ |namePart|
              (|concat| (|bright| '|from|)
               (|dollarPercentTran|
                (|form2String| (|formatSlotDomain| |whereNumber|)))))
      (|sayBrightly|
       (CONS "latch"
             (APPEND (|formatOpSignature| |op| |signumList|) |namePart|)))))))

; getInfovec name ==
;   u := GET(name, 'infovec) => u
;   GET(name, 'LOADED) => nil
;   fullLibName := GETDATABASE(name,'OBJECT) or return nil
;   startTimingProcess 'load
;   loadLibNoUpdate(name, name, fullLibName)
;   GET(name, 'infovec)

(DEFUN |getInfovec| (|name|)
  (PROG (|u| |fullLibName|)
    (RETURN
     (COND ((SETQ |u| (GET |name| '|infovec|)) |u|) ((GET |name| 'LOADED) NIL)
           ('T
            (PROGN
             (SETQ |fullLibName|
                     (OR (GETDATABASE |name| 'OBJECT) (RETURN NIL)))
             (|startTimingProcess| '|load|)
             (|loadLibNoUpdate| |name| |name| |fullLibName|)
             (GET |name| '|infovec|)))))))

; getOpSegment index ==
;   numOfArgs := (vec := getCodeVector()).index
;   [vec.i for i in index..(index + numOfArgs + 3)]

(DEFUN |getOpSegment| (|index|)
  (PROG (|vec| |numOfArgs|)
    (RETURN
     (PROGN
      (SETQ |numOfArgs| (ELT (SETQ |vec| (|getCodeVector|)) |index|))
      ((LAMBDA (|bfVar#74| |bfVar#73| |i|)
         (LOOP
          (COND ((> |i| |bfVar#73|) (RETURN (NREVERSE |bfVar#74|)))
                ('T (SETQ |bfVar#74| (CONS (ELT |vec| |i|) |bfVar#74|))))
          (SETQ |i| (+ |i| 1))))
       NIL (+ (+ |index| |numOfArgs|) 3) |index|)))))

; getCodeVector1(infovec) ==
;   proto4 := infovec.3
;   u := CDDR proto4
;   VECP u => BREAK()
;   rest u                 --new style

(DEFUN |getCodeVector1| (|infovec|)
  (PROG (|proto4| |u|)
    (RETURN
     (PROGN
      (SETQ |proto4| (ELT |infovec| 3))
      (SETQ |u| (CDDR |proto4|))
      (COND ((VECP |u|) (BREAK)) ('T (CDR |u|)))))))

; getCodeVector() == getCodeVector1($infovec)

(DEFUN |getCodeVector| () (PROG () (RETURN (|getCodeVector1| |$infovec|))))

; formatSlotDomain x ==
;   x = 0 => ["$"]
;   x = 2 => ["$$"]
;   INTEGERP x =>
;     val := $infovec.0.x
;     null val => [STRCONC('"#",STRINGIMAGE (x  - 5))]
;     formatSlotDomain val
;   atom x => x
;   x is ['NRTEVAL,y] => (atom y => [y]; y)
;   x is ['QUOTE, .] => x
;   [first x,:[formatSlotDomain y for y in rest x]]

(DEFUN |formatSlotDomain| (|x|)
  (PROG (|val| |ISTMP#1| |y|)
    (RETURN
     (COND ((EQL |x| 0) (LIST '$)) ((EQL |x| 2) (LIST '$$))
           ((INTEGERP |x|)
            (PROGN
             (SETQ |val| (ELT (ELT |$infovec| 0) |x|))
             (COND ((NULL |val|) (LIST (STRCONC "#" (STRINGIMAGE (- |x| 5)))))
                   (#1='T (|formatSlotDomain| |val|)))))
           ((ATOM |x|) |x|)
           ((AND (CONSP |x|) (EQ (CAR |x|) 'NRTEVAL)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
            (COND ((ATOM |y|) (LIST |y|)) (#1# |y|)))
           ((AND (CONSP |x|) (EQ (CAR |x|) 'QUOTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |x|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
            |x|)
           (#1#
            (CONS (CAR |x|)
                  ((LAMBDA (|bfVar#76| |bfVar#75| |y|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#75|)
                            (PROGN (SETQ |y| (CAR |bfVar#75|)) NIL))
                        (RETURN (NREVERSE |bfVar#76|)))
                       (#1#
                        (SETQ |bfVar#76|
                                (CONS (|formatSlotDomain| |y|) |bfVar#76|))))
                      (SETQ |bfVar#75| (CDR |bfVar#75|))))
                   NIL (CDR |x|) NIL)))))))

; dcOpTable con ==
;   name := abbreviation? con or con
;   $infovec: local := getInfovec name
;   template := $infovec.0
;   $predvec: local := GETDATABASE(name, 'PREDICATES)
;   opTable := $infovec.1
;   for i in 0..MAXINDEX opTable repeat
;     op := opTable.i
;     i := i + 1
;     startIndex := opTable.i
;     stopIndex :=
;       i + 1 > MAXINDEX opTable => MAXINDEX getCodeVector()
;       opTable.(i + 2)
;     curIndex := startIndex
;     while curIndex < stopIndex repeat
;       curIndex := dcOpPrint(op,curIndex)

(DEFUN |dcOpTable| (|con|)
  (PROG (|$predvec| |$infovec| |curIndex| |stopIndex| |startIndex| |op|
         |opTable| |template| |name|)
    (DECLARE (SPECIAL |$predvec| |$infovec|))
    (RETURN
     (PROGN
      (SETQ |name| (OR (|abbreviation?| |con|) |con|))
      (SETQ |$infovec| (|getInfovec| |name|))
      (SETQ |template| (ELT |$infovec| 0))
      (SETQ |$predvec| (GETDATABASE |name| 'PREDICATES))
      (SETQ |opTable| (ELT |$infovec| 1))
      ((LAMBDA (|bfVar#77| |i|)
         (LOOP
          (COND ((> |i| |bfVar#77|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |op| (ELT |opTable| |i|))
                  (SETQ |i| (+ |i| 1))
                  (SETQ |startIndex| (ELT |opTable| |i|))
                  (SETQ |stopIndex|
                          (COND
                           ((< (MAXINDEX |opTable|) (+ |i| 1))
                            (MAXINDEX (|getCodeVector|)))
                           (#1# (ELT |opTable| (+ |i| 2)))))
                  (SETQ |curIndex| |startIndex|)
                  ((LAMBDA ()
                     (LOOP
                      (COND ((NOT (< |curIndex| |stopIndex|)) (RETURN NIL))
                            (#1#
                             (SETQ |curIndex|
                                     (|dcOpPrint| |op| |curIndex|))))))))))
          (SETQ |i| (+ |i| 1))))
       (MAXINDEX |opTable|) 0)))))

; dcOpPrint(op,index) ==
;   numvec := getCodeVector()
;   segment := getOpSegment index
;   numOfArgs := numvec.index
;   index := index + 1
;   predNumber := numvec.index
;   index := index + 1
;   signumList := dcSig(numvec,index,numOfArgs)
;   index := index + numOfArgs + 1
;   slotNumber := numvec.index
;   suffix :=
;     predNumber = 0 => nil
;     [:bright '"if",:pred2English $predvec.(predNumber - 1)]
;   namePart := bright
;     slotNumber = 0 => '"subsumed by next entry"
;     slotNumber = 1 => '"missing"
;     name := $infovec.0.slotNumber
;     atom name => name
;     '"looked up"
;   sayBrightly [:formatOpSignature(op,signumList),:namePart, :suffix]
;   index + 1

(DEFUN |dcOpPrint| (|op| |index|)
  (PROG (|numvec| |segment| |numOfArgs| |predNumber| |signumList| |slotNumber|
         |suffix| |name| |namePart|)
    (RETURN
     (PROGN
      (SETQ |numvec| (|getCodeVector|))
      (SETQ |segment| (|getOpSegment| |index|))
      (SETQ |numOfArgs| (ELT |numvec| |index|))
      (SETQ |index| (+ |index| 1))
      (SETQ |predNumber| (ELT |numvec| |index|))
      (SETQ |index| (+ |index| 1))
      (SETQ |signumList| (|dcSig| |numvec| |index| |numOfArgs|))
      (SETQ |index| (+ (+ |index| |numOfArgs|) 1))
      (SETQ |slotNumber| (ELT |numvec| |index|))
      (SETQ |suffix|
              (COND ((EQL |predNumber| 0) NIL)
                    (#1='T
                     (APPEND (|bright| "if")
                             (|pred2English|
                              (ELT |$predvec| (- |predNumber| 1)))))))
      (SETQ |namePart|
              (|bright|
               (COND ((EQL |slotNumber| 0) "subsumed by next entry")
                     ((EQL |slotNumber| 1) "missing")
                     (#1#
                      (PROGN
                       (SETQ |name| (ELT (ELT |$infovec| 0) |slotNumber|))
                       (COND ((ATOM |name|) |name|) (#1# "looked up")))))))
      (|sayBrightly|
       (APPEND (|formatOpSignature| |op| |signumList|)
               (APPEND |namePart| |suffix|)))
      (+ |index| 1)))))

; dcSig(numvec,index,numOfArgs) ==
;   [formatSlotDomain numvec.(index + i) for i in 0..numOfArgs]

(DEFUN |dcSig| (|numvec| |index| |numOfArgs|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#78| |i|)
        (LOOP
         (COND ((> |i| |numOfArgs|) (RETURN (NREVERSE |bfVar#78|)))
               ('T
                (SETQ |bfVar#78|
                        (CONS
                         (|formatSlotDomain| (ELT |numvec| (+ |index| |i|)))
                         |bfVar#78|))))
         (SETQ |i| (+ |i| 1))))
      NIL 0))))

; dcPreds con ==
;   name := abbreviation? con or con
;   $infovec: local := getInfovec name
;   $predvec:= GETDATABASE(name, 'PREDICATES)
;   for i in 0..MAXINDEX $predvec repeat
;     sayBrightlyNT bright (i + 1)
;     sayBrightly pred2English $predvec.i

(DEFUN |dcPreds| (|con|)
  (PROG (|$infovec| |name|)
    (DECLARE (SPECIAL |$infovec|))
    (RETURN
     (PROGN
      (SETQ |name| (OR (|abbreviation?| |con|) |con|))
      (SETQ |$infovec| (|getInfovec| |name|))
      (SETQ |$predvec| (GETDATABASE |name| 'PREDICATES))
      ((LAMBDA (|bfVar#79| |i|)
         (LOOP
          (COND ((> |i| |bfVar#79|) (RETURN NIL))
                ('T
                 (PROGN
                  (|sayBrightlyNT| (|bright| (+ |i| 1)))
                  (|sayBrightly| (|pred2English| (ELT |$predvec| |i|))))))
          (SETQ |i| (+ |i| 1))))
       (MAXINDEX |$predvec|) 0)))))

; dcCats con ==
;   name := abbreviation? con or con
;   $infovec: local := getInfovec name
;   u := $infovec.3
;   VECP CDDR u => BREAK()
;   $predvec:= GETDATABASE(name, 'PREDICATES)
;   catpredvec := first u
;   catinfo := CADR u
;   catvec := CADDR u
;   for i in 0..MAXINDEX catvec repeat
;     sayBrightlyNT bright i
;     form := catvec.i
;     predNumber := catpredvec.i
;     suffix :=
;       predNumber = 0 => nil
;       [:bright '"if",:pred2English $predvec.(predNumber - 1)]
;     extra :=
;       null (info := catinfo.i) => nil
;       IDENTP info => bright '"package"
;       bright '"instantiated"
;     sayBrightly concat(form2String formatSlotDomain form,suffix,extra)

(DEFUN |dcCats| (|con|)
  (PROG (|$infovec| |extra| |info| |suffix| |predNumber| |form| |catvec|
         |catinfo| |catpredvec| |u| |name|)
    (DECLARE (SPECIAL |$infovec|))
    (RETURN
     (PROGN
      (SETQ |name| (OR (|abbreviation?| |con|) |con|))
      (SETQ |$infovec| (|getInfovec| |name|))
      (SETQ |u| (ELT |$infovec| 3))
      (COND ((VECP (CDDR |u|)) (BREAK))
            (#1='T
             (PROGN
              (SETQ |$predvec| (GETDATABASE |name| 'PREDICATES))
              (SETQ |catpredvec| (CAR |u|))
              (SETQ |catinfo| (CADR |u|))
              (SETQ |catvec| (CADDR |u|))
              ((LAMBDA (|bfVar#80| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#80|) (RETURN NIL))
                        (#1#
                         (PROGN
                          (|sayBrightlyNT| (|bright| |i|))
                          (SETQ |form| (ELT |catvec| |i|))
                          (SETQ |predNumber| (ELT |catpredvec| |i|))
                          (SETQ |suffix|
                                  (COND ((EQL |predNumber| 0) NIL)
                                        (#1#
                                         (APPEND (|bright| "if")
                                                 (|pred2English|
                                                  (ELT |$predvec|
                                                       (- |predNumber| 1)))))))
                          (SETQ |extra|
                                  (COND
                                   ((NULL (SETQ |info| (ELT |catinfo| |i|)))
                                    NIL)
                                   ((IDENTP |info|) (|bright| "package"))
                                   (#1# (|bright| "instantiated"))))
                          (|sayBrightly|
                           (|concat|
                            (|form2String| (|formatSlotDomain| |form|))
                            |suffix| |extra|)))))
                  (SETQ |i| (+ |i| 1))))
               (MAXINDEX |catvec|) 0))))))))

; dcData con ==
;   name := abbreviation? con or con
;   $infovec: local := getInfovec name
;   sayBrightly '"Operation data from slot 1"
;   print_full1 $infovec.1
;   vec := getCodeVector()
;   vec := (PAIRP vec => rest vec; vec)
;   sayBrightly ['"Information vector has ",SIZE vec,'" entries"]
;   dcData1 vec

(DEFUN |dcData| (|con|)
  (PROG (|$infovec| |vec| |name|)
    (DECLARE (SPECIAL |$infovec|))
    (RETURN
     (PROGN
      (SETQ |name| (OR (|abbreviation?| |con|) |con|))
      (SETQ |$infovec| (|getInfovec| |name|))
      (|sayBrightly| "Operation data from slot 1")
      (|print_full1| (ELT |$infovec| 1))
      (SETQ |vec| (|getCodeVector|))
      (SETQ |vec| (COND ((CONSP |vec|) (CDR |vec|)) ('T |vec|)))
      (|sayBrightly| (LIST "Information vector has " (SIZE |vec|) " entries"))
      (|dcData1| |vec|)))))

; dcData1 vec ==
;   n := MAXINDEX vec
;   tens := n / 10
;   for i in 0..tens repeat
;     start := 10*i
;     sayBrightlyNT rightJustifyString(STRINGIMAGE start,6)
;     sayBrightlyNT '"  |"
;     for j in start..MIN(start + 9,n) repeat
;       sayBrightlyNT rightJustifyString(STRINGIMAGE vec.j,6)
;     sayNewLine()
;   vec

(DEFUN |dcData1| (|vec|)
  (PROG (|n| |tens| |start|)
    (RETURN
     (PROGN
      (SETQ |n| (MAXINDEX |vec|))
      (SETQ |tens| (/ |n| 10))
      ((LAMBDA (|i|)
         (LOOP
          (COND ((> |i| |tens|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |start| (* 10 |i|))
                  (|sayBrightlyNT|
                   (|rightJustifyString| (STRINGIMAGE |start|) 6))
                  (|sayBrightlyNT| "  |")
                  ((LAMBDA (|bfVar#81| |j|)
                     (LOOP
                      (COND ((> |j| |bfVar#81|) (RETURN NIL))
                            (#1#
                             (|sayBrightlyNT|
                              (|rightJustifyString|
                               (STRINGIMAGE (ELT |vec| |j|)) 6))))
                      (SETQ |j| (+ |j| 1))))
                   (MIN (+ |start| 9) |n|) |start|)
                  (|sayNewLine|))))
          (SETQ |i| (+ |i| 1))))
       0)
      |vec|))))

; dcSize(:options) ==
;   con := IFCAR options
;   options := rest options
;   null con => dcSizeAll()
;   quiet := MEMQ('quiet,options)
;   full := MEMQ('full,options)
;   name := abbreviation? con or con
;   infovec := getInfovec name
;   template := infovec.0
;   maxindex := MAXINDEX template
;   latch := 0  --# of go get slots
;   lazy  := 0  --# of lazy domain slots
;   fun   := 0  --# of function slots
;   lazyNodes := 0 --# of nodes needed for lazy domain slots
;   for i in 5..maxindex repeat
;     atom (item := template.i) =>   fun := fun + 1
;     INTEGERP first item    => latch := latch + 1
;     'T                 =>
;        lazy := lazy + 1
;        lazyNodes := lazyNodes + numberOfNodes item
;   tSize := sum(vectorSize(1 + maxindex),nodeSize(lazyNodes + latch))
;   -- functions are free in the template vector
;   oSize := vectorSize(SIZE infovec.1)
;   aSize := numberOfNodes infovec.2
;   slot4 := infovec.3
;   catvec :=
;     VECP CDDR slot4 => BREAK()
;     CADDR slot4
;   n := MAXINDEX catvec
;   cSize := sum(nodeSize(2), vectorSize(SIZE first slot4), vectorSize(n + 1),
;                nodeSize(+/[numberOfNodes catvec.i for i in 0..n]))
;   codeVector :=
;     VECP CDDR slot4 => BREAK()
;     CDDDR slot4
;   vSize := halfWordSize(SIZE codeVector)
;   itotal := sum(tSize,oSize,aSize,cSize,vSize)
;   if null quiet then sayBrightly ['"infovec total = ",itotal,'" BYTES"]
;   if null quiet then
;     lookupFun := getLookupFun infovec
;     suffix := (lookupFun = 'lookupIncomplete => '"incomplete"; '"complete")
;     sayBrightly ['"template    = ",tSize]
;     sayBrightly ['"operations  = ",oSize,'" (",suffix,'")"]
;     sayBrightly ['"categories  = ",cSize]
;     sayBrightly ['"data vector = ",vSize]
;   if null quiet then
;     sayBrightly ['"number of function slots (one extra node) = ",fun]
;     sayBrightly ['"number of latch slots (2 extra nodes) = ",latch]
;     sayBrightly ['"number of lazy slots (no extra nodes) = ",lazy]
;     sayBrightly ['"size of domain vectors = ",1 + maxindex,'" slots"]
;   vtotal := itotal + nodeSize(fun)       --fun   slot is ($ . function)
;   vtotal := vtotal + nodeSize(2 * latch) --latch slot is (newGoGet $ . code)
;   --NOTE: lazy slots require no cost     --lazy  slot is lazyDomainForm
;   if null quiet then sayBrightly ['"domain size = ",vtotal,'" BYTES"]
;   etotal := nodeSize(fun + 2 * latch) + vectorSize(1 + maxindex)
;   if null quiet then sayBrightly ['"cost per instantiation = ",etotal,'" BYTES"]
;   vtotal

(DEFUN |dcSize| (&REST |options|)
  (PROG (|con| |quiet| |full| |name| |infovec| |template| |maxindex| |latch|
         |lazy| |fun| |lazyNodes| |item| |tSize| |oSize| |aSize| |slot4|
         |catvec| |n| |cSize| |codeVector| |vSize| |itotal| |lookupFun|
         |suffix| |vtotal| |etotal|)
    (RETURN
     (PROGN
      (SETQ |con| (IFCAR |options|))
      (SETQ |options| (CDR |options|))
      (COND ((NULL |con|) (|dcSizeAll|))
            (#1='T
             (PROGN
              (SETQ |quiet| (MEMQ '|quiet| |options|))
              (SETQ |full| (MEMQ '|full| |options|))
              (SETQ |name| (OR (|abbreviation?| |con|) |con|))
              (SETQ |infovec| (|getInfovec| |name|))
              (SETQ |template| (ELT |infovec| 0))
              (SETQ |maxindex| (MAXINDEX |template|))
              (SETQ |latch| 0)
              (SETQ |lazy| 0)
              (SETQ |fun| 0)
              (SETQ |lazyNodes| 0)
              ((LAMBDA (|i|)
                 (LOOP
                  (COND ((> |i| |maxindex|) (RETURN NIL))
                        (#1#
                         (COND
                          ((ATOM (SETQ |item| (ELT |template| |i|)))
                           (SETQ |fun| (+ |fun| 1)))
                          ((INTEGERP (CAR |item|))
                           (SETQ |latch| (+ |latch| 1)))
                          ('T
                           (PROGN
                            (SETQ |lazy| (+ |lazy| 1))
                            (SETQ |lazyNodes|
                                    (+ |lazyNodes|
                                       (|numberOfNodes| |item|))))))))
                  (SETQ |i| (+ |i| 1))))
               5)
              (SETQ |tSize|
                      (|sum| (|vectorSize| (+ 1 |maxindex|))
                       (|nodeSize| (+ |lazyNodes| |latch|))))
              (SETQ |oSize| (|vectorSize| (SIZE (ELT |infovec| 1))))
              (SETQ |aSize| (|numberOfNodes| (ELT |infovec| 2)))
              (SETQ |slot4| (ELT |infovec| 3))
              (SETQ |catvec|
                      (COND ((VECP (CDDR |slot4|)) (BREAK))
                            (#1# (CADDR |slot4|))))
              (SETQ |n| (MAXINDEX |catvec|))
              (SETQ |cSize|
                      (|sum| (|nodeSize| 2) (|vectorSize| (SIZE (CAR |slot4|)))
                       (|vectorSize| (+ |n| 1))
                       (|nodeSize|
                        ((LAMBDA (|bfVar#82| |i|)
                           (LOOP
                            (COND ((> |i| |n|) (RETURN |bfVar#82|))
                                  (#1#
                                   (SETQ |bfVar#82|
                                           (+ |bfVar#82|
                                              (|numberOfNodes|
                                               (ELT |catvec| |i|))))))
                            (SETQ |i| (+ |i| 1))))
                         0 0))))
              (SETQ |codeVector|
                      (COND ((VECP (CDDR |slot4|)) (BREAK))
                            (#1# (CDDDR |slot4|))))
              (SETQ |vSize| (|halfWordSize| (SIZE |codeVector|)))
              (SETQ |itotal| (|sum| |tSize| |oSize| |aSize| |cSize| |vSize|))
              (COND
               ((NULL |quiet|)
                (|sayBrightly| (LIST "infovec total = " |itotal| " BYTES"))))
              (COND
               ((NULL |quiet|) (SETQ |lookupFun| (|getLookupFun| |infovec|))
                (SETQ |suffix|
                        (COND
                         ((EQ |lookupFun| '|lookupIncomplete|) "incomplete")
                         (#1# "complete")))
                (|sayBrightly| (LIST "template    = " |tSize|))
                (|sayBrightly|
                 (LIST "operations  = " |oSize| " (" |suffix| ")"))
                (|sayBrightly| (LIST "categories  = " |cSize|))
                (|sayBrightly| (LIST "data vector = " |vSize|))))
              (COND
               ((NULL |quiet|)
                (|sayBrightly|
                 (LIST "number of function slots (one extra node) = " |fun|))
                (|sayBrightly|
                 (LIST "number of latch slots (2 extra nodes) = " |latch|))
                (|sayBrightly|
                 (LIST "number of lazy slots (no extra nodes) = " |lazy|))
                (|sayBrightly|
                 (LIST "size of domain vectors = " (+ 1 |maxindex|)
                       " slots"))))
              (SETQ |vtotal| (+ |itotal| (|nodeSize| |fun|)))
              (SETQ |vtotal| (+ |vtotal| (|nodeSize| (* 2 |latch|))))
              (COND
               ((NULL |quiet|)
                (|sayBrightly| (LIST "domain size = " |vtotal| " BYTES"))))
              (SETQ |etotal|
                      (+ (|nodeSize| (+ |fun| (* 2 |latch|)))
                         (|vectorSize| (+ 1 |maxindex|))))
              (COND
               ((NULL |quiet|)
                (|sayBrightly|
                 (LIST "cost per instantiation = " |etotal| " BYTES"))))
              |vtotal|)))))))

; dcSizeAll() ==
;   count := 0
;   total := 0
;   for x in allConstructors() | null atom GET(x, 'infovec) repeat
;     count := count + 1
;     s := dcSize(x,'quiet)
;     sayBrightly [s,'" : ",x]
;     total := total + s
;   sayBrightly '"------------total-------------"
;   sayBrightly [count," constructors; ",total," BYTES"]

(DEFUN |dcSizeAll| ()
  (PROG (|s| |total| |count|)
    (RETURN
     (PROGN
      (SETQ |count| 0)
      (SETQ |total| 0)
      ((LAMBDA (|bfVar#83| |x|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#83|) (PROGN (SETQ |x| (CAR |bfVar#83|)) NIL))
            (RETURN NIL))
           ('T
            (AND (NULL (ATOM (GET |x| '|infovec|)))
                 (PROGN
                  (SETQ |count| (+ |count| 1))
                  (SETQ |s| (|dcSize| |x| '|quiet|))
                  (|sayBrightly| (LIST |s| " : " |x|))
                  (SETQ |total| (+ |total| |s|))))))
          (SETQ |bfVar#83| (CDR |bfVar#83|))))
       (|allConstructors|) NIL)
      (|sayBrightly| "------------total-------------")
      (|sayBrightly| (LIST |count| '| constructors; | |total| '| BYTES|))))))

; sum(:l) == +/l

(DEFUN |sum| (&REST |l|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#84| |bfVar#86| |bfVar#85|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#86|)
               (PROGN (SETQ |bfVar#85| (CAR |bfVar#86|)) NIL))
           (RETURN |bfVar#84|))
          ('T (SETQ |bfVar#84| (+ |bfVar#84| |bfVar#85|))))
         (SETQ |bfVar#86| (CDR |bfVar#86|))))
      0 |l| NIL))))

; nodeSize(n) == 12 * n

(DEFUN |nodeSize| (|n|) (PROG () (RETURN (* 12 |n|))))

; vectorSize(n) == 4 * (1 + n)

(DEFUN |vectorSize| (|n|) (PROG () (RETURN (* 4 (+ 1 |n|)))))

; halfWordSize(n) ==
;   n < 128 => n / 2
;   n < 256 => n
;   2 * n

(DEFUN |halfWordSize| (|n|)
  (PROG ()
    (RETURN (COND ((< |n| 128) (/ |n| 2)) ((< |n| 256) |n|) ('T (* 2 |n|))))))

; numberOfNodes(x) ==
;   atom x => 0
;   1 + numberOfNodes first x + numberOfNodes rest x

(DEFUN |numberOfNodes| (|x|)
  (PROG ()
    (RETURN
     (COND ((ATOM |x|) 0)
           ('T
            (+ (+ 1 (|numberOfNodes| (CAR |x|)))
               (|numberOfNodes| (CDR |x|))))))))

; template con ==
;   con := abbreviation? con or con
;   ppTemplate (getInfovec con).0

(DEFUN |template| (|con|)
  (PROG ()
    (RETURN
     (PROGN
      (SETQ |con| (OR (|abbreviation?| |con|) |con|))
      (|ppTemplate| (ELT (|getInfovec| |con|) 0))))))

; ppTemplate vec ==
;   for i in 0..MAXINDEX vec repeat
;     sayBrightlyNT bright i
;     pp vec.i

(DEFUN |ppTemplate| (|vec|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#87| |i|)
        (LOOP
         (COND ((> |i| |bfVar#87|) (RETURN NIL))
               ('T
                (PROGN
                 (|sayBrightlyNT| (|bright| |i|))
                 (|pp| (ELT |vec| |i|)))))
         (SETQ |i| (+ |i| 1))))
      (MAXINDEX |vec|) 0))))

; infovec con ==
;   con := abbreviation? con or con
;   u := getInfovec con
;   sayBrightly '"---------------slot 0 is template-------------------"
;   ppTemplate u.0
;   sayBrightly '"---------------slot 1 is op table-------------------"
;   print_full1 u.1
;   sayBrightly '"---------------slot 3.0 is catpredvec---------------"
;   print_full1 u.3.0
;   sayBrightly '"---------------slot 3.1 is catinfovec---------------"
;   print_full1 u.3.1
;   sayBrightly '"---------------slot 3.2 is catvec-------------------"
;   print_full1 u.3.2
;   sayBrightly '"---------------tail of slot 3 is datavector---------"
;   dcData1 CDDDR u.3
;   'done

(DEFUN |infovec| (|con|)
  (PROG (|u|)
    (RETURN
     (PROGN
      (SETQ |con| (OR (|abbreviation?| |con|) |con|))
      (SETQ |u| (|getInfovec| |con|))
      (|sayBrightly| "---------------slot 0 is template-------------------")
      (|ppTemplate| (ELT |u| 0))
      (|sayBrightly| "---------------slot 1 is op table-------------------")
      (|print_full1| (ELT |u| 1))
      (|sayBrightly| "---------------slot 3.0 is catpredvec---------------")
      (|print_full1| (ELT (ELT |u| 3) 0))
      (|sayBrightly| "---------------slot 3.1 is catinfovec---------------")
      (|print_full1| (ELT (ELT |u| 3) 1))
      (|sayBrightly| "---------------slot 3.2 is catvec-------------------")
      (|print_full1| (ELT (ELT |u| 3) 2))
      (|sayBrightly| "---------------tail of slot 3 is datavector---------")
      (|dcData1| (CDDDR (ELT |u| 3)))
      '|done|))))

; dcAll con ==
;   con := abbreviation? con or con
;   $infovec : local := getInfovec con
;   complete? :=
;     #$infovec = 4 => false
;     $infovec.4 = 'lookupComplete
;   sayBrightly '"----------------Template-----------------"
;   dcSlots con
;   sayBrightly
;     complete? => '"----------Complete Ops----------------"
;     '"----------Incomplete Ops---------------"
;   dcOpTable con
;   sayBrightly '"----------------Preds-----------------"
;   dcPreds con
;   sayBrightly '"----------------Cats-----------------"
;   dcCats con
;   sayBrightly '"----------------Data------------------"
;   dcData con
;   sayBrightly '"----------------Size------------------"
;   dcSize(con,'full)
;   'done

(DEFUN |dcAll| (|con|)
  (PROG (|$infovec| |complete?|)
    (DECLARE (SPECIAL |$infovec|))
    (RETURN
     (PROGN
      (SETQ |con| (OR (|abbreviation?| |con|) |con|))
      (SETQ |$infovec| (|getInfovec| |con|))
      (SETQ |complete?|
              (COND ((EQL (LENGTH |$infovec|) 4) NIL)
                    (#1='T (EQ (ELT |$infovec| 4) '|lookupComplete|))))
      (|sayBrightly| "----------------Template-----------------")
      (|dcSlots| |con|)
      (|sayBrightly|
       (COND (|complete?| "----------Complete Ops----------------")
             (#1# "----------Incomplete Ops---------------")))
      (|dcOpTable| |con|)
      (|sayBrightly| "----------------Preds-----------------")
      (|dcPreds| |con|)
      (|sayBrightly| "----------------Cats-----------------")
      (|dcCats| |con|)
      (|sayBrightly| "----------------Data------------------")
      (|dcData| |con|)
      (|sayBrightly| "----------------Size------------------")
      (|dcSize| |con| '|full|)
      '|done|))))

; dcOps conname ==
;   for [op,:u] in REVERSE getOperationAlistFromLisplib conname repeat
;     for [sig,slot,pred,key,:.] in u repeat
;       suffix :=
;         atom pred => nil
;         concat('" if ",pred2English pred)
;       sayBrightly [:formatOpSignature(op,sig),:suffix]

(DEFUN |dcOps| (|conname|)
  (PROG (|op| |u| |sig| |ISTMP#1| |slot| |ISTMP#2| |pred| |ISTMP#3| |key|
         |suffix|)
    (RETURN
     ((LAMBDA (|bfVar#89| |bfVar#88|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#89|)
               (PROGN (SETQ |bfVar#88| (CAR |bfVar#89|)) NIL))
           (RETURN NIL))
          (#1='T
           (AND (CONSP |bfVar#88|)
                (PROGN
                 (SETQ |op| (CAR |bfVar#88|))
                 (SETQ |u| (CDR |bfVar#88|))
                 #1#)
                ((LAMBDA (|bfVar#91| |bfVar#90|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#91|)
                          (PROGN (SETQ |bfVar#90| (CAR |bfVar#91|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (AND (CONSP |bfVar#90|)
                           (PROGN
                            (SETQ |sig| (CAR |bfVar#90|))
                            (SETQ |ISTMP#1| (CDR |bfVar#90|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |slot| (CAR |ISTMP#1|))
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (PROGN
                                        (SETQ |pred| (CAR |ISTMP#2|))
                                        (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                        (AND (CONSP |ISTMP#3|)
                                             (PROGN
                                              (SETQ |key| (CAR |ISTMP#3|))
                                              #1#)))))))
                           (PROGN
                            (SETQ |suffix|
                                    (COND ((ATOM |pred|) NIL)
                                          (#1#
                                           (|concat| " if "
                                            (|pred2English| |pred|)))))
                            (|sayBrightly|
                             (APPEND (|formatOpSignature| |op| |sig|)
                                     |suffix|))))))
                    (SETQ |bfVar#91| (CDR |bfVar#91|))))
                 |u| NIL))))
         (SETQ |bfVar#89| (CDR |bfVar#89|))))
      (REVERSE (|getOperationAlistFromLisplib| |conname|)) NIL))))

; NRTgetLookupFunction(domform,exCategory,addForm) ==
;   domform := SUBLIS($pairlis,domform)
;   addForm := SUBLIS($pairlis,addForm)
;   $why: local := nil
;   atom addForm => 'lookupComplete
;   extends := NRTextendsCategory1(domform,exCategory,getExportCategory addForm)
;   if null extends then
;     [u,msg,:v] := $why
;     sayBrightly '"--------------non extending category----------------------"
;     sayBrightlyNT ['"..",:bright form2String domform,"of cat "]
;     PRINT u
;     sayBrightlyNT bright msg
;     if v then PRINT first v else TERPRI()
;   extends => 'lookupIncomplete
;   'lookupComplete

(DEFUN |NRTgetLookupFunction| (|domform| |exCategory| |addForm|)
  (PROG (|$why| |v| |msg| |u| |extends|)
    (DECLARE (SPECIAL |$why|))
    (RETURN
     (PROGN
      (SETQ |domform| (SUBLIS |$pairlis| |domform|))
      (SETQ |addForm| (SUBLIS |$pairlis| |addForm|))
      (SETQ |$why| NIL)
      (COND ((ATOM |addForm|) '|lookupComplete|)
            (#1='T
             (PROGN
              (SETQ |extends|
                      (|NRTextendsCategory1| |domform| |exCategory|
                       (|getExportCategory| |addForm|)))
              (COND
               ((NULL |extends|) (SETQ |u| (CAR |$why|))
                (SETQ |msg| (CADR . #2=(|$why|))) (SETQ |v| (CDDR . #2#))
                (|sayBrightly|
                 "--------------non extending category----------------------")
                (|sayBrightlyNT|
                 (CONS ".."
                       (APPEND (|bright| (|form2String| |domform|))
                               (CONS '|of cat | NIL))))
                (PRINT |u|) (|sayBrightlyNT| (|bright| |msg|))
                (COND (|v| (PRINT (CAR |v|))) (#1# (TERPRI)))))
              (COND (|extends| '|lookupIncomplete|)
                    (#1# '|lookupComplete|)))))))))

; getExportCategory form ==
;   [op,:argl] := form
;   op = 'Record => ['RecordCategory,:argl]
;   op = 'Union => ['UnionCategory,:argl]
;   functorModemap := GETDATABASE(op,'CONSTRUCTORMODEMAP)
;   [[.,target,:tl],:.] := functorModemap
;   EQSUBSTLIST(argl,$FormalMapVariableList,target)

(DEFUN |getExportCategory| (|form|)
  (PROG (|op| |argl| |functorModemap| |target| |tl|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |form|))
      (SETQ |argl| (CDR |form|))
      (COND ((EQ |op| '|Record|) (CONS '|RecordCategory| |argl|))
            ((EQ |op| '|Union|) (CONS '|UnionCategory| |argl|))
            ('T
             (PROGN
              (SETQ |functorModemap| (GETDATABASE |op| 'CONSTRUCTORMODEMAP))
              (SETQ |target| (CADAR . #1=(|functorModemap|)))
              (SETQ |tl| (CDDAR . #1#))
              (EQSUBSTLIST |argl| |$FormalMapVariableList| |target|))))))))

; NRTextendsCategory1(domform,exCategory,addForm) ==
;   addForm is ["@Tuple", :r] =>
;     and/[extendsCategory(domform,exCategory,x) for x in r]
;   extendsCategory(domform,exCategory,addForm)

(DEFUN |NRTextendsCategory1| (|domform| |exCategory| |addForm|)
  (PROG (|r|)
    (RETURN
     (COND
      ((AND (CONSP |addForm|) (EQ (CAR |addForm|) '|@Tuple|)
            (PROGN (SETQ |r| (CDR |addForm|)) #1='T))
       ((LAMBDA (|bfVar#93| |bfVar#92| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#92|) (PROGN (SETQ |x| (CAR |bfVar#92|)) NIL))
             (RETURN |bfVar#93|))
            (#1#
             (PROGN
              (SETQ |bfVar#93| (|extendsCategory| |domform| |exCategory| |x|))
              (COND ((NOT |bfVar#93|) (RETURN NIL))))))
           (SETQ |bfVar#92| (CDR |bfVar#92|))))
        T |r| NIL))
      (#1# (|extendsCategory| |domform| |exCategory| |addForm|))))))

; extendsCategory(dom,u,v) ==
;   --does category u extend category v (yes iff u contains everything in v)
;   --is dom of category u also of category v?
;   u=v => true
;   v is ["Join",:l] => and/[extendsCategory(dom,u,x) for x in l]
;   v is ["CATEGORY",.,:l] => and/[extendsCategory(dom,u,x) for x in l]
;   v := substSlotNumbers(v,$template,$functorForm)
;   extendsCategoryBasic0(dom,u,v) => true
;   $why :=
;     v is ['SIGNATURE,op,sig] => [u,['"  has no ",:formatOpSignature(op,sig)]]
;     [u,'" has no",v]
;   nil

(DEFUN |extendsCategory| (|dom| |u| |v|)
  (PROG (|l| |ISTMP#1| |op| |ISTMP#2| |sig|)
    (RETURN
     (COND ((EQUAL |u| |v|) T)
           ((AND (CONSP |v|) (EQ (CAR |v|) '|Join|)
                 (PROGN (SETQ |l| (CDR |v|)) #1='T))
            ((LAMBDA (|bfVar#95| |bfVar#94| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#94|)
                      (PROGN (SETQ |x| (CAR |bfVar#94|)) NIL))
                  (RETURN |bfVar#95|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#95| (|extendsCategory| |dom| |u| |x|))
                   (COND ((NOT |bfVar#95|) (RETURN NIL))))))
                (SETQ |bfVar#94| (CDR |bfVar#94|))))
             T |l| NIL))
           ((AND (CONSP |v|) (EQ (CAR |v|) 'CATEGORY)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |v|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |l| (CDR |ISTMP#1|)) #1#))))
            ((LAMBDA (|bfVar#97| |bfVar#96| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#96|)
                      (PROGN (SETQ |x| (CAR |bfVar#96|)) NIL))
                  (RETURN |bfVar#97|))
                 (#1#
                  (PROGN
                   (SETQ |bfVar#97| (|extendsCategory| |dom| |u| |x|))
                   (COND ((NOT |bfVar#97|) (RETURN NIL))))))
                (SETQ |bfVar#96| (CDR |bfVar#96|))))
             T |l| NIL))
           (#1#
            (PROGN
             (SETQ |v| (|substSlotNumbers| |v| |$template| |$functorForm|))
             (COND ((|extendsCategoryBasic0| |dom| |u| |v|) T)
                   (#1#
                    (PROGN
                     (SETQ |$why|
                             (COND
                              ((AND (CONSP |v|) (EQ (CAR |v|) 'SIGNATURE)
                                    (PROGN
                                     (SETQ |ISTMP#1| (CDR |v|))
                                     (AND (CONSP |ISTMP#1|)
                                          (PROGN
                                           (SETQ |op| (CAR |ISTMP#1|))
                                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                           (AND (CONSP |ISTMP#2|)
                                                (EQ (CDR |ISTMP#2|) NIL)
                                                (PROGN
                                                 (SETQ |sig| (CAR |ISTMP#2|))
                                                 #1#))))))
                               (LIST |u|
                                     (CONS "  has no "
                                           (|formatOpSignature| |op| |sig|))))
                              (#1# (LIST |u| " has no" |v|))))
                     NIL)))))))))

; extendsCategoryBasic0(dom,u,v) ==
;   v is ['IF,p,['ATTRIBUTE,c],.] =>
;     -- BREAK()
;     uVec := (compMakeCategoryObject(u, $EmptyEnvironment)).expr
;     null atom c and isCategoryForm(c) =>
;       slot4 := uVec.4
;       LASSOC(c,CADR slot4) is [=p,:.]
;     slot2 := uVec.2
;     LASSOC(c,slot2) is [=p,:.]
;   extendsCategoryBasic(dom,u,v)

(DEFUN |extendsCategoryBasic0| (|dom| |u| |v|)
  (PROG (|ISTMP#1| |p| |ISTMP#2| |ISTMP#3| |ISTMP#4| |c| |ISTMP#5| |uVec|
         |slot4| |slot2|)
    (RETURN
     (COND
      ((AND (CONSP |v|) (EQ (CAR |v|) 'IF)
            (PROGN
             (SETQ |ISTMP#1| (CDR |v|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |p| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|)
                        (PROGN
                         (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                         (AND (CONSP |ISTMP#3|) (EQ (CAR |ISTMP#3|) 'ATTRIBUTE)
                              (PROGN
                               (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                               (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                    (PROGN
                                     (SETQ |c| (CAR |ISTMP#4|))
                                     #1='T)))))
                        (PROGN
                         (SETQ |ISTMP#5| (CDR |ISTMP#2|))
                         (AND (CONSP |ISTMP#5|) (EQ (CDR |ISTMP#5|) NIL))))))))
       (PROGN
        (SETQ |uVec| (CAR (|compMakeCategoryObject| |u| |$EmptyEnvironment|)))
        (COND
         ((AND (NULL (ATOM |c|)) (|isCategoryForm| |c|))
          (PROGN
           (SETQ |slot4| (ELT |uVec| 4))
           (SETQ |ISTMP#1| (LASSOC |c| (CADR |slot4|)))
           (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |p|))))
         (#1#
          (PROGN
           (SETQ |slot2| (ELT |uVec| 2))
           (SETQ |ISTMP#1| (LASSOC |c| |slot2|))
           (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |p|)))))))
      (#1# (|extendsCategoryBasic| |dom| |u| |v|))))))

; extendsCategoryBasic(dom,u,v) ==
;   u is ["Join",:l] => or/[extendsCategoryBasic(dom,x,v) for x in l]
;   u = v => true
;   uVec := (compMakeCategoryObject(u, $EmptyEnvironment)).expr
;   isCategoryForm(v) => catExtendsCat?(u, v, uVec)
;   v is ['SIGNATURE,op,sig] =>
;       res := false
;       for csig in uVec.1 repeat
;           not(csig is [[=op, sig], pred, :.]) => "iterate"
;           pred = true =>
;               res := true
;               return true
;       res
;   u is ['CATEGORY,.,:l] =>
;     v is ['IF,:.] => member(v,l)
;     nil
;   nil

(DEFUN |extendsCategoryBasic| (|dom| |u| |v|)
  (PROG (|l| |uVec| |ISTMP#1| |op| |ISTMP#2| |sig| |res| |ISTMP#3| |pred|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQ (CAR |u|) '|Join|)
            (PROGN (SETQ |l| (CDR |u|)) #1='T))
       ((LAMBDA (|bfVar#99| |bfVar#98| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#98|) (PROGN (SETQ |x| (CAR |bfVar#98|)) NIL))
             (RETURN |bfVar#99|))
            (#1#
             (PROGN
              (SETQ |bfVar#99| (|extendsCategoryBasic| |dom| |x| |v|))
              (COND (|bfVar#99| (RETURN |bfVar#99|))))))
           (SETQ |bfVar#98| (CDR |bfVar#98|))))
        NIL |l| NIL))
      ((EQUAL |u| |v|) T)
      (#1#
       (PROGN
        (SETQ |uVec| (CAR (|compMakeCategoryObject| |u| |$EmptyEnvironment|)))
        (COND ((|isCategoryForm| |v|) (|catExtendsCat?| |u| |v| |uVec|))
              ((AND (CONSP |v|) (EQ (CAR |v|) 'SIGNATURE)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |v|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |op| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1#))))))
               (PROGN
                (SETQ |res| NIL)
                ((LAMBDA (|bfVar#100| |csig|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#100|)
                          (PROGN (SETQ |csig| (CAR |bfVar#100|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (COND
                       ((NULL
                         (AND (CONSP |csig|)
                              (PROGN
                               (SETQ |ISTMP#1| (CAR |csig|))
                               (AND (CONSP |ISTMP#1|)
                                    (EQUAL (CAR |ISTMP#1|) |op|)
                                    (PROGN
                                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                     (AND (CONSP |ISTMP#2|)
                                          (EQ (CDR |ISTMP#2|) NIL)
                                          (PROGN
                                           (SETQ |sig| (CAR |ISTMP#2|))
                                           #1#)))))
                              (PROGN
                               (SETQ |ISTMP#3| (CDR |csig|))
                               (AND (CONSP |ISTMP#3|)
                                    (PROGN
                                     (SETQ |pred| (CAR |ISTMP#3|))
                                     #1#)))))
                        '|iterate|)
                       ((EQUAL |pred| T) (PROGN (SETQ |res| T) (RETURN T))))))
                    (SETQ |bfVar#100| (CDR |bfVar#100|))))
                 (ELT |uVec| 1) NIL)
                |res|))
              ((AND (CONSP |u|) (EQ (CAR |u|) 'CATEGORY)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |u|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN (SETQ |l| (CDR |ISTMP#1|)) #1#))))
               (COND ((AND (CONSP |v|) (EQ (CAR |v|) 'IF)) (|member| |v| |l|))
                     (#1# NIL)))
              (#1# NIL))))))))

; catExtendsCat?(u,v,uvec) ==
;   u = v => true
;   uvec := uvec or (compMakeCategoryObject(u, $EmptyEnvironment)).expr
;   slot4 := uvec.4
;   prinAncestorList := first slot4
;   member(v,prinAncestorList) => true
;   vOp := IFCAR v
;   if similarForm := assoc(vOp,prinAncestorList) then
;     PRINT u
;     sayBrightlyNT '"   extends "
;     PRINT similarForm
;     sayBrightlyNT '"   but not "
;     PRINT v
;   or/[catExtendsCat?(x,v,nil) for x in ASSOCLEFT CADR slot4]

(DEFUN |catExtendsCat?| (|u| |v| |uvec|)
  (PROG (|slot4| |prinAncestorList| |vOp| |similarForm|)
    (RETURN
     (COND ((EQUAL |u| |v|) T)
           (#1='T
            (PROGN
             (SETQ |uvec|
                     (OR |uvec|
                         (CAR
                          (|compMakeCategoryObject| |u| |$EmptyEnvironment|))))
             (SETQ |slot4| (ELT |uvec| 4))
             (SETQ |prinAncestorList| (CAR |slot4|))
             (COND ((|member| |v| |prinAncestorList|) T)
                   (#1#
                    (PROGN
                     (SETQ |vOp| (IFCAR |v|))
                     (COND
                      ((SETQ |similarForm| (|assoc| |vOp| |prinAncestorList|))
                       (PRINT |u|) (|sayBrightlyNT| "   extends ")
                       (PRINT |similarForm|) (|sayBrightlyNT| "   but not ")
                       (PRINT |v|)))
                     ((LAMBDA (|bfVar#102| |bfVar#101| |x|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#101|)
                               (PROGN (SETQ |x| (CAR |bfVar#101|)) NIL))
                           (RETURN |bfVar#102|))
                          (#1#
                           (PROGN
                            (SETQ |bfVar#102| (|catExtendsCat?| |x| |v| NIL))
                            (COND (|bfVar#102| (RETURN |bfVar#102|))))))
                         (SETQ |bfVar#101| (CDR |bfVar#101|))))
                      NIL (ASSOCLEFT (CADR |slot4|)) NIL))))))))))

; substSlotNumbers(form,template,domain) ==
;   form is [op,:.] and
;     MEMQ(op,allConstructors()) => expandType(form,template,domain)
;   form is ['SIGNATURE,op,sig] =>
;     ['SIGNATURE,op,[substSlotNumbers(x,template,domain) for x in sig]]
;   form is ['CATEGORY,k,:u] =>
;     ['CATEGORY,k,:[substSlotNumbers(x,template,domain) for x in u]]
;   expandType(form,template,domain)

(DEFUN |substSlotNumbers| (|form| |template| |domain|)
  (PROG (|op| |ISTMP#1| |ISTMP#2| |sig| |k| |u|)
    (RETURN
     (COND
      ((AND (CONSP |form|) (PROGN (SETQ |op| (CAR |form|)) #1='T)
            (MEMQ |op| (|allConstructors|)))
       (|expandType| |form| |template| |domain|))
      ((AND (CONSP |form|) (EQ (CAR |form|) 'SIGNATURE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |form|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |op| (CAR |ISTMP#1|))
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |sig| (CAR |ISTMP#2|)) #1#))))))
       (LIST 'SIGNATURE |op|
             ((LAMBDA (|bfVar#104| |bfVar#103| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#103|)
                       (PROGN (SETQ |x| (CAR |bfVar#103|)) NIL))
                   (RETURN (NREVERSE |bfVar#104|)))
                  (#1#
                   (SETQ |bfVar#104|
                           (CONS (|substSlotNumbers| |x| |template| |domain|)
                                 |bfVar#104|))))
                 (SETQ |bfVar#103| (CDR |bfVar#103|))))
              NIL |sig| NIL)))
      ((AND (CONSP |form|) (EQ (CAR |form|) 'CATEGORY)
            (PROGN
             (SETQ |ISTMP#1| (CDR |form|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |k| (CAR |ISTMP#1|))
                   (SETQ |u| (CDR |ISTMP#1|))
                   #1#))))
       (CONS 'CATEGORY
             (CONS |k|
                   ((LAMBDA (|bfVar#106| |bfVar#105| |x|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#105|)
                             (PROGN (SETQ |x| (CAR |bfVar#105|)) NIL))
                         (RETURN (NREVERSE |bfVar#106|)))
                        (#1#
                         (SETQ |bfVar#106|
                                 (CONS
                                  (|substSlotNumbers| |x| |template| |domain|)
                                  |bfVar#106|))))
                       (SETQ |bfVar#105| (CDR |bfVar#105|))))
                    NIL |u| NIL))))
      (#1# (|expandType| |form| |template| |domain|))))))

; expandType(lazyt,template,domform) ==
;   atom lazyt => expandTypeArgs(lazyt,template,domform)
;   [functorName,:argl] := lazyt
;   MEMQ(functorName, '(Record Union)) and first argl is [":",:.] =>
;      [functorName,:[['_:,tag,expandTypeArgs(dom,template,domform)]
;                                  for [.,tag,dom] in argl]]
;   lazyt is ['local,x] =>
;     n := POSN1(x,$FormalMapVariableList)
;     ELT(domform,1 + n)
;   [functorName,:[expandTypeArgs(a,template,domform) for a in argl]]

(DEFUN |expandType| (|lazyt| |template| |domform|)
  (PROG (|functorName| |argl| |ISTMP#1| |tag| |ISTMP#2| |dom| |x| |n|)
    (RETURN
     (COND ((ATOM |lazyt|) (|expandTypeArgs| |lazyt| |template| |domform|))
           (#1='T
            (PROGN
             (SETQ |functorName| (CAR |lazyt|))
             (SETQ |argl| (CDR |lazyt|))
             (COND
              ((AND (MEMQ |functorName| '(|Record| |Union|))
                    (PROGN
                     (SETQ |ISTMP#1| (CAR |argl|))
                     (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|))))
               (CONS |functorName|
                     ((LAMBDA (|bfVar#109| |bfVar#108| |bfVar#107|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#108|)
                               (PROGN
                                (SETQ |bfVar#107| (CAR |bfVar#108|))
                                NIL))
                           (RETURN (NREVERSE |bfVar#109|)))
                          (#1#
                           (AND (CONSP |bfVar#107|)
                                (PROGN
                                 (SETQ |ISTMP#1| (CDR |bfVar#107|))
                                 (AND (CONSP |ISTMP#1|)
                                      (PROGN
                                       (SETQ |tag| (CAR |ISTMP#1|))
                                       (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                       (AND (CONSP |ISTMP#2|)
                                            (EQ (CDR |ISTMP#2|) NIL)
                                            (PROGN
                                             (SETQ |dom| (CAR |ISTMP#2|))
                                             #1#)))))
                                (SETQ |bfVar#109|
                                        (CONS
                                         (LIST '|:| |tag|
                                               (|expandTypeArgs| |dom|
                                                |template| |domform|))
                                         |bfVar#109|)))))
                         (SETQ |bfVar#108| (CDR |bfVar#108|))))
                      NIL |argl| NIL)))
              ((AND (CONSP |lazyt|) (EQ (CAR |lazyt|) '|local|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |lazyt|))
                     (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                          (PROGN (SETQ |x| (CAR |ISTMP#1|)) #1#))))
               (PROGN
                (SETQ |n| (POSN1 |x| |$FormalMapVariableList|))
                (ELT |domform| (+ 1 |n|))))
              (#1#
               (CONS |functorName|
                     ((LAMBDA (|bfVar#111| |bfVar#110| |a|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#110|)
                               (PROGN (SETQ |a| (CAR |bfVar#110|)) NIL))
                           (RETURN (NREVERSE |bfVar#111|)))
                          (#1#
                           (SETQ |bfVar#111|
                                   (CONS
                                    (|expandTypeArgs| |a| |template| |domform|)
                                    |bfVar#111|))))
                         (SETQ |bfVar#110| (CDR |bfVar#110|))))
                      NIL |argl| NIL))))))))))

; expandTypeArgs(u,template,domform) ==
;   u = '$ => u --template.0      -------eliminate this as $ is rep by 0
;   INTEGERP u => expandType(templateVal(template, domform, u), template,domform)
;   u is ['NRTEVAL,y] => y  --eval  y
;   u is ['QUOTE,y] => y
;   atom u => u
;   expandType(u,template,domform)

(DEFUN |expandTypeArgs| (|u| |template| |domform|)
  (PROG (|ISTMP#1| |y|)
    (RETURN
     (COND ((EQ |u| '$) |u|)
           ((INTEGERP |u|)
            (|expandType| (|templateVal| |template| |domform| |u|) |template|
             |domform|))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'NRTEVAL)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1='T))))
            |y|)
           ((AND (CONSP |u|) (EQ (CAR |u|) 'QUOTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
            |y|)
           ((ATOM |u|) |u|) (#1# (|expandType| |u| |template| |domform|))))))

; templateVal(template,domform,index) ==
; --returns a domform or a lazy slot
;   index = 0 => harhar() --template
;   template.index

(DEFUN |templateVal| (|template| |domform| |index|)
  (PROG ()
    (RETURN (COND ((EQL |index| 0) (|harhar|)) ('T (ELT |template| |index|))))))


; )package "BOOT"

(IN-PACKAGE "BOOT")

; NRTevalDomain form ==
;   form is ['SETELT,:.] =>
;       BREAK()
;       eval form
;   evalDomain form

(DEFUN |NRTevalDomain| (|form|)
  (PROG ()
    (RETURN
     (COND
      ((AND (CONSP |form|) (EQ (CAR |form|) 'SETELT))
       (PROGN (BREAK) (|eval| |form|)))
      ('T (|evalDomain| |form|))))))

; compiledLookupCheck(op,sig,dollar) ==
;   fn := compiledLookup(op,sig,dollar)
;
;   fn = nil =>
;     keyedSystemError("S2NR0001",[op,formatSignature sig,dollar.0])
;   fn

(DEFUN |compiledLookupCheck| (|op| |sig| |dollar|)
  (PROG (|fn|)
    (RETURN
     (PROGN
      (SETQ |fn| (|compiledLookup| |op| |sig| |dollar|))
      (COND
       ((NULL |fn|)
        (|keyedSystemError| 'S2NR0001
         (LIST |op| (|formatSignature| |sig|) (ELT |dollar| 0))))
       ('T |fn|))))))

; NRTreplaceLocalTypes(t,dom) ==
;    atom t =>
;      not INTEGERP t => t
;      t:= dom.t
;      if PAIRP t then t:= NRTevalDomain t
;      t.0
;    MEMQ(first t, '(Mapping Union Record _:)) =>
;       [first t, :[NRTreplaceLocalTypes(x, dom) for x in rest t]]
;    t

(DEFUN |NRTreplaceLocalTypes| (|t| |dom|)
  (PROG ()
    (RETURN
     (COND
      ((ATOM |t|)
       (COND ((NULL (INTEGERP |t|)) |t|)
             (#1='T
              (PROGN
               (SETQ |t| (ELT |dom| |t|))
               (COND ((CONSP |t|) (SETQ |t| (|NRTevalDomain| |t|))))
               (ELT |t| 0)))))
      ((MEMQ (CAR |t|) '(|Mapping| |Union| |Record| |:|))
       (CONS (CAR |t|)
             ((LAMBDA (|bfVar#2| |bfVar#1| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
                   (RETURN (NREVERSE |bfVar#2|)))
                  (#1#
                   (SETQ |bfVar#2|
                           (CONS (|NRTreplaceLocalTypes| |x| |dom|)
                                 |bfVar#2|))))
                 (SETQ |bfVar#1| (CDR |bfVar#1|))))
              NIL (CDR |t|) NIL)))
      (#1# |t|)))))

; substDomainArgs(domain,object) ==
;     form := devaluate domain
;     SUBLISLIS([form,:rest form],["$$",:$FormalMapVariableList],object)

(DEFUN |substDomainArgs| (|domain| |object|)
  (PROG (|form|)
    (RETURN
     (PROGN
      (SETQ |form| (|devaluate| |domain|))
      (SUBLISLIS (CONS |form| (CDR |form|)) (CONS '$$ |$FormalMapVariableList|)
       |object|)))))

; lookupInTable(op,sig,dollar,[domain,table]) ==
;   success := false
;   while not success for [sig1, :code] in QLASSQ(op, table) repeat
;     success :=
;       null compareSig(sig,sig1,dollar.0,domain) => false
;       loc := code
;       loc = 0 => BREAK()
;       slot := domain.loc
;       lookupDisplay(op,sig,domain,'" !! found in NEW table!!")
;       slot
;   success

(DEFUN |lookupInTable| (|op| |sig| |dollar| |bfVar#5|)
  (PROG (|domain| |table| |success| |sig1| |code| |loc| |slot|)
    (RETURN
     (PROGN
      (SETQ |domain| (CAR |bfVar#5|))
      (SETQ |table| (CADR |bfVar#5|))
      (SETQ |success| NIL)
      ((LAMBDA (|bfVar#4| |bfVar#3|)
         (LOOP
          (COND
           ((OR |success| (ATOM |bfVar#4|)
                (PROGN (SETQ |bfVar#3| (CAR |bfVar#4|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#3|)
                 (PROGN
                  (SETQ |sig1| (CAR |bfVar#3|))
                  (SETQ |code| (CDR |bfVar#3|))
                  #1#)
                 (SETQ |success|
                         (COND
                          ((NULL
                            (|compareSig| |sig| |sig1| (ELT |dollar| 0)
                             |domain|))
                           NIL)
                          (#1#
                           (PROGN
                            (SETQ |loc| |code|)
                            (COND ((EQL |loc| 0) (BREAK))
                                  (#1#
                                   (PROGN
                                    (SETQ |slot| (ELT |domain| |loc|))
                                    (|lookupDisplay| |op| |sig| |domain|
                                     " !! found in NEW table!!")
                                    |slot|))))))))))
          (SETQ |bfVar#4| (CDR |bfVar#4|))))
       (QLASSQ |op| |table|) NIL)
      |success|))))

; compareSig(sig,tableSig,dollar,domain) ==
;   not (#sig = #tableSig) => false
;   null (target := first sig)
;    or lazyCompareSigEqual(target,first tableSig,dollar,domain) =>
;      and/[lazyCompareSigEqual(s,t,dollar,domain)
;               for s in rest sig for t in rest tableSig]

(DEFUN |compareSig| (|sig| |tableSig| |dollar| |domain|)
  (PROG (|target|)
    (RETURN
     (COND ((NULL (EQL (LENGTH |sig|) (LENGTH |tableSig|))) NIL)
           ((OR (NULL (SETQ |target| (CAR |sig|)))
                (|lazyCompareSigEqual| |target| (CAR |tableSig|) |dollar|
                 |domain|))
            ((LAMBDA (|bfVar#8| |bfVar#6| |s| |bfVar#7| |t|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#6|) (PROGN (SETQ |s| (CAR |bfVar#6|)) NIL)
                      (ATOM |bfVar#7|) (PROGN (SETQ |t| (CAR |bfVar#7|)) NIL))
                  (RETURN |bfVar#8|))
                 ('T
                  (PROGN
                   (SETQ |bfVar#8|
                           (|lazyCompareSigEqual| |s| |t| |dollar| |domain|))
                   (COND ((NOT |bfVar#8|) (RETURN NIL))))))
                (SETQ |bfVar#6| (CDR |bfVar#6|))
                (SETQ |bfVar#7| (CDR |bfVar#7|))))
             T (CDR |sig|) NIL (CDR |tableSig|) NIL))))))

; lazyCompareSigEqual(s,tslot,dollar,domain) ==
;   tslot = '$ => s = tslot
;   INTEGERP tslot and PAIRP(lazyt:=domain.tslot) and PAIRP s =>
;       lazyt is [.,.,.,[.,item,.]] and
;         item is [., [functorName, :.]] and functorName = first s =>
;           compareSigEqual(s,(NRTevalDomain lazyt).0,dollar,domain)
;       nil
;   compareSigEqual(s,NRTreplaceLocalTypes(tslot,domain),dollar,domain)

(DEFUN |lazyCompareSigEqual| (|s| |tslot| |dollar| |domain|)
  (PROG (|lazyt| |ISTMP#1| |ISTMP#2| |ISTMP#3| |ISTMP#4| |ISTMP#5| |item|
         |ISTMP#6| |functorName|)
    (RETURN
     (COND ((EQ |tslot| '$) (EQUAL |s| |tslot|))
           ((AND (INTEGERP |tslot|)
                 (CONSP (SETQ |lazyt| (ELT |domain| |tslot|))) (CONSP |s|))
            (COND
             ((AND (CONSP |lazyt|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |lazyt|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|)
                               (PROGN
                                (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                (AND (CONSP |ISTMP#3|) (EQ (CDR |ISTMP#3|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                                      (AND (CONSP |ISTMP#4|)
                                           (PROGN
                                            (SETQ |ISTMP#5| (CDR |ISTMP#4|))
                                            (AND (CONSP |ISTMP#5|)
                                                 (PROGN
                                                  (SETQ |item| (CAR |ISTMP#5|))
                                                  (SETQ |ISTMP#6|
                                                          (CDR |ISTMP#5|))
                                                  (AND (CONSP |ISTMP#6|)
                                                       (EQ (CDR |ISTMP#6|)
                                                           NIL)))))))))))))
                   (CONSP |item|)
                   (PROGN
                    (SETQ |ISTMP#1| (CDR |item|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN
                          (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|)
                               (PROGN
                                (SETQ |functorName| (CAR |ISTMP#2|))
                                #1='T)))))
                   (EQUAL |functorName| (CAR |s|)))
              (|compareSigEqual| |s| (ELT (|NRTevalDomain| |lazyt|) 0) |dollar|
               |domain|))
             (#1# NIL)))
           (#1#
            (|compareSigEqual| |s| (|NRTreplaceLocalTypes| |tslot| |domain|)
             |dollar| |domain|))))))

; compareSigEqual(s,t,dollar,domain) ==
;   EQUAL(s,t) => true
;   ATOM t =>
;     u :=
;       EQ(t,'$) => dollar
;       isSharpVar t =>
;         VECP domain => ELT(rest domain.0,POSN1(t,$FormalMapVariableList))
;         ELT(rest domain,POSN1(t,$FormalMapVariableList))
;       STRINGP t and IDENTP s => (s := PNAME s; t)
;       nil
;     s = '$ => compareSigEqual(dollar,u,dollar,domain)
;     u => compareSigEqual(s,u,dollar,domain)
;     EQUAL(s,u)
;   EQ(s,'$) => compareSigEqual(dollar,t,dollar,domain)
;   ATOM s => nil
;   #s ~= #t => nil
;   match := true
;   for u in s for v in t repeat
;     not compareSigEqual(u,v,dollar,domain) => return(match:=false)
;   match

(DEFUN |compareSigEqual| (|s| |t| |dollar| |domain|)
  (PROG (|u| |match|)
    (RETURN
     (COND ((EQUAL |s| |t|) T)
           ((ATOM |t|)
            (PROGN
             (SETQ |u|
                     (COND ((EQ |t| '$) |dollar|)
                           ((|isSharpVar| |t|)
                            (COND
                             ((VECP |domain|)
                              (ELT (CDR (ELT |domain| 0))
                                   (POSN1 |t| |$FormalMapVariableList|)))
                             (#1='T
                              (ELT (CDR |domain|)
                                   (POSN1 |t| |$FormalMapVariableList|)))))
                           ((AND (STRINGP |t|) (IDENTP |s|))
                            (PROGN (SETQ |s| (PNAME |s|)) |t|))
                           (#1# NIL)))
             (COND
              ((EQ |s| '$) (|compareSigEqual| |dollar| |u| |dollar| |domain|))
              (|u| (|compareSigEqual| |s| |u| |dollar| |domain|))
              (#1# (EQUAL |s| |u|)))))
           ((EQ |s| '$) (|compareSigEqual| |dollar| |t| |dollar| |domain|))
           ((ATOM |s|) NIL) ((NOT (EQL (LENGTH |s|) (LENGTH |t|))) NIL)
           (#1#
            (PROGN
             (SETQ |match| T)
             ((LAMBDA (|bfVar#9| |u| |bfVar#10| |v|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#9|) (PROGN (SETQ |u| (CAR |bfVar#9|)) NIL)
                       (ATOM |bfVar#10|)
                       (PROGN (SETQ |v| (CAR |bfVar#10|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (COND
                    ((NULL (|compareSigEqual| |u| |v| |dollar| |domain|))
                     (IDENTITY (RETURN (SETQ |match| NIL)))))))
                 (SETQ |bfVar#9| (CDR |bfVar#9|))
                 (SETQ |bfVar#10| (CDR |bfVar#10|))))
              |s| NIL |t| NIL)
             |match|))))))

; NRT_opt_call(u, opName, sigTail,dcVector) ==
;     dc := devaluate(dcVector)
;     -- sayBrightly(["NRT_opt_call ", u, opName, sigTail, dc])
;     not MEMQ(IFCAR dc, $optimizableConstructorNames) => nil
;     NULL(name := BPINAME(first u))  => nil
;     fn := GETL(name, 'SPADreplace) =>
;         n := #dcVector
;         flag := true
;         k := -1
;         for i in 0..(n - 1) while flag repeat
;             if dcVector.i = u then
;                 k := i
;                 flag := false
;         k >= 0 => ["ELT", dc, k]
;         nil
;     nil

(DEFUN |NRT_opt_call| (|u| |opName| |sigTail| |dcVector|)
  (PROG (|dc| |name| |fn| |n| |flag| |k|)
    (RETURN
     (PROGN
      (SETQ |dc| (|devaluate| |dcVector|))
      (COND ((NULL (MEMQ (IFCAR |dc|) |$optimizableConstructorNames|)) NIL)
            ((NULL (SETQ |name| (BPINAME (CAR |u|)))) NIL)
            ((SETQ |fn| (GETL |name| '|SPADreplace|))
             (PROGN
              (SETQ |n| (LENGTH |dcVector|))
              (SETQ |flag| T)
              (SETQ |k| (- 1))
              ((LAMBDA (|bfVar#11| |i|)
                 (LOOP
                  (COND ((OR (> |i| |bfVar#11|) (NOT |flag|)) (RETURN NIL))
                        (#1='T
                         (COND
                          ((EQUAL (ELT |dcVector| |i|) |u|) (SETQ |k| |i|)
                           (SETQ |flag| NIL)))))
                  (SETQ |i| (+ |i| 1))))
               (- |n| 1) 0)
              (COND ((NOT (MINUSP |k|)) (LIST 'ELT |dc| |k|)) (#1# NIL))))
            (#1# NIL))))))

; NRTcompileEvalForm(opName,sigTail,dcVector) ==
;   u := NRTcompiledLookup(opName,sigTail,dcVector)
;   not ($insideCompileBodyIfTrue = true) => MKQ u
;   res1 := NRT_opt_call(u, opName, sigTail, dcVector) => res1
;   k := NRTgetMinivectorIndex(u,opName,sigTail,dcVector)
;   ['ELT,"$$$",k]  --$$$ denotes minivector

(DEFUN |NRTcompileEvalForm| (|opName| |sigTail| |dcVector|)
  (PROG (|u| |res1| |k|)
    (RETURN
     (PROGN
      (SETQ |u| (|NRTcompiledLookup| |opName| |sigTail| |dcVector|))
      (COND ((NULL (EQUAL |$insideCompileBodyIfTrue| T)) (MKQ |u|))
            ((SETQ |res1| (|NRT_opt_call| |u| |opName| |sigTail| |dcVector|))
             |res1|)
            ('T
             (PROGN
              (SETQ |k|
                      (|NRTgetMinivectorIndex| |u| |opName| |sigTail|
                       |dcVector|))
              (LIST 'ELT '$$$ |k|))))))))

; NRTtypeHack t ==
;   ATOM t => t
;   first t = '_# => # CADR t
;   [first t, :[NRTtypeHack tt for tt in rest t]]

(DEFUN |NRTtypeHack| (|t|)
  (PROG ()
    (RETURN
     (COND ((ATOM |t|) |t|) ((EQ (CAR |t|) '|#|) (LENGTH (CADR |t|)))
           (#1='T
            (CONS (CAR |t|)
                  ((LAMBDA (|bfVar#13| |bfVar#12| |tt|)
                     (LOOP
                      (COND
                       ((OR (ATOM |bfVar#12|)
                            (PROGN (SETQ |tt| (CAR |bfVar#12|)) NIL))
                        (RETURN (NREVERSE |bfVar#13|)))
                       (#1#
                        (SETQ |bfVar#13|
                                (CONS (|NRTtypeHack| |tt|) |bfVar#13|))))
                      (SETQ |bfVar#12| (CDR |bfVar#12|))))
                   NIL (CDR |t|) NIL)))))))

; NRTgetMinivectorIndex(u,op,sig,domVector) ==
;   s := # $minivector
;   k := or/[k for k in 0..(s-1)
;         for x in $minivector | EQ(x,u)] => k
;   $minivector := [:$minivector,u]
;   s

(DEFUN |NRTgetMinivectorIndex| (|u| |op| |sig| |domVector|)
  (PROG (|s| |k|)
    (RETURN
     (PROGN
      (SETQ |s| (LENGTH |$minivector|))
      (COND
       ((SETQ |k|
                ((LAMBDA (|bfVar#16| |bfVar#14| |k| |bfVar#15| |x|)
                   (LOOP
                    (COND
                     ((OR (> |k| |bfVar#14|) (ATOM |bfVar#15|)
                          (PROGN (SETQ |x| (CAR |bfVar#15|)) NIL))
                      (RETURN |bfVar#16|))
                     (#1='T
                      (AND (EQ |x| |u|)
                           (PROGN
                            (SETQ |bfVar#16| |k|)
                            (COND (|bfVar#16| (RETURN |bfVar#16|)))))))
                    (SETQ |k| (+ |k| 1))
                    (SETQ |bfVar#15| (CDR |bfVar#15|))))
                 NIL (- |s| 1) 0 |$minivector| NIL))
        |k|)
       (#1#
        (PROGN
         (SETQ |$minivector| (APPEND |$minivector| (CONS |u| NIL)))
         |s|)))))))

; is_op_slot(slot, dom, k, minivector_name, int_vec, bool_vec) ==
;     dom = minivector_name => EQ(slot, $minivector.k)
;     dom = ["Integer"] => EQ(slot, int_vec.k)
;     dom = ["Boolean"] => EQ(slot, bool_vec.k)
;     nil

(DEFUN |is_op_slot| (|slot| |dom| |k| |minivector_name| |int_vec| |bool_vec|)
  (PROG ()
    (RETURN
     (COND
      ((EQUAL |dom| |minivector_name|) (EQ |slot| (ELT |$minivector| |k|)))
      ((EQUAL |dom| (LIST '|Integer|)) (EQ |slot| (ELT |int_vec| |k|)))
      ((EQUAL |dom| (LIST '|Boolean|)) (EQ |slot| (ELT |bool_vec| |k|)))
      ('T NIL)))))

; NRTisRecurrenceRelation(op,body,minivectorName) ==
;   -- returns [body p1 p2 ... pk] for a k-term recurrence relation
;   -- where the n-th term is computed using the (n-1)st,...,(n-k)th
;   -- whose values are initially computed using the expressions
;   -- p1,...,pk respectively; body has #2,#3,... in place of
;   -- f(k-1),f(k-2),...
;
;   body isnt ['COND,:pcl] => false
;   -- body should have a conditional expression which
;   -- gives k boundary values, one general term plus possibly an
;   -- "out of domain" condition
; --pcl is [:.,[ ''T,:mess]] and not (CONTAINED('throwMessage,mess) or
; --  CONTAINED('throwKeyedMsg,mess)) => NIL
;   pcl := [x for x in pcl | not (x is [''T,:mess] and
;     (CONTAINED('throwMessage,mess) or
;       CONTAINED('throwKeyedMsg,mess)))]
;   integer := EVAL $Integer
;   iequalSlot := compiledLookupCheck("=", '((Boolean) $ $), integer)
;   lt_slot := compiledLookupCheck("<", '((Boolean) $ $), integer)
;   le_slot := compiledLookupCheck("<=", '((Boolean) $ $), integer)
;   gt_slot := compiledLookupCheck(">", '((Boolean) $ $), integer)
;   ge_slot := compiledLookupCheck(">=", '((Boolean) $ $), integer)
;   bf := '(Boolean)
;   bf_vec := EVAL bf
;   notpSlot := compiledLookupCheck("not", '((Boolean)(Boolean)), bf_vec)
;   for [p,c] in pcl repeat
;     p is ['SPADCALL, sharpVar, n1, ['ELT, dom, slot]] and
;       is_op_slot(iequalSlot, dom, slot, minivectorName, integer, bf_vec) =>
;         initList:= [[n1,:c],:initList]
;         sharpList := insert(sharpVar,sharpList)
;         n:=n1
;     miscList:= [[p,c],:miscList]
;   miscList isnt [[generalPred,generalTerm]] or sharpList isnt [sharpArg] =>
;       return false
;     --first general term starts at n
;
;   --Must have at least one special value; insist that they be consecutive
;   null initList => false
;   specialValues:= MSORT ASSOCLEFT initList
;   or/[null INTEGERP n for n in specialValues] => false
;   minIndex:= "MIN"/specialValues
;   not (and/[i=x for i in minIndex..(minIndex+n-1) for x in specialValues]) =>
;     sayKeyedMsg("S2IX0005",
;       ["append"/[['" ",sv]  for sv in specialValues]])
;     return nil
;
;   --Determine the order k of the recurrence and index n of first general term
;   k:= #specialValues
;   n:= k+minIndex
;   --Check general predicate
;   predOk :=
;     generalPred is '(QUOTE T) => true
;     generalPred is ['SPADCALL, m1, m2, ['ELT, dom, slot]] =>
;         m2 = sharpArg and is_op_slot(lt_slot, dom, slot,
;                             minivectorName, integer, bf_vec) => m1 + 1
;         m2 = sharpArg and is_op_slot(le_slot, dom, slot,
;                             minivectorName, integer, bf_vec) => m1
;         m1 = sharpArg and is_op_slot(gt_slot, dom, slot,
;                             minivectorName, integer, bf_vec) => m2 + 1
;         m1 = sharpArg and is_op_slot(ge_slot, dom, slot,
;                             minivectorName, integer, bf_vec) => m2
;     generalPred is ['SPADCALL, ['SPADCALL, =sharpArg, m,
;       ['ELT, dom1, slot1]], ['ELT, dom2, slot2]] and
;         is_op_slot(notSlot, dom2, slot2, minivectorName, integer, bf_vec)
;           and is_op_slot(lt_slot, dom1, slot1,
;                          minivectorName, integer, bf_vec) => m
;     generalPred is ['NOT, ['SPADCALL, =sharpArg, m,
;        ['ELT, dom, slot]]] and
;           is_op_slot(lt_slot, dom, slot, minivectorName, integer, bf_vec) => m
;     return nil
;   INTEGERP predOk and predOk ~= n =>
;     sayKeyedMsg("S2IX0006",[n,m])
;     return nil
;
;   --Check general term for references to just the k previous values
;   diffCell := compiledLookupCheck("-", '($ $ $), integer)
;   --Check general term for references to just the k previous values
;   sharpPosition := PARSE_-INTEGER SUBSTRING(sharpArg,1,nil)
;   al:= mkDiffAssoc(op, generalTerm, k, sharpPosition, sharpArg,
;                    diffCell, minivectorName, integer, bf_vec)
;   null al => false
;   '$failed in al => false
;   body:= generalTerm
;   for [a,:b] in al repeat
;     body:= substitute(b,a,body)
;   result:= [body,sharpArg,n-1,:NREVERSE [LASSOC(i,initList) or
;       systemErrorHere('"NRTisRecurrenceRelation")
;         for i in minIndex..(n-1)]]

(DEFUN |NRTisRecurrenceRelation| (|op| |body| |minivectorName|)
  (PROG (|pcl| |mess| |integer| |iequalSlot| |lt_slot| |le_slot| |gt_slot|
         |ge_slot| |bf| |bf_vec| |notpSlot| |p| |ISTMP#1| |c| |sharpVar|
         |ISTMP#2| |n1| |ISTMP#3| |ISTMP#4| |ISTMP#5| |dom| |ISTMP#6| |slot|
         |initList| |sharpList| |n| |miscList| |generalPred| |generalTerm|
         |sharpArg| |specialValues| |minIndex| |k| |m1| |m2| |m| |ISTMP#7|
         |dom1| |ISTMP#8| |slot1| |ISTMP#9| |ISTMP#10| |ISTMP#11| |dom2|
         |ISTMP#12| |slot2| |predOk| |diffCell| |sharpPosition| |al| |a| |b|
         |result|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |body|) (EQ (CAR |body|) 'COND)
             (PROGN (SETQ |pcl| (CDR |body|)) #1='T)))
       NIL)
      (#1#
       (PROGN
        (SETQ |pcl|
                ((LAMBDA (|bfVar#18| |bfVar#17| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#17|)
                          (PROGN (SETQ |x| (CAR |bfVar#17|)) NIL))
                      (RETURN (NREVERSE |bfVar#18|)))
                     (#1#
                      (AND
                       (NULL
                        (AND (CONSP |x|) (EQUAL (CAR |x|) ''T)
                             (PROGN (SETQ |mess| (CDR |x|)) #1#)
                             (OR (CONTAINED '|throwMessage| |mess|)
                                 (CONTAINED '|throwKeyedMsg| |mess|))))
                       (SETQ |bfVar#18| (CONS |x| |bfVar#18|)))))
                    (SETQ |bfVar#17| (CDR |bfVar#17|))))
                 NIL |pcl| NIL))
        (SETQ |integer| (EVAL |$Integer|))
        (SETQ |iequalSlot|
                (|compiledLookupCheck| '= '((|Boolean|) $ $) |integer|))
        (SETQ |lt_slot|
                (|compiledLookupCheck| '< '((|Boolean|) $ $) |integer|))
        (SETQ |le_slot|
                (|compiledLookupCheck| '<= '((|Boolean|) $ $) |integer|))
        (SETQ |gt_slot|
                (|compiledLookupCheck| '> '((|Boolean|) $ $) |integer|))
        (SETQ |ge_slot|
                (|compiledLookupCheck| '>= '((|Boolean|) $ $) |integer|))
        (SETQ |bf| '(|Boolean|))
        (SETQ |bf_vec| (EVAL |bf|))
        (SETQ |notpSlot|
                (|compiledLookupCheck| '|not| '((|Boolean|) (|Boolean|))
                 |bf_vec|))
        ((LAMBDA (|bfVar#20| |bfVar#19|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#20|)
                  (PROGN (SETQ |bfVar#19| (CAR |bfVar#20|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#19|)
                   (PROGN
                    (SETQ |p| (CAR |bfVar#19|))
                    (SETQ |ISTMP#1| (CDR |bfVar#19|))
                    (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                         (PROGN (SETQ |c| (CAR |ISTMP#1|)) #1#)))
                   (COND
                    ((AND (CONSP |p|) (EQ (CAR |p|) 'SPADCALL)
                          (PROGN
                           (SETQ |ISTMP#1| (CDR |p|))
                           (AND (CONSP |ISTMP#1|)
                                (PROGN
                                 (SETQ |sharpVar| (CAR |ISTMP#1|))
                                 (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                 (AND (CONSP |ISTMP#2|)
                                      (PROGN
                                       (SETQ |n1| (CAR |ISTMP#2|))
                                       (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                       (AND (CONSP |ISTMP#3|)
                                            (EQ (CDR |ISTMP#3|) NIL)
                                            (PROGN
                                             (SETQ |ISTMP#4| (CAR |ISTMP#3|))
                                             (AND (CONSP |ISTMP#4|)
                                                  (EQ (CAR |ISTMP#4|) 'ELT)
                                                  (PROGN
                                                   (SETQ |ISTMP#5|
                                                           (CDR |ISTMP#4|))
                                                   (AND (CONSP |ISTMP#5|)
                                                        (PROGN
                                                         (SETQ |dom|
                                                                 (CAR
                                                                  |ISTMP#5|))
                                                         (SETQ |ISTMP#6|
                                                                 (CDR
                                                                  |ISTMP#5|))
                                                         (AND (CONSP |ISTMP#6|)
                                                              (EQ
                                                               (CDR |ISTMP#6|)
                                                               NIL)
                                                              (PROGN
                                                               (SETQ |slot|
                                                                       (CAR
                                                                        |ISTMP#6|))
                                                               #1#)))))))))))))
                          (|is_op_slot| |iequalSlot| |dom| |slot|
                           |minivectorName| |integer| |bf_vec|))
                     (PROGN
                      (SETQ |initList| (CONS (CONS |n1| |c|) |initList|))
                      (SETQ |sharpList| (|insert| |sharpVar| |sharpList|))
                      (SETQ |n| |n1|)))
                    (#1#
                     (SETQ |miscList| (CONS (LIST |p| |c|) |miscList|)))))))
            (SETQ |bfVar#20| (CDR |bfVar#20|))))
         |pcl| NIL)
        (COND
         ((OR
           (NOT
            (AND (CONSP |miscList|) (EQ (CDR |miscList|) NIL)
                 (PROGN
                  (SETQ |ISTMP#1| (CAR |miscList|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |generalPred| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN
                              (SETQ |generalTerm| (CAR |ISTMP#2|))
                              #1#)))))))
           (NOT
            (AND (CONSP |sharpList|) (EQ (CDR |sharpList|) NIL)
                 (PROGN (SETQ |sharpArg| (CAR |sharpList|)) #1#))))
          (RETURN NIL))
         ((NULL |initList|) NIL)
         (#1#
          (PROGN
           (SETQ |specialValues| (MSORT (ASSOCLEFT |initList|)))
           (COND
            (((LAMBDA (|bfVar#22| |bfVar#21| |n|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#21|)
                       (PROGN (SETQ |n| (CAR |bfVar#21|)) NIL))
                   (RETURN |bfVar#22|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#22| (NULL (INTEGERP |n|)))
                    (COND (|bfVar#22| (RETURN |bfVar#22|))))))
                 (SETQ |bfVar#21| (CDR |bfVar#21|))))
              NIL |specialValues| NIL)
             NIL)
            (#1#
             (PROGN
              (SETQ |minIndex|
                      ((LAMBDA (|bfVar#23| |bfVar#25| |bfVar#24|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#25|)
                                (PROGN (SETQ |bfVar#24| (CAR |bfVar#25|)) NIL))
                            (RETURN |bfVar#23|))
                           (#1# (SETQ |bfVar#23| (MIN |bfVar#23| |bfVar#24|))))
                          (SETQ |bfVar#25| (CDR |bfVar#25|))))
                       999999 |specialValues| NIL))
              (COND
               ((NULL
                 ((LAMBDA (|bfVar#28| |bfVar#26| |i| |bfVar#27| |x|)
                    (LOOP
                     (COND
                      ((OR (> |i| |bfVar#26|) (ATOM |bfVar#27|)
                           (PROGN (SETQ |x| (CAR |bfVar#27|)) NIL))
                       (RETURN |bfVar#28|))
                      (#1#
                       (PROGN
                        (SETQ |bfVar#28| (EQUAL |i| |x|))
                        (COND ((NOT |bfVar#28|) (RETURN NIL))))))
                     (SETQ |i| (+ |i| 1))
                     (SETQ |bfVar#27| (CDR |bfVar#27|))))
                  T (- (+ |minIndex| |n|) 1) |minIndex| |specialValues| NIL))
                (PROGN
                 (|sayKeyedMsg| 'S2IX0005
                  (LIST
                   ((LAMBDA (|bfVar#30| |bfVar#29| |sv|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#29|)
                             (PROGN (SETQ |sv| (CAR |bfVar#29|)) NIL))
                         (RETURN |bfVar#30|))
                        (#1#
                         (SETQ |bfVar#30|
                                 (APPEND |bfVar#30| (LIST " " |sv|)))))
                       (SETQ |bfVar#29| (CDR |bfVar#29|))))
                    NIL |specialValues| NIL)))
                 (RETURN NIL)))
               (#1#
                (PROGN
                 (SETQ |k| (LENGTH |specialValues|))
                 (SETQ |n| (+ |k| |minIndex|))
                 (SETQ |predOk|
                         (COND ((EQUAL |generalPred| ''T) T)
                               ((AND (CONSP |generalPred|)
                                     (EQ (CAR |generalPred|) 'SPADCALL)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |generalPred|))
                                      (AND (CONSP |ISTMP#1|)
                                           (PROGN
                                            (SETQ |m1| (CAR |ISTMP#1|))
                                            (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                            (AND (CONSP |ISTMP#2|)
                                                 (PROGN
                                                  (SETQ |m2| (CAR |ISTMP#2|))
                                                  (SETQ |ISTMP#3|
                                                          (CDR |ISTMP#2|))
                                                  (AND (CONSP |ISTMP#3|)
                                                       (EQ (CDR |ISTMP#3|) NIL)
                                                       (PROGN
                                                        (SETQ |ISTMP#4|
                                                                (CAR
                                                                 |ISTMP#3|))
                                                        (AND (CONSP |ISTMP#4|)
                                                             (EQ
                                                              (CAR |ISTMP#4|)
                                                              'ELT)
                                                             (PROGN
                                                              (SETQ |ISTMP#5|
                                                                      (CDR
                                                                       |ISTMP#4|))
                                                              (AND
                                                               (CONSP
                                                                |ISTMP#5|)
                                                               (PROGN
                                                                (SETQ |dom|
                                                                        (CAR
                                                                         |ISTMP#5|))
                                                                (SETQ |ISTMP#6|
                                                                        (CDR
                                                                         |ISTMP#5|))
                                                                (AND
                                                                 (CONSP
                                                                  |ISTMP#6|)
                                                                 (EQ
                                                                  (CDR
                                                                   |ISTMP#6|)
                                                                  NIL)
                                                                 (PROGN
                                                                  (SETQ |slot|
                                                                          (CAR
                                                                           |ISTMP#6|))
                                                                  #1#))))))))))))))
                                (COND
                                 ((AND (EQUAL |m2| |sharpArg|)
                                       (|is_op_slot| |lt_slot| |dom| |slot|
                                        |minivectorName| |integer| |bf_vec|))
                                  (+ |m1| 1))
                                 ((AND (EQUAL |m2| |sharpArg|)
                                       (|is_op_slot| |le_slot| |dom| |slot|
                                        |minivectorName| |integer| |bf_vec|))
                                  |m1|)
                                 ((AND (EQUAL |m1| |sharpArg|)
                                       (|is_op_slot| |gt_slot| |dom| |slot|
                                        |minivectorName| |integer| |bf_vec|))
                                  (+ |m2| 1))
                                 ((AND (EQUAL |m1| |sharpArg|)
                                       (|is_op_slot| |ge_slot| |dom| |slot|
                                        |minivectorName| |integer| |bf_vec|))
                                  |m2|)))
                               ((AND (CONSP |generalPred|)
                                     (EQ (CAR |generalPred|) 'SPADCALL)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |generalPred|))
                                      (AND (CONSP |ISTMP#1|)
                                           (PROGN
                                            (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                            (AND (CONSP |ISTMP#2|)
                                                 (EQ (CAR |ISTMP#2|) 'SPADCALL)
                                                 (PROGN
                                                  (SETQ |ISTMP#3|
                                                          (CDR |ISTMP#2|))
                                                  (AND (CONSP |ISTMP#3|)
                                                       (EQUAL (CAR |ISTMP#3|)
                                                              |sharpArg|)
                                                       (PROGN
                                                        (SETQ |ISTMP#4|
                                                                (CDR
                                                                 |ISTMP#3|))
                                                        (AND (CONSP |ISTMP#4|)
                                                             (PROGN
                                                              (SETQ |m|
                                                                      (CAR
                                                                       |ISTMP#4|))
                                                              (SETQ |ISTMP#5|
                                                                      (CDR
                                                                       |ISTMP#4|))
                                                              (AND
                                                               (CONSP
                                                                |ISTMP#5|)
                                                               (EQ
                                                                (CDR |ISTMP#5|)
                                                                NIL)
                                                               (PROGN
                                                                (SETQ |ISTMP#6|
                                                                        (CAR
                                                                         |ISTMP#5|))
                                                                (AND
                                                                 (CONSP
                                                                  |ISTMP#6|)
                                                                 (EQ
                                                                  (CAR
                                                                   |ISTMP#6|)
                                                                  'ELT)
                                                                 (PROGN
                                                                  (SETQ |ISTMP#7|
                                                                          (CDR
                                                                           |ISTMP#6|))
                                                                  (AND
                                                                   (CONSP
                                                                    |ISTMP#7|)
                                                                   (PROGN
                                                                    (SETQ |dom1|
                                                                            (CAR
                                                                             |ISTMP#7|))
                                                                    (SETQ |ISTMP#8|
                                                                            (CDR
                                                                             |ISTMP#7|))
                                                                    (AND
                                                                     (CONSP
                                                                      |ISTMP#8|)
                                                                     (EQ
                                                                      (CDR
                                                                       |ISTMP#8|)
                                                                      NIL)
                                                                     (PROGN
                                                                      (SETQ |slot1|
                                                                              (CAR
                                                                               |ISTMP#8|))
                                                                      #1#)))))))))))))))
                                           (PROGN
                                            (SETQ |ISTMP#9| (CDR |ISTMP#1|))
                                            (AND (CONSP |ISTMP#9|)
                                                 (EQ (CDR |ISTMP#9|) NIL)
                                                 (PROGN
                                                  (SETQ |ISTMP#10|
                                                          (CAR |ISTMP#9|))
                                                  (AND (CONSP |ISTMP#10|)
                                                       (EQ (CAR |ISTMP#10|)
                                                           'ELT)
                                                       (PROGN
                                                        (SETQ |ISTMP#11|
                                                                (CDR
                                                                 |ISTMP#10|))
                                                        (AND (CONSP |ISTMP#11|)
                                                             (PROGN
                                                              (SETQ |dom2|
                                                                      (CAR
                                                                       |ISTMP#11|))
                                                              (SETQ |ISTMP#12|
                                                                      (CDR
                                                                       |ISTMP#11|))
                                                              (AND
                                                               (CONSP
                                                                |ISTMP#12|)
                                                               (EQ
                                                                (CDR
                                                                 |ISTMP#12|)
                                                                NIL)
                                                               (PROGN
                                                                (SETQ |slot2|
                                                                        (CAR
                                                                         |ISTMP#12|))
                                                                #1#)))))))))))
                                     (|is_op_slot| |notSlot| |dom2| |slot2|
                                      |minivectorName| |integer| |bf_vec|)
                                     (|is_op_slot| |lt_slot| |dom1| |slot1|
                                      |minivectorName| |integer| |bf_vec|))
                                |m|)
                               ((AND (CONSP |generalPred|)
                                     (EQ (CAR |generalPred|) 'NOT)
                                     (PROGN
                                      (SETQ |ISTMP#1| (CDR |generalPred|))
                                      (AND (CONSP |ISTMP#1|)
                                           (EQ (CDR |ISTMP#1|) NIL)
                                           (PROGN
                                            (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                            (AND (CONSP |ISTMP#2|)
                                                 (EQ (CAR |ISTMP#2|) 'SPADCALL)
                                                 (PROGN
                                                  (SETQ |ISTMP#3|
                                                          (CDR |ISTMP#2|))
                                                  (AND (CONSP |ISTMP#3|)
                                                       (EQUAL (CAR |ISTMP#3|)
                                                              |sharpArg|)
                                                       (PROGN
                                                        (SETQ |ISTMP#4|
                                                                (CDR
                                                                 |ISTMP#3|))
                                                        (AND (CONSP |ISTMP#4|)
                                                             (PROGN
                                                              (SETQ |m|
                                                                      (CAR
                                                                       |ISTMP#4|))
                                                              (SETQ |ISTMP#5|
                                                                      (CDR
                                                                       |ISTMP#4|))
                                                              (AND
                                                               (CONSP
                                                                |ISTMP#5|)
                                                               (EQ
                                                                (CDR |ISTMP#5|)
                                                                NIL)
                                                               (PROGN
                                                                (SETQ |ISTMP#6|
                                                                        (CAR
                                                                         |ISTMP#5|))
                                                                (AND
                                                                 (CONSP
                                                                  |ISTMP#6|)
                                                                 (EQ
                                                                  (CAR
                                                                   |ISTMP#6|)
                                                                  'ELT)
                                                                 (PROGN
                                                                  (SETQ |ISTMP#7|
                                                                          (CDR
                                                                           |ISTMP#6|))
                                                                  (AND
                                                                   (CONSP
                                                                    |ISTMP#7|)
                                                                   (PROGN
                                                                    (SETQ |dom|
                                                                            (CAR
                                                                             |ISTMP#7|))
                                                                    (SETQ |ISTMP#8|
                                                                            (CDR
                                                                             |ISTMP#7|))
                                                                    (AND
                                                                     (CONSP
                                                                      |ISTMP#8|)
                                                                     (EQ
                                                                      (CDR
                                                                       |ISTMP#8|)
                                                                      NIL)
                                                                     (PROGN
                                                                      (SETQ |slot|
                                                                              (CAR
                                                                               |ISTMP#8|))
                                                                      #1#)))))))))))))))))
                                     (|is_op_slot| |lt_slot| |dom| |slot|
                                      |minivectorName| |integer| |bf_vec|))
                                |m|)
                               (#1# (RETURN NIL))))
                 (COND
                  ((AND (INTEGERP |predOk|) (NOT (EQUAL |predOk| |n|)))
                   (PROGN
                    (|sayKeyedMsg| 'S2IX0006 (LIST |n| |m|))
                    (RETURN NIL)))
                  (#1#
                   (PROGN
                    (SETQ |diffCell|
                            (|compiledLookupCheck| '- '($ $ $) |integer|))
                    (SETQ |sharpPosition|
                            (PARSE-INTEGER (SUBSTRING |sharpArg| 1 NIL)))
                    (SETQ |al|
                            (|mkDiffAssoc| |op| |generalTerm| |k|
                             |sharpPosition| |sharpArg| |diffCell|
                             |minivectorName| |integer| |bf_vec|))
                    (COND ((NULL |al|) NIL) ((|member| '|$failed| |al|) NIL)
                          (#1#
                           (PROGN
                            (SETQ |body| |generalTerm|)
                            ((LAMBDA (|bfVar#32| |bfVar#31|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#32|)
                                      (PROGN
                                       (SETQ |bfVar#31| (CAR |bfVar#32|))
                                       NIL))
                                  (RETURN NIL))
                                 (#1#
                                  (AND (CONSP |bfVar#31|)
                                       (PROGN
                                        (SETQ |a| (CAR |bfVar#31|))
                                        (SETQ |b| (CDR |bfVar#31|))
                                        #1#)
                                       (SETQ |body|
                                               (|substitute| |b| |a|
                                                |body|)))))
                                (SETQ |bfVar#32| (CDR |bfVar#32|))))
                             |al| NIL)
                            (SETQ |result|
                                    (CONS |body|
                                          (CONS |sharpArg|
                                                (CONS (- |n| 1)
                                                      (NREVERSE
                                                       ((LAMBDA
                                                            (|bfVar#34|
                                                             |bfVar#33| |i|)
                                                          (LOOP
                                                           (COND
                                                            ((> |i| |bfVar#33|)
                                                             (RETURN
                                                              (NREVERSE
                                                               |bfVar#34|)))
                                                            (#1#
                                                             (SETQ |bfVar#34|
                                                                     (CONS
                                                                      (OR
                                                                       (LASSOC
                                                                        |i|
                                                                        |initList|)
                                                                       (|systemErrorHere|
                                                                        "NRTisRecurrenceRelation"))
                                                                      |bfVar#34|))))
                                                           (SETQ |i|
                                                                   (+ |i| 1))))
                                                        NIL (- |n| 1)
                                                        |minIndex|)))))))))))))))))))))))))))

; mkDiffAssoc(op, body, k, sharpPosition, sharpArg, diffCell,
;             vecname, int_vec, bool_vec) ==
;   -- returns alist which should not have any entries = $failed
;   -- form substitution list of the form:
;   -- ( ((f (,DIFFERENCE #1 1)) . #2) ((f (,DIFFERENCE #1 2)) . #3) ...)
;   --   but also checking that all difference values lie in 1..k
;   atom body => nil
;   body is ['COND,:pl] =>
;     "union"/[mkDiffAssoc(op, c, k, sharpPosition, sharpArg, diffCell,
;                          vecname, int_vec, bool_vec) for [p, c] in pl]
;   body is [fn,:argl] =>
;     (fn = op) and argl.(sharpPosition-1) is
;       ['SPADCALL, =sharpArg, n, ['ELT, dom, slot]] and
;         is_op_slot(diffCell, dom, slot, vecname, int_vec, bool_vec) =>
;           NUMBERP n and n > 0 and n <= k =>
;               [[body, :$TriangleVariableList.n]]
;           ['$failed]
;     "union"/[mkDiffAssoc(op, x, k, sharpPosition, sharpArg, diffCell,
;                          vecname, int_vec, bool_vec) for x in argl]
;   systemErrorHere '"mkDiffAssoc"

(DEFUN |mkDiffAssoc|
       (|op| |body| |k| |sharpPosition| |sharpArg| |diffCell| |vecname|
        |int_vec| |bool_vec|)
  (PROG (|pl| |p| |ISTMP#1| |c| |fn| |argl| |ISTMP#2| |ISTMP#3| |n| |ISTMP#4|
         |ISTMP#5| |ISTMP#6| |dom| |ISTMP#7| |slot|)
    (RETURN
     (COND ((ATOM |body|) NIL)
           ((AND (CONSP |body|) (EQ (CAR |body|) 'COND)
                 (PROGN (SETQ |pl| (CDR |body|)) #1='T))
            ((LAMBDA (|bfVar#37| |bfVar#36| |bfVar#35|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#36|)
                      (PROGN (SETQ |bfVar#35| (CAR |bfVar#36|)) NIL))
                  (RETURN |bfVar#37|))
                 (#1#
                  (AND (CONSP |bfVar#35|)
                       (PROGN
                        (SETQ |p| (CAR |bfVar#35|))
                        (SETQ |ISTMP#1| (CDR |bfVar#35|))
                        (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                             (PROGN (SETQ |c| (CAR |ISTMP#1|)) #1#)))
                       (SETQ |bfVar#37|
                               (|union| |bfVar#37|
                                (|mkDiffAssoc| |op| |c| |k| |sharpPosition|
                                 |sharpArg| |diffCell| |vecname| |int_vec|
                                 |bool_vec|))))))
                (SETQ |bfVar#36| (CDR |bfVar#36|))))
             NIL |pl| NIL))
           ((AND (CONSP |body|)
                 (PROGN
                  (SETQ |fn| (CAR |body|))
                  (SETQ |argl| (CDR |body|))
                  #1#))
            (COND
             ((AND (EQUAL |fn| |op|)
                   (PROGN
                    (SETQ |ISTMP#1| (ELT |argl| (- |sharpPosition| 1)))
                    (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'SPADCALL)
                         (PROGN
                          (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                          (AND (CONSP |ISTMP#2|)
                               (EQUAL (CAR |ISTMP#2|) |sharpArg|)
                               (PROGN
                                (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                (AND (CONSP |ISTMP#3|)
                                     (PROGN
                                      (SETQ |n| (CAR |ISTMP#3|))
                                      (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                      (AND (CONSP |ISTMP#4|)
                                           (EQ (CDR |ISTMP#4|) NIL)
                                           (PROGN
                                            (SETQ |ISTMP#5| (CAR |ISTMP#4|))
                                            (AND (CONSP |ISTMP#5|)
                                                 (EQ (CAR |ISTMP#5|) 'ELT)
                                                 (PROGN
                                                  (SETQ |ISTMP#6|
                                                          (CDR |ISTMP#5|))
                                                  (AND (CONSP |ISTMP#6|)
                                                       (PROGN
                                                        (SETQ |dom|
                                                                (CAR
                                                                 |ISTMP#6|))
                                                        (SETQ |ISTMP#7|
                                                                (CDR
                                                                 |ISTMP#6|))
                                                        (AND (CONSP |ISTMP#7|)
                                                             (EQ
                                                              (CDR |ISTMP#7|)
                                                              NIL)
                                                             (PROGN
                                                              (SETQ |slot|
                                                                      (CAR
                                                                       |ISTMP#7|))
                                                              #1#)))))))))))))))
                   (|is_op_slot| |diffCell| |dom| |slot| |vecname| |int_vec|
                    |bool_vec|))
              (COND
               ((AND (NUMBERP |n|) (< 0 |n|) (NOT (< |k| |n|)))
                (LIST (CONS |body| (ELT |$TriangleVariableList| |n|))))
               (#1# (LIST '|$failed|))))
             (#1#
              ((LAMBDA (|bfVar#39| |bfVar#38| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#38|)
                        (PROGN (SETQ |x| (CAR |bfVar#38|)) NIL))
                    (RETURN |bfVar#39|))
                   (#1#
                    (SETQ |bfVar#39|
                            (|union| |bfVar#39|
                             (|mkDiffAssoc| |op| |x| |k| |sharpPosition|
                              |sharpArg| |diffCell| |vecname| |int_vec|
                              |bool_vec|)))))
                  (SETQ |bfVar#38| (CDR |bfVar#38|))))
               NIL |argl| NIL))))
           (#1# (|systemErrorHere| "mkDiffAssoc"))))))

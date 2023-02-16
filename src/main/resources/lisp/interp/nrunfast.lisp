
; )package "BOOT"

(IN-PACKAGE "BOOT")

; initNewWorld() ==
;   $monitorNewWorld := false

(DEFUN |initNewWorld| () (PROG () (RETURN (SETQ |$monitorNewWorld| NIL))))

; isNewWorldDomain domain == INTEGERP domain.3    --see HasCategory/Attribute

(DEFUN |isNewWorldDomain| (|domain|)
  (PROG () (RETURN (INTEGERP (ELT |domain| 3)))))

; getDomainByteVector dom == CDDR dom.4

(DEFUN |getDomainByteVector| (|dom|) (PROG () (RETURN (CDDR (ELT |dom| 4)))))

; getDomainView(domain,catform) == domain

(DEFUN |getDomainView| (|domain| |catform|) (PROG () (RETURN |domain|)))

; makeSpadConstant [fn, dollar, slot] ==
;     val := FUNCALL(fn, dollar)
;     u := dollar.slot
;     RPLACA(u, function IDENTITY)
;     RPLACD(u, val)
;     val

(DEFUN |makeSpadConstant| (|bfVar#1|)
  (PROG (|fn| |dollar| |slot| |val| |u|)
    (RETURN
     (PROGN
      (SETQ |fn| (CAR |bfVar#1|))
      (SETQ |dollar| (CADR . #1=(|bfVar#1|)))
      (SETQ |slot| (CADDR . #1#))
      (SETQ |val| (FUNCALL |fn| |dollar|))
      (SETQ |u| (ELT |dollar| |slot|))
      (RPLACA |u| #'IDENTITY)
      (RPLACD |u| |val|)
      |val|))))

; newGoGet(:l) ==
;   [:arglist,env] := l
;   slot := replaceGoGetSlot env
;   APPLY(first slot,[:arglist,rest slot])  --SPADCALL it!

(DEFUN |newGoGet| (&REST |l|)
  (PROG (|LETTMP#1| |env| |arglist| |slot|)
    (RETURN
     (PROGN
      (SETQ |LETTMP#1| (REVERSE |l|))
      (SETQ |env| (CAR |LETTMP#1|))
      (SETQ |arglist| (NREVERSE (CDR |LETTMP#1|)))
      (SETQ |slot| (|replaceGoGetSlot| |env|))
      (APPLY (CAR |slot|) (APPEND |arglist| (CONS (CDR |slot|) NIL)))))))

; forceLazySlot(f) ==
;     not(EQ(first f, function newGoGet)) => f
;     replaceGoGetSlot(rest f)

(DEFUN |forceLazySlot| (|f|)
  (PROG ()
    (RETURN
     (COND ((NULL (EQ (CAR |f|) #'|newGoGet|)) |f|)
           ('T (|replaceGoGetSlot| (CDR |f|)))))))

; newLookupInTable(op,sig,dollar,[domain,opvec],flag) ==
;   dollar = nil => systemError()
;   $lookupDefaults = true =>
;       -- lookup first in my cats
;       newLookupInCategories(op, sig, domain, dollar, true)
;         or newLookupInAddChain(op, sig, domain, dollar)
;   --fast path when called from newGoGet
;   success := false
;   if $monitorNewWorld then
;     sayLooking(concat('"---->",form2String devaluate domain,
;       '"----> searching op table for:","%l","  "),op,sig,dollar)
;   someMatch := false
;   numvec := getDomainByteVector domain
;   predvec := domain.3
;   max := MAXINDEX opvec
;   k := getOpCode(op,opvec,max) or return
;     flag => newLookupInAddChain(op,sig,domain,dollar)
;     nil
;   maxIndex := MAXINDEX numvec
;   start := ELT(opvec,k)
;   finish :=
;     greater_SI(max, k) => opvec.(add_SI(k, 2))
;     maxIndex
;   if greater_SI(finish, maxIndex) then systemError '"limit too large"
;   numArgs := sub_SI(#sig, 1)
;   success := nil
;   $isDefaultingPackage: local :=
;     -- use special defaulting handler when dollar non-trivial
;     dollar ~= domain and isDefaultPackageForm? devaluate domain
;   while finish > start repeat
;     PROGN
;       i := start
;       numArgs ~= (numTableArgs :=numvec.i) => nil
;       predIndex := numvec.(i := inc_SI i)
;       predIndex ~= 0 and null testBitVector(predvec, predIndex) => nil
;       loc := newCompareSig(sig, numvec, (i := inc_SI i), dollar, domain)
;       null loc => nil  --signifies no match
;       loc = 1 => (someMatch := true)
;       loc = 0 =>
;         start := add_SI(start, add_SI(numTableArgs, 4))
;         i := start + 2
;         someMatch := true --mark so that if subsumption fails, look for original
;         subsumptionSig :=
;           [newExpandTypeSlot(numvec.(add_SI(i, j)),
;             dollar,domain) for j in 0..numTableArgs]
;         if $monitorNewWorld then
;           sayBrightly [formatOpSignature(op,sig),'"--?-->",
;             formatOpSignature(op,subsumptionSig)]
;         nil
;       slot := domain.loc
;       null atom slot =>
;         EQ(QCAR slot,FUNCTION newGoGet) => someMatch:=true
;                    --treat as if operation were not there
;         --if EQ(QCAR slot, function newGoGet) then
;         --  UNWIND_-PROTECT --break infinite recursion
;         --    ((SETELT(domain,loc,'skip); slot := replaceGoGetSlot QCDR slot),
;         --      if domain.loc = 'skip then domain.loc := slot)
;         return (success := slot)
;       slot = 'skip =>       --recursive call from above 'replaceGoGetSlot
;         return (success := newLookupInAddChain(op,sig,domain,dollar))
;       systemError '"unexpected format"
;     start := add_SI(start, add_SI(numTableArgs, 4))
;   success ~= 'failed and success =>
;     if $monitorNewWorld then
;         if PAIRP success then
;             sayLooking1(concat('"<----", form2String(first success)),
;                         rest success)
;         else sayLooking1('"<----XXX---", success)
;     success
;   subsumptionSig and (u:= basicLookup(op,subsumptionSig,domain,dollar)) => u
;   flag or someMatch => newLookupInAddChain(op,sig,domain,dollar)
;   nil

(DEFUN |newLookupInTable| (|op| |sig| |dollar| |bfVar#3| |flag|)
  (PROG (|$isDefaultingPackage| |u| |slot| |subsumptionSig| |loc| |predIndex|
         |numTableArgs| |i| |numArgs| |finish| |start| |maxIndex| |k| |max|
         |predvec| |numvec| |someMatch| |success| |opvec| |domain|)
    (DECLARE (SPECIAL |$isDefaultingPackage|))
    (RETURN
     (PROGN
      (SETQ |domain| (CAR |bfVar#3|))
      (SETQ |opvec| (CADR |bfVar#3|))
      (COND ((NULL |dollar|) (|systemError|))
            ((EQUAL |$lookupDefaults| T)
             (OR (|newLookupInCategories| |op| |sig| |domain| |dollar| T)
                 (|newLookupInAddChain| |op| |sig| |domain| |dollar|)))
            (#1='T
             (PROGN
              (SETQ |success| NIL)
              (COND
               (|$monitorNewWorld|
                (|sayLooking|
                 (|concat| "---->" (|form2String| (|devaluate| |domain|))
                  "----> searching op table for:" '|%l| '|  |)
                 |op| |sig| |dollar|)))
              (SETQ |someMatch| NIL)
              (SETQ |numvec| (|getDomainByteVector| |domain|))
              (SETQ |predvec| (ELT |domain| 3))
              (SETQ |max| (MAXINDEX |opvec|))
              (SETQ |k|
                      (OR (|getOpCode| |op| |opvec| |max|)
                          (RETURN
                           (COND
                            (|flag|
                             (|newLookupInAddChain| |op| |sig| |domain|
                              |dollar|))
                            (#1# NIL)))))
              (SETQ |maxIndex| (MAXINDEX |numvec|))
              (SETQ |start| (ELT |opvec| |k|))
              (SETQ |finish|
                      (COND
                       ((|greater_SI| |max| |k|)
                        (ELT |opvec| (|add_SI| |k| 2)))
                       (#1# |maxIndex|)))
              (COND
               ((|greater_SI| |finish| |maxIndex|)
                (|systemError| "limit too large")))
              (SETQ |numArgs| (|sub_SI| (LENGTH |sig|) 1))
              (SETQ |success| NIL)
              (SETQ |$isDefaultingPackage|
                      (AND (NOT (EQUAL |dollar| |domain|))
                           (|isDefaultPackageForm?| (|devaluate| |domain|))))
              ((LAMBDA ()
                 (LOOP
                  (COND ((NOT (< |start| |finish|)) (RETURN NIL))
                        (#1#
                         (PROGN
                          (PROGN
                           (SETQ |i| |start|)
                           (COND
                            ((NOT
                              (EQUAL |numArgs|
                                     (SETQ |numTableArgs| (ELT |numvec| |i|))))
                             NIL)
                            (#1#
                             (PROGN
                              (SETQ |predIndex|
                                      (ELT |numvec| (SETQ |i| (|inc_SI| |i|))))
                              (COND
                               ((AND (NOT (EQL |predIndex| 0))
                                     (NULL
                                      (|testBitVector| |predvec| |predIndex|)))
                                NIL)
                               (#1#
                                (PROGN
                                 (SETQ |loc|
                                         (|newCompareSig| |sig| |numvec|
                                          (SETQ |i| (|inc_SI| |i|)) |dollar|
                                          |domain|))
                                 (COND ((NULL |loc|) NIL)
                                       ((EQL |loc| 1) (SETQ |someMatch| T))
                                       ((EQL |loc| 0)
                                        (PROGN
                                         (SETQ |start|
                                                 (|add_SI| |start|
                                                  (|add_SI| |numTableArgs| 4)))
                                         (SETQ |i| (+ |start| 2))
                                         (SETQ |someMatch| T)
                                         (SETQ |subsumptionSig|
                                                 ((LAMBDA (|bfVar#2| |j|)
                                                    (LOOP
                                                     (COND
                                                      ((> |j| |numTableArgs|)
                                                       (RETURN
                                                        (NREVERSE |bfVar#2|)))
                                                      (#1#
                                                       (SETQ |bfVar#2|
                                                               (CONS
                                                                (|newExpandTypeSlot|
                                                                 (ELT |numvec|
                                                                      (|add_SI|
                                                                       |i|
                                                                       |j|))
                                                                 |dollar|
                                                                 |domain|)
                                                                |bfVar#2|))))
                                                     (SETQ |j| (+ |j| 1))))
                                                  NIL 0))
                                         (COND
                                          (|$monitorNewWorld|
                                           (|sayBrightly|
                                            (LIST
                                             (|formatOpSignature| |op| |sig|)
                                             "--?-->"
                                             (|formatOpSignature| |op|
                                              |subsumptionSig|)))))
                                         NIL))
                                       (#1#
                                        (PROGN
                                         (SETQ |slot| (ELT |domain| |loc|))
                                         (COND
                                          ((NULL (ATOM |slot|))
                                           (COND
                                            ((EQ (QCAR |slot|) #'|newGoGet|)
                                             (SETQ |someMatch| T))
                                            (#1#
                                             (RETURN
                                              (SETQ |success| |slot|)))))
                                          ((EQ |slot| '|skip|)
                                           (RETURN
                                            (SETQ |success|
                                                    (|newLookupInAddChain| |op|
                                                     |sig| |domain|
                                                     |dollar|))))
                                          (#1#
                                           (|systemError|
                                            "unexpected format")))))))))))))
                          (SETQ |start|
                                  (|add_SI| |start|
                                   (|add_SI| |numTableArgs| 4)))))))))
              (COND
               ((AND (NOT (EQ |success| '|failed|)) |success|)
                (PROGN
                 (COND
                  (|$monitorNewWorld|
                   (COND
                    ((CONSP |success|)
                     (|sayLooking1|
                      (|concat| "<----" (|form2String| (CAR |success|)))
                      (CDR |success|)))
                    (#1# (|sayLooking1| "<----XXX---" |success|)))))
                 |success|))
               ((AND |subsumptionSig|
                     (SETQ |u|
                             (|basicLookup| |op| |subsumptionSig| |domain|
                              |dollar|)))
                |u|)
               ((OR |flag| |someMatch|)
                (|newLookupInAddChain| |op| |sig| |domain| |dollar|))
               (#1# NIL)))))))))

; AND_char := ELT('"&", 0)

(EVAL-WHEN (EVAL LOAD) (SETQ |AND_char| (ELT "&" 0)))

; isDefaultPackageForm? x == x is [op,:.]
;   and IDENTP op and (s := PNAME op).(MAXINDEX s) = AND_char

(DEFUN |isDefaultPackageForm?| (|x|)
  (PROG (|op| |s|)
    (RETURN
     (AND (CONSP |x|) (PROGN (SETQ |op| (CAR |x|)) 'T) (IDENTP |op|)
          (EQUAL (ELT (SETQ |s| (PNAME |op|)) (MAXINDEX |s|)) |AND_char|)))))

; newLookupInAddChain(op,sig,addFormDomain,dollar) ==
;   if $monitorNewWorld then sayLooking1('"looking up add-chain: ",addFormDomain)
;   addFunction:=newLookupInDomain(op,sig,addFormDomain,dollar,5)
;   addFunction =>
;     if $monitorNewWorld then
;       sayLooking1(concat('"<----add-chain function found for ",
;         form2String devaluate addFormDomain, '"<----"), rest addFunction)
;     addFunction
;   nil

(DEFUN |newLookupInAddChain| (|op| |sig| |addFormDomain| |dollar|)
  (PROG (|addFunction|)
    (RETURN
     (PROGN
      (COND
       (|$monitorNewWorld|
        (|sayLooking1| "looking up add-chain: " |addFormDomain|)))
      (SETQ |addFunction|
              (|newLookupInDomain| |op| |sig| |addFormDomain| |dollar| 5))
      (COND
       (|addFunction|
        (PROGN
         (COND
          (|$monitorNewWorld|
           (|sayLooking1|
            (|concat| "<----add-chain function found for "
             (|form2String| (|devaluate| |addFormDomain|)) "<----")
            (CDR |addFunction|))))
         |addFunction|))
       ('T NIL))))))

; newLookupInDomain(op,sig,addFormDomain,dollar,index) ==
;   addFormCell := addFormDomain.index =>
;     INTEGERP IFCAR addFormCell =>
;       or/[newLookupInDomain(op,sig,addFormDomain,dollar,i) for i in addFormCell]
;     if null VECP addFormCell then lazyDomainSet(addFormCell,addFormDomain,index)
;     lookupInDomainVector(op,sig,addFormDomain.index,dollar)
;   nil

(DEFUN |newLookupInDomain| (|op| |sig| |addFormDomain| |dollar| |index|)
  (PROG (|addFormCell|)
    (RETURN
     (COND
      ((SETQ |addFormCell| (ELT |addFormDomain| |index|))
       (COND
        ((INTEGERP (IFCAR |addFormCell|))
         ((LAMBDA (|bfVar#5| |bfVar#4| |i|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#4|) (PROGN (SETQ |i| (CAR |bfVar#4|)) NIL))
               (RETURN |bfVar#5|))
              (#1='T
               (PROGN
                (SETQ |bfVar#5|
                        (|newLookupInDomain| |op| |sig| |addFormDomain|
                         |dollar| |i|))
                (COND (|bfVar#5| (RETURN |bfVar#5|))))))
             (SETQ |bfVar#4| (CDR |bfVar#4|))))
          NIL |addFormCell| NIL))
        (#1#
         (PROGN
          (COND
           ((NULL (VECP |addFormCell|))
            (|lazyDomainSet| |addFormCell| |addFormDomain| |index|)))
          (|lookupInDomainVector| |op| |sig| (ELT |addFormDomain| |index|)
           |dollar|)))))
      (#1# NIL)))))

; newLookupInCategories(op, sig, dom, dollar, check_num) ==
;   slot4 := dom.4
;   catVec := CADR slot4
;   SIZE catVec = 0 => nil                      --early exit if no categories
;   INTEGERP IFCDR catVec.0 => BREAK()
;   $lookupDefaults : local := nil
;   if $monitorNewWorld = true then sayBrightly concat('"----->",
;     form2String devaluate dom,'"-----> searching default packages for ",op)
;   predvec := dom.3
;   packageVec := QCAR slot4
;   nsig := substitute(dom.0, dollar.0, sig)
;   for i in 0..MAXINDEX packageVec |
;        (entry := packageVec.i) and entry ~= 'T repeat
;     package :=
;       VECP entry =>
;          if $monitorNewWorld then
;            sayLooking1('"already instantiated cat package",entry)
;          entry
;       IDENTP entry =>
;         cat := catVec.i
;         packageForm := nil
;         if not GET(entry, 'LOADED) then loadLib entry
;         infovec := GET(entry, 'infovec)
;         success :=
;             opvec := infovec.1
;             max := MAXINDEX opvec
;             code := getOpCode(op,opvec,max)
;             null code => nil
;             byteVector := CDDDR infovec.3
;             endPos :=
;               code+2 > max => SIZE byteVector
;               opvec.(code+2)
;             check_num and not(nrunNumArgCheck(#(QCDR sig), byteVector,
;                                               opvec.code, endPos)) => nil
;             --numOfArgs := byteVector.(opvec.code)
;             --numOfArgs ~= #(QCDR sig) => nil
;             packageForm := [entry, '$, :rest cat]
;             package := evalSlotDomain(packageForm,dom)
;             packageVec.i := package
;             package
;         null success =>
;           if $monitorNewWorld = true then
;             sayBrightlyNT '"  not in: "
;             pp (packageForm and devaluate package or entry)
;           nil
;         if $monitorNewWorld then
;           sayLooking1('"candidate default package instantiated: ",success)
;         success
;       entry
;     null package => nil
;     if $monitorNewWorld then
;       sayLooking1('"Looking at instantiated package ",package)
;     res := basicLookup(op,sig,package,dollar) =>
;       if $monitorNewWorld = true then
;         sayBrightly '"candidate default package succeeds"
;       return res
;     if $monitorNewWorld = true then
;       sayBrightly '"candidate fails -- continuing to search categories"
;     nil

(DEFUN |newLookupInCategories| (|op| |sig| |dom| |dollar| |check_num|)
  (PROG (|$lookupDefaults| |res| |success| |package| |endPos| |byteVector|
         |code| |max| |opvec| |infovec| |packageForm| |cat| |entry| |nsig|
         |packageVec| |predvec| |catVec| |slot4|)
    (DECLARE (SPECIAL |$lookupDefaults|))
    (RETURN
     (PROGN
      (SETQ |slot4| (ELT |dom| 4))
      (SETQ |catVec| (CADR |slot4|))
      (COND ((EQL (SIZE |catVec|) 0) NIL)
            ((INTEGERP (IFCDR (ELT |catVec| 0))) (BREAK))
            (#1='T
             (PROGN
              (SETQ |$lookupDefaults| NIL)
              (COND
               ((EQUAL |$monitorNewWorld| T)
                (|sayBrightly|
                 (|concat| "----->" (|form2String| (|devaluate| |dom|))
                  "-----> searching default packages for " |op|))))
              (SETQ |predvec| (ELT |dom| 3))
              (SETQ |packageVec| (QCAR |slot4|))
              (SETQ |nsig| (|substitute| (ELT |dom| 0) (ELT |dollar| 0) |sig|))
              ((LAMBDA (|bfVar#6| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#6|) (RETURN NIL))
                        (#1#
                         (AND (SETQ |entry| (ELT |packageVec| |i|))
                              (NOT (EQ |entry| 'T))
                              (PROGN
                               (SETQ |package|
                                       (COND
                                        ((VECP |entry|)
                                         (PROGN
                                          (COND
                                           (|$monitorNewWorld|
                                            (|sayLooking1|
                                             "already instantiated cat package"
                                             |entry|)))
                                          |entry|))
                                        ((IDENTP |entry|)
                                         (PROGN
                                          (SETQ |cat| (ELT |catVec| |i|))
                                          (SETQ |packageForm| NIL)
                                          (COND
                                           ((NULL (GET |entry| 'LOADED))
                                            (|loadLib| |entry|)))
                                          (SETQ |infovec|
                                                  (GET |entry| '|infovec|))
                                          (SETQ |success|
                                                  (PROGN
                                                   (SETQ |opvec|
                                                           (ELT |infovec| 1))
                                                   (SETQ |max|
                                                           (MAXINDEX |opvec|))
                                                   (SETQ |code|
                                                           (|getOpCode| |op|
                                                            |opvec| |max|))
                                                   (COND ((NULL |code|) NIL)
                                                         (#1#
                                                          (PROGN
                                                           (SETQ |byteVector|
                                                                   (CDDDR
                                                                    (ELT
                                                                     |infovec|
                                                                     3)))
                                                           (SETQ |endPos|
                                                                   (COND
                                                                    ((< |max|
                                                                        (+
                                                                         |code|
                                                                         2))
                                                                     (SIZE
                                                                      |byteVector|))
                                                                    (#1#
                                                                     (ELT
                                                                      |opvec|
                                                                      (+ |code|
                                                                         2)))))
                                                           (COND
                                                            ((AND |check_num|
                                                                  (NULL
                                                                   (|nrunNumArgCheck|
                                                                    (LENGTH
                                                                     (QCDR
                                                                      |sig|))
                                                                    |byteVector|
                                                                    (ELT
                                                                     |opvec|
                                                                     |code|)
                                                                    |endPos|)))
                                                             NIL)
                                                            (#1#
                                                             (PROGN
                                                              (SETQ |packageForm|
                                                                      (CONS
                                                                       |entry|
                                                                       (CONS '$
                                                                             (CDR
                                                                              |cat|))))
                                                              (SETQ |package|
                                                                      (|evalSlotDomain|
                                                                       |packageForm|
                                                                       |dom|))
                                                              (SETF (ELT
                                                                     |packageVec|
                                                                     |i|)
                                                                      |package|)
                                                              |package|))))))))
                                          (COND
                                           ((NULL |success|)
                                            (PROGN
                                             (COND
                                              ((EQUAL |$monitorNewWorld| T)
                                               (|sayBrightlyNT| "  not in: ")
                                               (|pp|
                                                (OR
                                                 (AND |packageForm|
                                                      (|devaluate| |package|))
                                                 |entry|))))
                                             NIL))
                                           (#1#
                                            (PROGN
                                             (COND
                                              (|$monitorNewWorld|
                                               (|sayLooking1|
                                                "candidate default package instantiated: "
                                                |success|)))
                                             |success|)))))
                                        (#1# |entry|)))
                               (COND ((NULL |package|) NIL)
                                     (#1#
                                      (PROGN
                                       (COND
                                        (|$monitorNewWorld|
                                         (|sayLooking1|
                                          "Looking at instantiated package "
                                          |package|)))
                                       (COND
                                        ((SETQ |res|
                                                 (|basicLookup| |op| |sig|
                                                  |package| |dollar|))
                                         (PROGN
                                          (COND
                                           ((EQUAL |$monitorNewWorld| T)
                                            (|sayBrightly|
                                             "candidate default package succeeds")))
                                          (RETURN |res|)))
                                        (#1#
                                         (PROGN
                                          (COND
                                           ((EQUAL |$monitorNewWorld| T)
                                            (|sayBrightly|
                                             "candidate fails -- continuing to search categories")))
                                          NIL))))))))))
                  (SETQ |i| (+ |i| 1))))
               (MAXINDEX |packageVec|) 0))))))))

; nrunNumArgCheck(num,bytevec,start,finish) ==
;    args := bytevec.start
;    num = args => true
;    (start := start + args + 4) = finish => nil
;    nrunNumArgCheck(num,bytevec,start,finish)

(DEFUN |nrunNumArgCheck| (|num| |bytevec| |start| |finish|)
  (PROG (|args|)
    (RETURN
     (PROGN
      (SETQ |args| (ELT |bytevec| |start|))
      (COND ((EQUAL |num| |args|) T)
            ((EQUAL (SETQ |start| (+ (+ |start| |args|) 4)) |finish|) NIL)
            ('T (|nrunNumArgCheck| |num| |bytevec| |start| |finish|)))))))

; newCompareSig(sig, numvec, index, dollar, domain) ==
;   k := index
;   null (target := first sig)
;    or lazyMatchArg(target,numvec.k,dollar,domain) =>
;      and/[lazyMatchArg(s,numvec.(k := i),dollar,domain)
;               for s in rest sig for i in (index+1)..] => numvec.(inc_SI k)
;      nil
;   nil

(DEFUN |newCompareSig| (|sig| |numvec| |index| |dollar| |domain|)
  (PROG (|k| |target|)
    (RETURN
     (PROGN
      (SETQ |k| |index|)
      (COND
       ((OR (NULL (SETQ |target| (CAR |sig|)))
            (|lazyMatchArg| |target| (ELT |numvec| |k|) |dollar| |domain|))
        (COND
         (((LAMBDA (|bfVar#8| |bfVar#7| |s| |i|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#7|) (PROGN (SETQ |s| (CAR |bfVar#7|)) NIL))
                (RETURN |bfVar#8|))
               (#1='T
                (PROGN
                 (SETQ |bfVar#8|
                         (|lazyMatchArg| |s| (ELT |numvec| (SETQ |k| |i|))
                          |dollar| |domain|))
                 (COND ((NOT |bfVar#8|) (RETURN NIL))))))
              (SETQ |bfVar#7| (CDR |bfVar#7|))
              (SETQ |i| (+ |i| 1))))
           T (CDR |sig|) NIL (+ |index| 1))
          (ELT |numvec| (|inc_SI| |k|)))
         (#1# NIL)))
       (#1# NIL))))))

; lazyMatchArg(s,a,dollar,domain) == lazyMatchArg2(s,a,dollar,domain,true)

(DEFUN |lazyMatchArg| (|s| |a| |dollar| |domain|)
  (PROG () (RETURN (|lazyMatchArg2| |s| |a| |dollar| |domain| T))))

; lazyMatch(source,lazyt,dollar,domain) ==
;   lazyt is [op, :argl] and null atom source and op = first source
;     and #(sargl := rest source) = #argl =>
;       MEMQ(op,'(Record Union)) and first argl is [":",:.] =>
;         and/[stag = atag and lazyMatchArg(s,a,dollar,domain)
;               for [.,stag,s] in sargl for [.,atag,a] in argl]
;       MEMQ(op,'(Union Mapping QUOTE)) =>
;          and/[lazyMatchArg(s,a,dollar,domain) for s in sargl for a in argl]
;       coSig := GETDATABASE(op,'COSIG)
;       NULL coSig => error ["bad Constructor op", op]
;       and/[lazyMatchArg2(s,a,dollar,domain,flag)
;            for s in sargl for a in argl for flag in rest coSig]
;   STRINGP source and lazyt is ['QUOTE,=source] => true
;   NUMBERP source =>
;       lazyt is ['_#, slotNum] => source = #(domain.slotNum)
;       lazyt is ['call,'LENGTH, slotNum] => source = #(domain.slotNum)
;       lazyt is ['LENGTH, slotNum] => source = #(domain.slotNum)
;       nil
;   source is ['construct,:l] => l = lazyt
;   -- A hideous hack on the same lines as the previous four lines JHD/MCD
;   nil

(DEFUN |lazyMatch| (|source| |lazyt| |dollar| |domain|)
  (PROG (|op| |argl| |sargl| |ISTMP#1| |stag| |ISTMP#2| |s| |atag| |a| |coSig|
         |slotNum| |l|)
    (RETURN
     (COND
      ((AND (CONSP |lazyt|)
            (PROGN (SETQ |op| (CAR |lazyt|)) (SETQ |argl| (CDR |lazyt|)) #1='T)
            (NULL (ATOM |source|)) (EQUAL |op| (CAR |source|))
            (EQL (LENGTH (SETQ |sargl| (CDR |source|))) (LENGTH |argl|)))
       (COND
        ((AND (MEMQ |op| '(|Record| |Union|))
              (PROGN
               (SETQ |ISTMP#1| (CAR |argl|))
               (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|))))
         ((LAMBDA (|bfVar#13| |bfVar#10| |bfVar#9| |bfVar#12| |bfVar#11|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#10|)
                   (PROGN (SETQ |bfVar#9| (CAR |bfVar#10|)) NIL)
                   (ATOM |bfVar#12|)
                   (PROGN (SETQ |bfVar#11| (CAR |bfVar#12|)) NIL))
               (RETURN |bfVar#13|))
              (#1#
               (AND (CONSP |bfVar#9|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |bfVar#9|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |stag| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |s| (CAR |ISTMP#2|)) #1#)))))
                    (CONSP |bfVar#11|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |bfVar#11|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |atag| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN (SETQ |a| (CAR |ISTMP#2|)) #1#)))))
                    (PROGN
                     (SETQ |bfVar#13|
                             (AND (EQUAL |stag| |atag|)
                                  (|lazyMatchArg| |s| |a| |dollar| |domain|)))
                     (COND ((NOT |bfVar#13|) (RETURN NIL)))))))
             (SETQ |bfVar#10| (CDR |bfVar#10|))
             (SETQ |bfVar#12| (CDR |bfVar#12|))))
          T |sargl| NIL |argl| NIL))
        ((MEMQ |op| '(|Union| |Mapping| QUOTE))
         ((LAMBDA (|bfVar#16| |bfVar#14| |s| |bfVar#15| |a|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#14|) (PROGN (SETQ |s| (CAR |bfVar#14|)) NIL)
                   (ATOM |bfVar#15|) (PROGN (SETQ |a| (CAR |bfVar#15|)) NIL))
               (RETURN |bfVar#16|))
              (#1#
               (PROGN
                (SETQ |bfVar#16| (|lazyMatchArg| |s| |a| |dollar| |domain|))
                (COND ((NOT |bfVar#16|) (RETURN NIL))))))
             (SETQ |bfVar#14| (CDR |bfVar#14|))
             (SETQ |bfVar#15| (CDR |bfVar#15|))))
          T |sargl| NIL |argl| NIL))
        (#1#
         (PROGN
          (SETQ |coSig| (GETDATABASE |op| 'COSIG))
          (COND ((NULL |coSig|) (|error| (LIST '|bad Constructor op| |op|)))
                (#1#
                 ((LAMBDA
                      (|bfVar#20| |bfVar#17| |s| |bfVar#18| |a| |bfVar#19|
                       |flag|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#17|)
                           (PROGN (SETQ |s| (CAR |bfVar#17|)) NIL)
                           (ATOM |bfVar#18|)
                           (PROGN (SETQ |a| (CAR |bfVar#18|)) NIL)
                           (ATOM |bfVar#19|)
                           (PROGN (SETQ |flag| (CAR |bfVar#19|)) NIL))
                       (RETURN |bfVar#20|))
                      (#1#
                       (PROGN
                        (SETQ |bfVar#20|
                                (|lazyMatchArg2| |s| |a| |dollar| |domain|
                                 |flag|))
                        (COND ((NOT |bfVar#20|) (RETURN NIL))))))
                     (SETQ |bfVar#17| (CDR |bfVar#17|))
                     (SETQ |bfVar#18| (CDR |bfVar#18|))
                     (SETQ |bfVar#19| (CDR |bfVar#19|))))
                  T |sargl| NIL |argl| NIL (CDR |coSig|) NIL)))))))
      ((AND (STRINGP |source|) (CONSP |lazyt|) (EQ (CAR |lazyt|) 'QUOTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |lazyt|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (EQUAL (CAR |ISTMP#1|) |source|))))
       T)
      ((NUMBERP |source|)
       (COND
        ((AND (CONSP |lazyt|) (EQ (CAR |lazyt|) '|#|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |lazyt|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                    (PROGN (SETQ |slotNum| (CAR |ISTMP#1|)) #1#))))
         (EQL |source| (LENGTH (ELT |domain| |slotNum|))))
        ((AND (CONSP |lazyt|) (EQ (CAR |lazyt|) '|call|)
              (PROGN
               (SETQ |ISTMP#1| (CDR |lazyt|))
               (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) 'LENGTH)
                    (PROGN
                     (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                     (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                          (PROGN (SETQ |slotNum| (CAR |ISTMP#2|)) #1#))))))
         (EQL |source| (LENGTH (ELT |domain| |slotNum|))))
        ((AND (CONSP |lazyt|) (EQ (CAR |lazyt|) 'LENGTH)
              (PROGN
               (SETQ |ISTMP#1| (CDR |lazyt|))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                    (PROGN (SETQ |slotNum| (CAR |ISTMP#1|)) #1#))))
         (EQL |source| (LENGTH (ELT |domain| |slotNum|))))
        (#1# NIL)))
      ((AND (CONSP |source|) (EQ (CAR |source|) '|construct|)
            (PROGN (SETQ |l| (CDR |source|)) #1#))
       (EQUAL |l| |lazyt|))
      (#1# NIL)))))

; lazyMatchArgDollarCheck(s,d,dollarName,domainName) ==
;   #s ~= #d => nil
;   scoSig := GETDATABASE(opOf s,'COSIG) or return nil
;   if MEMQ(opOf s, '(Union Mapping Record)) then
;      scoSig := [true for x in s]
;   and/[fn for x in rest s for arg in rest d for xt in rest scoSig] where
;    fn ==
;     x = arg => true
;     x is ['elt,someDomain,opname] => lookupInDomainByName(opname,evalDomain someDomain,arg)
;     x = '$ and (arg = dollarName or arg = domainName) => true
;     x = dollarName and arg = domainName => true
;     ATOM x or ATOM arg => false
;     xt and first x = first arg =>
;       lazyMatchArgDollarCheck(x,arg,dollarName,domainName)
;     false

(DEFUN |lazyMatchArgDollarCheck| (|s| |d| |dollarName| |domainName|)
  (PROG (|scoSig| |ISTMP#1| |someDomain| |ISTMP#2| |opname|)
    (RETURN
     (COND ((NOT (EQL (LENGTH |s|) (LENGTH |d|))) NIL)
           (#1='T
            (PROGN
             (SETQ |scoSig|
                     (OR (GETDATABASE (|opOf| |s|) 'COSIG) (RETURN NIL)))
             (COND
              ((MEMQ (|opOf| |s|) '(|Union| |Mapping| |Record|))
               (SETQ |scoSig|
                       ((LAMBDA (|bfVar#22| |bfVar#21| |x|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#21|)
                                 (PROGN (SETQ |x| (CAR |bfVar#21|)) NIL))
                             (RETURN (NREVERSE |bfVar#22|)))
                            (#1# (SETQ |bfVar#22| (CONS T |bfVar#22|))))
                           (SETQ |bfVar#21| (CDR |bfVar#21|))))
                        NIL |s| NIL))))
             ((LAMBDA
                  (|bfVar#26| |bfVar#23| |x| |bfVar#24| |arg| |bfVar#25| |xt|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#23|)
                       (PROGN (SETQ |x| (CAR |bfVar#23|)) NIL)
                       (ATOM |bfVar#24|)
                       (PROGN (SETQ |arg| (CAR |bfVar#24|)) NIL)
                       (ATOM |bfVar#25|)
                       (PROGN (SETQ |xt| (CAR |bfVar#25|)) NIL))
                   (RETURN |bfVar#26|))
                  (#1#
                   (PROGN
                    (SETQ |bfVar#26|
                            (COND ((EQUAL |x| |arg|) T)
                                  ((AND (CONSP |x|) (EQ (CAR |x|) '|elt|)
                                        (PROGN
                                         (SETQ |ISTMP#1| (CDR |x|))
                                         (AND (CONSP |ISTMP#1|)
                                              (PROGN
                                               (SETQ |someDomain|
                                                       (CAR |ISTMP#1|))
                                               (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                               (AND (CONSP |ISTMP#2|)
                                                    (EQ (CDR |ISTMP#2|) NIL)
                                                    (PROGN
                                                     (SETQ |opname|
                                                             (CAR |ISTMP#2|))
                                                     #1#))))))
                                   (|lookupInDomainByName| |opname|
                                    (|evalDomain| |someDomain|) |arg|))
                                  ((AND (EQ |x| '$)
                                        (OR (EQUAL |arg| |dollarName|)
                                            (EQUAL |arg| |domainName|)))
                                   T)
                                  ((AND (EQUAL |x| |dollarName|)
                                        (EQUAL |arg| |domainName|))
                                   T)
                                  ((OR (ATOM |x|) (ATOM |arg|)) NIL)
                                  ((AND |xt| (EQUAL (CAR |x|) (CAR |arg|)))
                                   (|lazyMatchArgDollarCheck| |x| |arg|
                                    |dollarName| |domainName|))
                                  (#1# NIL)))
                    (COND ((NOT |bfVar#26|) (RETURN NIL))))))
                 (SETQ |bfVar#23| (CDR |bfVar#23|))
                 (SETQ |bfVar#24| (CDR |bfVar#24|))
                 (SETQ |bfVar#25| (CDR |bfVar#25|))))
              T (CDR |s|) NIL (CDR |d|) NIL (CDR |scoSig|) NIL)))))))

; lookupInDomainByName(op,domain,arg) ==
;   atom arg => nil
;   opvec := domain . 1 . 2
;   numvec := getDomainByteVector domain
;   predvec := domain.3
;   max := MAXINDEX opvec
;   k := getOpCode(op,opvec,max) or return nil
;   maxIndex := MAXINDEX numvec
;   start := ELT(opvec,k)
;   finish :=
;     greater_SI(max, k) => opvec.(add_SI(k, 2))
;     maxIndex
;   if greater_SI(finish, maxIndex) then systemError '"limit too large"
;   success := false
;   while finish > start repeat
;     i := start
;     numberOfArgs :=numvec.i
;     predIndex := numvec.(i := inc_SI i)
;     predIndex ~= 0 and null testBitVector(predvec, predIndex) => nil
;     slotIndex := numvec.(i + 2 + numberOfArgs)
;     slot := domain.slotIndex
;     null atom slot and EQ(first slot, first arg) and EQ(rest slot, rest arg) =>
;         return (success := true)
;     start := add_SI(start, add_SI(numberOfArgs, 4))
;   success

(DEFUN |lookupInDomainByName| (|op| |domain| |arg|)
  (PROG (|opvec| |numvec| |predvec| |max| |k| |maxIndex| |start| |finish|
         |success| |i| |numberOfArgs| |predIndex| |slotIndex| |slot|)
    (RETURN
     (COND ((ATOM |arg|) NIL)
           (#1='T
            (PROGN
             (SETQ |opvec| (ELT (ELT |domain| 1) 2))
             (SETQ |numvec| (|getDomainByteVector| |domain|))
             (SETQ |predvec| (ELT |domain| 3))
             (SETQ |max| (MAXINDEX |opvec|))
             (SETQ |k| (OR (|getOpCode| |op| |opvec| |max|) (RETURN NIL)))
             (SETQ |maxIndex| (MAXINDEX |numvec|))
             (SETQ |start| (ELT |opvec| |k|))
             (SETQ |finish|
                     (COND
                      ((|greater_SI| |max| |k|) (ELT |opvec| (|add_SI| |k| 2)))
                      (#1# |maxIndex|)))
             (COND
              ((|greater_SI| |finish| |maxIndex|)
               (|systemError| "limit too large")))
             (SETQ |success| NIL)
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT (< |start| |finish|)) (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |i| |start|)
                         (SETQ |numberOfArgs| (ELT |numvec| |i|))
                         (SETQ |predIndex|
                                 (ELT |numvec| (SETQ |i| (|inc_SI| |i|))))
                         (COND
                          ((AND (NOT (EQL |predIndex| 0))
                                (NULL (|testBitVector| |predvec| |predIndex|)))
                           NIL)
                          (#1#
                           (PROGN
                            (SETQ |slotIndex|
                                    (ELT |numvec|
                                         (+ (+ |i| 2) |numberOfArgs|)))
                            (SETQ |slot| (ELT |domain| |slotIndex|))
                            (COND
                             ((AND (NULL (ATOM |slot|))
                                   (EQ (CAR |slot|) (CAR |arg|))
                                   (EQ (CDR |slot|) (CDR |arg|)))
                              (RETURN (SETQ |success| T)))
                             (#1#
                              (SETQ |start|
                                      (|add_SI| |start|
                                       (|add_SI| |numberOfArgs| 4))))))))))))))
             |success|))))))

; newExpandTypeSlot(slot, dollar, domain) ==
; --> returns domain form for dollar.slot
;    newExpandLocalType(sigDomainVal(dollar, domain, slot), dollar,domain)

(DEFUN |newExpandTypeSlot| (|slot| |dollar| |domain|)
  (PROG ()
    (RETURN
     (|newExpandLocalType| (|sigDomainVal| |dollar| |domain| |slot|) |dollar|
      |domain|))))

; newExpandLocalType(lazyt, dollar, domain) ==
;     VECP lazyt => lazyt.0
;     isDomain lazyt => devaluate lazyt
;     ATOM lazyt => lazyt
;     newExpandLocalTypeForm(lazyt, dollar, domain)

(DEFUN |newExpandLocalType| (|lazyt| |dollar| |domain|)
  (PROG ()
    (RETURN
     (COND ((VECP |lazyt|) (ELT |lazyt| 0))
           ((|isDomain| |lazyt|) (|devaluate| |lazyt|))
           ((ATOM |lazyt|) |lazyt|)
           ('T (|newExpandLocalTypeForm| |lazyt| |dollar| |domain|))))))

; newExpandLocalTypeForm([functorName,:argl],dollar,domain) ==
;   MEMQ(functorName, '(Record Union)) and first argl is [":",:.] =>
;     [functorName,:[['_:,tag,newExpandLocalTypeArgs(dom,dollar,domain,true)]
;                                  for [.,tag,dom] in argl]]
;   MEMQ(functorName, '(Union Mapping)) =>
;           [functorName,:[newExpandLocalTypeArgs(a,dollar,domain,true) for a in argl]]
;   functorName = 'QUOTE => [functorName,:argl]
;   coSig := GETDATABASE(functorName,'COSIG)
;   NULL coSig => error ["bad functorName", functorName]
;   [functorName,:[newExpandLocalTypeArgs(a,dollar,domain,flag)
;         for a in argl for flag in rest coSig]]

(DEFUN |newExpandLocalTypeForm| (|bfVar#35| |dollar| |domain|)
  (PROG (|functorName| |argl| |ISTMP#1| |tag| |ISTMP#2| |dom| |coSig|)
    (RETURN
     (PROGN
      (SETQ |functorName| (CAR |bfVar#35|))
      (SETQ |argl| (CDR |bfVar#35|))
      (COND
       ((AND (MEMQ |functorName| '(|Record| |Union|))
             (PROGN
              (SETQ |ISTMP#1| (CAR |argl|))
              (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|:|))))
        (CONS |functorName|
              ((LAMBDA (|bfVar#29| |bfVar#28| |bfVar#27|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#28|)
                        (PROGN (SETQ |bfVar#27| (CAR |bfVar#28|)) NIL))
                    (RETURN (NREVERSE |bfVar#29|)))
                   (#1='T
                    (AND (CONSP |bfVar#27|)
                         (PROGN
                          (SETQ |ISTMP#1| (CDR |bfVar#27|))
                          (AND (CONSP |ISTMP#1|)
                               (PROGN
                                (SETQ |tag| (CAR |ISTMP#1|))
                                (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                     (PROGN
                                      (SETQ |dom| (CAR |ISTMP#2|))
                                      #1#)))))
                         (SETQ |bfVar#29|
                                 (CONS
                                  (LIST '|:| |tag|
                                        (|newExpandLocalTypeArgs| |dom|
                                         |dollar| |domain| T))
                                  |bfVar#29|)))))
                  (SETQ |bfVar#28| (CDR |bfVar#28|))))
               NIL |argl| NIL)))
       ((MEMQ |functorName| '(|Union| |Mapping|))
        (CONS |functorName|
              ((LAMBDA (|bfVar#31| |bfVar#30| |a|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#30|)
                        (PROGN (SETQ |a| (CAR |bfVar#30|)) NIL))
                    (RETURN (NREVERSE |bfVar#31|)))
                   (#1#
                    (SETQ |bfVar#31|
                            (CONS
                             (|newExpandLocalTypeArgs| |a| |dollar| |domain| T)
                             |bfVar#31|))))
                  (SETQ |bfVar#30| (CDR |bfVar#30|))))
               NIL |argl| NIL)))
       ((EQ |functorName| 'QUOTE) (CONS |functorName| |argl|))
       (#1#
        (PROGN
         (SETQ |coSig| (GETDATABASE |functorName| 'COSIG))
         (COND
          ((NULL |coSig|) (|error| (LIST '|bad functorName| |functorName|)))
          (#1#
           (CONS |functorName|
                 ((LAMBDA (|bfVar#34| |bfVar#32| |a| |bfVar#33| |flag|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#32|)
                           (PROGN (SETQ |a| (CAR |bfVar#32|)) NIL)
                           (ATOM |bfVar#33|)
                           (PROGN (SETQ |flag| (CAR |bfVar#33|)) NIL))
                       (RETURN (NREVERSE |bfVar#34|)))
                      (#1#
                       (SETQ |bfVar#34|
                               (CONS
                                (|newExpandLocalTypeArgs| |a| |dollar| |domain|
                                 |flag|)
                                |bfVar#34|))))
                     (SETQ |bfVar#32| (CDR |bfVar#32|))
                     (SETQ |bfVar#33| (CDR |bfVar#33|))))
                  NIL |argl| NIL (CDR |coSig|) NIL)))))))))))

; newExpandLocalTypeArgs(u,dollar,domain,typeFlag) ==
;   u = '$ => u
;   INTEGERP u =>
;      typeFlag => newExpandTypeSlot(u, dollar,domain)
;      domain.u
;   u is ['NRTEVAL,y] => nrtEval(y,domain)
;   u is ['QUOTE,y] => y
;   u = "$$" => domain.0
;   atom u => u   --can be first, rest, etc.
;   newExpandLocalTypeForm(u,dollar,domain)

(DEFUN |newExpandLocalTypeArgs| (|u| |dollar| |domain| |typeFlag|)
  (PROG (|ISTMP#1| |y|)
    (RETURN
     (COND ((EQ |u| '$) |u|)
           ((INTEGERP |u|)
            (COND (|typeFlag| (|newExpandTypeSlot| |u| |dollar| |domain|))
                  (#1='T (ELT |domain| |u|))))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'NRTEVAL)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
            (|nrtEval| |y| |domain|))
           ((AND (CONSP |u|) (EQ (CAR |u|) 'QUOTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |u|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |y| (CAR |ISTMP#1|)) #1#))))
            |y|)
           ((EQ |u| '$$) (ELT |domain| 0)) ((ATOM |u|) |u|)
           (#1# (|newExpandLocalTypeForm| |u| |dollar| |domain|))))))

; nrtEval(expr,dom) ==
;   $:fluid := dom
;   eval expr

(DEFUN |nrtEval| (|expr| |dom|)
  (PROG ($)
    (DECLARE (SPECIAL $))
    (RETURN (PROGN (SETQ $ |dom|) (|eval| |expr|)))))

; domainVal(dollar,domain,index) ==
; --returns a domain or a lazy slot
;   index = 0 => dollar
;   index = 2 => domain
;   domain.index

(DEFUN |domainVal| (|dollar| |domain| |index|)
  (PROG ()
    (RETURN
     (COND ((EQL |index| 0) |dollar|) ((EQL |index| 2) |domain|)
           ('T (ELT |domain| |index|))))))

; sigDomainVal(dollar,domain,index) ==
; --returns a domain or a lazy slot
;   index = 0 => "$"
;   index = 2 => domain
;   domain.index

(DEFUN |sigDomainVal| (|dollar| |domain| |index|)
  (PROG ()
    (RETURN
     (COND ((EQL |index| 0) '$) ((EQL |index| 2) |domain|)
           ('T (ELT |domain| |index|))))))

; newHasTest(domform,catOrAtt) ==
;   NULL(domform) => systemError '"newHasTest expects domain form"
;   domform is [dom,:.] and dom in '(Union Record Mapping Enumeration) =>
;     ofCategory(domform, catOrAtt)
;   catOrAtt = '(Type) => true
;   GETDATABASE(opOf domform, 'ASHARP?) => fn(domform,catOrAtt) where
;   -- atom (infovec := getInfovec opOf domform) => fn(domform,catOrAtt) where
;     fn(a,b) ==
;       categoryForm?(a) => assoc(b, ancestors_of_cat(a, nil))
;       isPartialMode a => throwKeyedMsg("S2IS0025",NIL)
;       b is ["SIGNATURE",:opSig] =>
;         HasSignature(evalDomain a,opSig)
;       b is ["ATTRIBUTE",attr] =>
;           BREAK()
;       hasCaty(a,b,NIL) ~= 'failed
;       HasCategory(evalDomain a,b) => true -- for asharp domains: must return Boolean
;   op := opOf catOrAtt
;   isAtom := atom catOrAtt
;   null isAtom and op = 'Join =>
;     and/[newHasTest(domform,x) for x in rest catOrAtt]
; -- we will refuse to say yes for 'Cat has Cat'
; --GETDATABASE(opOf domform,'CONSTRUCTORKIND) = 'category => throwKeyedMsg("S2IS0025",NIL)
; -- on second thoughts we won't!
;   catOrAtt is [":", fun, ["Mapping", :sig1]] =>
;       evaluateType ["Mapping", :sig1] is ["Mapping", :sig2]  =>
;          not(null(HasSignature(domform, [fun, sig2])))
;       systemError '"strange Mapping type in newHasTest"
;   GETDATABASE(opOf domform,'CONSTRUCTORKIND) = 'category =>
;       domform = catOrAtt => 'T
;       for [aCat, :cond] in ancestors_of_cat(domform, NIL)
;            | aCat = catOrAtt  repeat
;          return evalCond cond where
;            evalCond x ==
;              ATOM x => x
;              [pred,:l] := x
;              pred = 'has =>
;                   l is [ w1,['ATTRIBUTE,w2]] =>
;                        BREAK()
;                        newHasTest(w1,w2)
;                   l is [ w1, ['SIGNATURE, :w2]] =>
;                       compiledLookup(first w2, CADR w2, eval mkEvalable w1)
;                   newHasTest(first  l ,first rest l)
;              pred = 'OR => or/[evalCond i for i in l]
;              pred = 'AND => and/[evalCond i for i in l]
;              x
;   null isAtom and constructor? op  =>
;     domain := eval mkEvalable domform
;     newHasCategory(domain,catOrAtt)
;   systemError '"newHasTest expects category form"

(DEFUN |newHasTest| (|domform| |catOrAtt|)
  (PROG (|dom| |op| |isAtom| |ISTMP#1| |fun| |ISTMP#2| |ISTMP#3| |sig1| |sig2|
         |aCat| |cond| |domain|)
    (RETURN
     (COND ((NULL |domform|) (|systemError| "newHasTest expects domain form"))
           ((AND (CONSP |domform|) (PROGN (SETQ |dom| (CAR |domform|)) #1='T)
                 (|member| |dom| '(|Union| |Record| |Mapping| |Enumeration|)))
            (|ofCategory| |domform| |catOrAtt|))
           ((EQUAL |catOrAtt| '(|Type|)) T)
           ((GETDATABASE (|opOf| |domform|) 'ASHARP?)
            (|newHasTest,fn| |domform| |catOrAtt|))
           (#1#
            (PROGN
             (SETQ |op| (|opOf| |catOrAtt|))
             (SETQ |isAtom| (ATOM |catOrAtt|))
             (COND
              ((AND (NULL |isAtom|) (EQ |op| '|Join|))
               ((LAMBDA (|bfVar#37| |bfVar#36| |x|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#36|)
                         (PROGN (SETQ |x| (CAR |bfVar#36|)) NIL))
                     (RETURN |bfVar#37|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#37| (|newHasTest| |domform| |x|))
                      (COND ((NOT |bfVar#37|) (RETURN NIL))))))
                   (SETQ |bfVar#36| (CDR |bfVar#36|))))
                T (CDR |catOrAtt|) NIL))
              ((AND (CONSP |catOrAtt|) (EQ (CAR |catOrAtt|) '|:|)
                    (PROGN
                     (SETQ |ISTMP#1| (CDR |catOrAtt|))
                     (AND (CONSP |ISTMP#1|)
                          (PROGN
                           (SETQ |fun| (CAR |ISTMP#1|))
                           (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                           (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                                (PROGN
                                 (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                 (AND (CONSP |ISTMP#3|)
                                      (EQ (CAR |ISTMP#3|) '|Mapping|)
                                      (PROGN
                                       (SETQ |sig1| (CDR |ISTMP#3|))
                                       #1#))))))))
               (COND
                ((PROGN
                  (SETQ |ISTMP#1| (|evaluateType| (CONS '|Mapping| |sig1|)))
                  (AND (CONSP |ISTMP#1|) (EQ (CAR |ISTMP#1|) '|Mapping|)
                       (PROGN (SETQ |sig2| (CDR |ISTMP#1|)) #1#)))
                 (NULL (NULL (|HasSignature| |domform| (LIST |fun| |sig2|)))))
                (#1# (|systemError| "strange Mapping type in newHasTest"))))
              ((EQ (GETDATABASE (|opOf| |domform|) 'CONSTRUCTORKIND)
                   '|category|)
               (COND ((EQUAL |domform| |catOrAtt|) 'T)
                     (#1#
                      ((LAMBDA (|bfVar#39| |bfVar#38|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#39|)
                                (PROGN (SETQ |bfVar#38| (CAR |bfVar#39|)) NIL))
                            (RETURN NIL))
                           (#1#
                            (AND (CONSP |bfVar#38|)
                                 (PROGN
                                  (SETQ |aCat| (CAR |bfVar#38|))
                                  (SETQ |cond| (CDR |bfVar#38|))
                                  #1#)
                                 (EQUAL |aCat| |catOrAtt|)
                                 (RETURN (|newHasTest,evalCond| |cond|)))))
                          (SETQ |bfVar#39| (CDR |bfVar#39|))))
                       (|ancestors_of_cat| |domform| NIL) NIL))))
              ((AND (NULL |isAtom|) (|constructor?| |op|))
               (PROGN
                (SETQ |domain| (|eval| (|mkEvalable| |domform|)))
                (|newHasCategory| |domain| |catOrAtt|)))
              (#1# (|systemError| "newHasTest expects category form")))))))))
(DEFUN |newHasTest,evalCond| (|x|)
  (PROG (|pred| |l| |w1| |ISTMP#1| |ISTMP#2| |ISTMP#3| |w2|)
    (RETURN
     (COND ((ATOM |x|) |x|)
           (#1='T
            (PROGN
             (SETQ |pred| (CAR |x|))
             (SETQ |l| (CDR |x|))
             (COND
              ((EQ |pred| '|has|)
               (COND
                ((AND (CONSP |l|)
                      (PROGN
                       (SETQ |w1| (CAR |l|))
                       (SETQ |ISTMP#1| (CDR |l|))
                       (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                            (PROGN
                             (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                             (AND (CONSP |ISTMP#2|)
                                  (EQ (CAR |ISTMP#2|) 'ATTRIBUTE)
                                  (PROGN
                                   (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                   (AND (CONSP |ISTMP#3|)
                                        (EQ (CDR |ISTMP#3|) NIL)
                                        (PROGN
                                         (SETQ |w2| (CAR |ISTMP#3|))
                                         #1#))))))))
                 (PROGN (BREAK) (|newHasTest| |w1| |w2|)))
                ((AND (CONSP |l|)
                      (PROGN
                       (SETQ |w1| (CAR |l|))
                       (SETQ |ISTMP#1| (CDR |l|))
                       (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                            (PROGN
                             (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                             (AND (CONSP |ISTMP#2|)
                                  (EQ (CAR |ISTMP#2|) 'SIGNATURE)
                                  (PROGN (SETQ |w2| (CDR |ISTMP#2|)) #1#))))))
                 (|compiledLookup| (CAR |w2|) (CADR |w2|)
                  (|eval| (|mkEvalable| |w1|))))
                (#1# (|newHasTest| (CAR |l|) (CAR (CDR |l|))))))
              ((EQ |pred| 'OR)
               ((LAMBDA (|bfVar#41| |bfVar#40| |i|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#40|)
                         (PROGN (SETQ |i| (CAR |bfVar#40|)) NIL))
                     (RETURN |bfVar#41|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#41| (|newHasTest,evalCond| |i|))
                      (COND (|bfVar#41| (RETURN |bfVar#41|))))))
                   (SETQ |bfVar#40| (CDR |bfVar#40|))))
                NIL |l| NIL))
              ((EQ |pred| 'AND)
               ((LAMBDA (|bfVar#43| |bfVar#42| |i|)
                  (LOOP
                   (COND
                    ((OR (ATOM |bfVar#42|)
                         (PROGN (SETQ |i| (CAR |bfVar#42|)) NIL))
                     (RETURN |bfVar#43|))
                    (#1#
                     (PROGN
                      (SETQ |bfVar#43| (|newHasTest,evalCond| |i|))
                      (COND ((NOT |bfVar#43|) (RETURN NIL))))))
                   (SETQ |bfVar#42| (CDR |bfVar#42|))))
                T |l| NIL))
              (#1# |x|))))))))
(DEFUN |newHasTest,fn| (|a| |b|)
  (PROG (|opSig| |ISTMP#1| |attr|)
    (RETURN
     (COND ((|categoryForm?| |a|) (|assoc| |b| (|ancestors_of_cat| |a| NIL)))
           ((|isPartialMode| |a|) (|throwKeyedMsg| 'S2IS0025 NIL))
           ((AND (CONSP |b|) (EQ (CAR |b|) 'SIGNATURE)
                 (PROGN (SETQ |opSig| (CDR |b|)) #1='T))
            (|HasSignature| (|evalDomain| |a|) |opSig|))
           ((AND (CONSP |b|) (EQ (CAR |b|) 'ATTRIBUTE)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |b|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |attr| (CAR |ISTMP#1|)) #1#))))
            (BREAK))
           (#1#
            (PROGN
             (NOT (EQ (|hasCaty| |a| |b| NIL) '|failed|))
             (COND ((|HasCategory| (|evalDomain| |a|) |b|) T))))))))

; sayLooking(prefix,op,sig,dom) ==
;   $monitorNewWorld := false
;   dollar := devaluate dom
;   atom dollar or VECP dollar or or/[VECP x for x in dollar] => systemError nil
;   sayBrightly
;     concat(prefix,formatOpSignature(op,sig),bright '"from ",form2String dollar)
;   $monitorNewWorld := true

(DEFUN |sayLooking| (|prefix| |op| |sig| |dom|)
  (PROG (|dollar|)
    (RETURN
     (PROGN
      (SETQ |$monitorNewWorld| NIL)
      (SETQ |dollar| (|devaluate| |dom|))
      (COND
       ((OR (ATOM |dollar|) (VECP |dollar|)
            ((LAMBDA (|bfVar#45| |bfVar#44| |x|)
               (LOOP
                (COND
                 ((OR (ATOM |bfVar#44|)
                      (PROGN (SETQ |x| (CAR |bfVar#44|)) NIL))
                  (RETURN |bfVar#45|))
                 (#1='T
                  (PROGN
                   (SETQ |bfVar#45| (VECP |x|))
                   (COND (|bfVar#45| (RETURN |bfVar#45|))))))
                (SETQ |bfVar#44| (CDR |bfVar#44|))))
             NIL |dollar| NIL))
        (|systemError| NIL))
       (#1#
        (PROGN
         (|sayBrightly|
          (|concat| |prefix| (|formatOpSignature| |op| |sig|)
           (|bright| "from ") (|form2String| |dollar|)))
         (SETQ |$monitorNewWorld| T))))))))

; sayLooking1(prefix,dom) ==
;   $monitorNewWorld := false
;   dollar :=
;     VECP dom => devaluate dom
;     devaluateList dom
;   sayBrightly concat(prefix,form2String dollar)
;   $monitorNewWorld := true

(DEFUN |sayLooking1| (|prefix| |dom|)
  (PROG (|dollar|)
    (RETURN
     (PROGN
      (SETQ |$monitorNewWorld| NIL)
      (SETQ |dollar|
              (COND ((VECP |dom|) (|devaluate| |dom|))
                    ('T (|devaluateList| |dom|))))
      (|sayBrightly| (|concat| |prefix| (|form2String| |dollar|)))
      (SETQ |$monitorNewWorld| T)))))

; cc() == -- don't remove this function
;   clearConstructorCaches()
;   clearClams()

(DEFUN |cc| ()
  (PROG () (RETURN (PROGN (|clearConstructorCaches|) (|clearClams|)))))


; )package "BOOT"

(IN-PACKAGE "BOOT")

; getDomainHash dom == SPADCALL(CDR dom, (CAR dom).4)

(DEFUN |getDomainHash| (|dom|)
  (PROG () (RETURN (SPADCALL (CDR |dom|) (ELT (CAR |dom|) 4)))))

; hashType(type, percentHash) ==
;         SYMBOLP type  =>
;            type = '$ => percentHash
;            type = "%" => percentHash
;            hashString SYMBOL_-NAME type
;         STRINGP type  => hashCombine(hashString type,
;                                         hashString('"Enumeration"))
;         type is ['QUOTE, val] => hashType(val, percentHash)
;         type is [dom] => hashString SYMBOL_-NAME dom
;         type is ['_:, ., type2] => hashType(type2, percentHash)
;         isDomain type => getDomainHash type
;         [op, :args] := type
;         hash := hashString SYMBOL_-NAME op
;         op = 'Mapping =>
;                 hash := hashString '"->"
;                 [retType, :mapArgs] := args
;                 for arg in mapArgs repeat
;                         hash := hashCombine(hashType(arg, percentHash), hash)
;                 retCode := hashType(retType, percentHash)
;                 EQL(retCode, $VoidHash) => hashCombine(32236, hash)
;                 hashCombine(retCode, hashCombine(32236,hash))
;         op = 'Enumeration =>
;                 for arg in args repeat
;                         hash := hashCombine(hashString(STRING arg), hash)
;                 hash
;         op in $DomainsWithoutLisplibs =>
;                 for arg in args repeat
;                         hash := hashCombine(hashType(arg, percentHash), hash)
;                 hash
;
;         cmm :=   CDDAR getConstructorModemap(op)
;         cosig := rest GETDATABASE(op, 'COSIG)
;         for arg in args for c in cosig for ct in cmm repeat
;                 if c then
;                         hash := hashCombine(hashType(arg, percentHash), hash)
;                 else
;                         hash := hashCombine(7, hash)
; --           !!!   If/when asharp hashes values using their type, use instead
; --                      ctt := EQSUBSTLIST(args, $FormalMapVariableList, ct)
; --                      hash := hashCombine(hashType(ctt, percentHash), hash)
;
;
;         hash

(DEFUN |hashType| (|type| |percentHash|)
  (PROG (|ISTMP#1| |val| |dom| |ISTMP#2| |type2| |op| |args| |hash| |retType|
         |mapArgs| |retCode| |cmm| |cosig|)
    (RETURN
     (COND
      ((SYMBOLP |type|)
       (COND ((EQ |type| '$) |percentHash|) ((EQ |type| '%) |percentHash|)
             (#1='T (|hashString| (SYMBOL-NAME |type|)))))
      ((STRINGP |type|)
       (|hashCombine| (|hashString| |type|) (|hashString| "Enumeration")))
      ((AND (CONSP |type|) (EQ (CAR |type|) 'QUOTE)
            (PROGN
             (SETQ |ISTMP#1| (CDR |type|))
             (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                  (PROGN (SETQ |val| (CAR |ISTMP#1|)) #1#))))
       (|hashType| |val| |percentHash|))
      ((AND (CONSP |type|) (EQ (CDR |type|) NIL)
            (PROGN (SETQ |dom| (CAR |type|)) #1#))
       (|hashString| (SYMBOL-NAME |dom|)))
      ((AND (CONSP |type|) (EQ (CAR |type|) '|:|)
            (PROGN
             (SETQ |ISTMP#1| (CDR |type|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                   (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                        (PROGN (SETQ |type2| (CAR |ISTMP#2|)) #1#))))))
       (|hashType| |type2| |percentHash|))
      ((|isDomain| |type|) (|getDomainHash| |type|))
      (#1#
       (PROGN
        (SETQ |op| (CAR |type|))
        (SETQ |args| (CDR |type|))
        (SETQ |hash| (|hashString| (SYMBOL-NAME |op|)))
        (COND
         ((EQ |op| '|Mapping|)
          (PROGN
           (SETQ |hash| (|hashString| "->"))
           (SETQ |retType| (CAR |args|))
           (SETQ |mapArgs| (CDR |args|))
           ((LAMBDA (|bfVar#1| |arg|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#1|) (PROGN (SETQ |arg| (CAR |bfVar#1|)) NIL))
                 (RETURN NIL))
                (#1#
                 (SETQ |hash|
                         (|hashCombine| (|hashType| |arg| |percentHash|)
                          |hash|))))
               (SETQ |bfVar#1| (CDR |bfVar#1|))))
            |mapArgs| NIL)
           (SETQ |retCode| (|hashType| |retType| |percentHash|))
           (COND ((EQL |retCode| |$VoidHash|) (|hashCombine| 32236 |hash|))
                 (#1#
                  (|hashCombine| |retCode| (|hashCombine| 32236 |hash|))))))
         ((EQ |op| '|Enumeration|)
          (PROGN
           ((LAMBDA (|bfVar#2| |arg|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#2|) (PROGN (SETQ |arg| (CAR |bfVar#2|)) NIL))
                 (RETURN NIL))
                (#1#
                 (SETQ |hash|
                         (|hashCombine| (|hashString| (STRING |arg|))
                          |hash|))))
               (SETQ |bfVar#2| (CDR |bfVar#2|))))
            |args| NIL)
           |hash|))
         ((|member| |op| |$DomainsWithoutLisplibs|)
          (PROGN
           ((LAMBDA (|bfVar#3| |arg|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#3|) (PROGN (SETQ |arg| (CAR |bfVar#3|)) NIL))
                 (RETURN NIL))
                (#1#
                 (SETQ |hash|
                         (|hashCombine| (|hashType| |arg| |percentHash|)
                          |hash|))))
               (SETQ |bfVar#3| (CDR |bfVar#3|))))
            |args| NIL)
           |hash|))
         (#1#
          (PROGN
           (SETQ |cmm| (CDDAR (|getConstructorModemap| |op|)))
           (SETQ |cosig| (CDR (GETDATABASE |op| 'COSIG)))
           ((LAMBDA (|bfVar#4| |arg| |bfVar#5| |c| |bfVar#6| |ct|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#4|) (PROGN (SETQ |arg| (CAR |bfVar#4|)) NIL)
                     (ATOM |bfVar#5|) (PROGN (SETQ |c| (CAR |bfVar#5|)) NIL)
                     (ATOM |bfVar#6|) (PROGN (SETQ |ct| (CAR |bfVar#6|)) NIL))
                 (RETURN NIL))
                (#1#
                 (COND
                  (|c|
                   (SETQ |hash|
                           (|hashCombine| (|hashType| |arg| |percentHash|)
                            |hash|)))
                  (#1# (SETQ |hash| (|hashCombine| 7 |hash|))))))
               (SETQ |bfVar#4| (CDR |bfVar#4|))
               (SETQ |bfVar#5| (CDR |bfVar#5|))
               (SETQ |bfVar#6| (CDR |bfVar#6|))))
            |args| NIL |cosig| NIL |cmm| NIL)
           |hash|)))))))))

; $hashModulus := 1073741789                      -- largest 30-bit prime

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashModulus| 1073741789))

; hashString str ==
;         h := 0
;         for i in 0..#str-1 repeat
;                 j := CHAR_-CODE char str.i
;                 h := LOGXOR(h, ASH(h, 8))
;                 h := h + j + 200041
;                 h := LOGAND(h, 1073741823)      -- 0x3FFFFFFF
;         REM(h, $hashModulus)

(DEFUN |hashString| (|str|)
  (PROG (|h| |j|)
    (RETURN
     (PROGN
      (SETQ |h| 0)
      ((LAMBDA (|bfVar#7| |i|)
         (LOOP
          (COND ((> |i| |bfVar#7|) (RETURN NIL))
                ('T
                 (PROGN
                  (SETQ |j| (CHAR-CODE (|char| (ELT |str| |i|))))
                  (SETQ |h| (LOGXOR |h| (ASH |h| 8)))
                  (SETQ |h| (+ (+ |h| |j|) 200041))
                  (SETQ |h| (LOGAND |h| 1073741823)))))
          (SETQ |i| (+ |i| 1))))
       (- (LENGTH |str|) 1) 0)
      (REM |h| |$hashModulus|)))))

; $hashZ1 := 1100661313

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashZ1| 1100661313))

; $hashZ2 := 1433925857

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashZ2| 1433925857))

; $hashZZ := 4903203917250634599

(EVAL-WHEN (EVAL LOAD) (SETQ |$hashZZ| 4903203917250634599))

; hashCombine(hash1, hash2) ==
;          h1 := LOGAND(hash1, ASH(1, 32) - 1)
;          h2 := LOGAND(hash2, ASH(1, 32) - 1)
;          LOGAND(ASH((h1*$hashZ1 + h2*$hashZ2) * $hashZZ, -32), 1073741823)

(DEFUN |hashCombine| (|hash1| |hash2|)
  (PROG (|h1| |h2|)
    (RETURN
     (PROGN
      (SETQ |h1| (LOGAND |hash1| (- (ASH 1 32) 1)))
      (SETQ |h2| (LOGAND |hash2| (- (ASH 1 32) 1)))
      (LOGAND
       (ASH (* (+ (* |h1| |$hashZ1|) (* |h2| |$hashZ2|)) |$hashZZ|) (- 32))
       1073741823)))))

; $VoidHash := hashString '"Void"

(EVAL-WHEN (EVAL LOAD) (SETQ |$VoidHash| (|hashString| "Void")))

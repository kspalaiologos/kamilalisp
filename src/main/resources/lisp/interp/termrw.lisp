
; )package "BOOT"

(IN-PACKAGE "BOOT")

; term1RW(t,R) ==
;   -- tries to reduce t at the top node
;   [vars,:varRules]:= R
;   for r in varRules until not (SL='failed) repeat
;     SL := termMatch(first r, t, NIL, vars)
;     not (SL='failed) =>
;       t := subCopy(copy rest r, SL)
;   t

(DEFUN |term1RW| (|t| R)
  (PROG (|vars| |varRules| SL)
    (RETURN
     (PROGN
      (SETQ |vars| (CAR R))
      (SETQ |varRules| (CDR R))
      ((LAMBDA (|bfVar#1| |r| |bfVar#2|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#1|) (PROGN (SETQ |r| (CAR |bfVar#1|)) NIL)
                |bfVar#2|)
            (RETURN NIL))
           ('T
            (PROGN
             (SETQ SL (|termMatch| (CAR |r|) |t| NIL |vars|))
             (COND
              ((NULL (EQ SL '|failed|))
               (SETQ |t| (|subCopy| (COPY (CDR |r|)) SL)))))))
          (SETQ |bfVar#1| (CDR |bfVar#1|))
          (SETQ |bfVar#2| (NULL (EQ SL '|failed|)))))
       |varRules| NIL NIL)
      |t|))))

; term1RWall(t,R) ==
;   -- same as term1RW, but returns a list
;   [vars,:varRules]:= R
;   [not (SL = 'failed) and subCopy(copy rest r, SL) for r in varRules |
;     not EQ(SL := termMatch(first r, t, NIL, vars), 'failed)]

(DEFUN |term1RWall| (|t| R)
  (PROG (|vars| |varRules| SL)
    (RETURN
     (PROGN
      (SETQ |vars| (CAR R))
      (SETQ |varRules| (CDR R))
      ((LAMBDA (|bfVar#4| |bfVar#3| |r|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#3|) (PROGN (SETQ |r| (CAR |bfVar#3|)) NIL))
            (RETURN (NREVERSE |bfVar#4|)))
           ('T
            (AND
             (NULL
              (EQ (SETQ SL (|termMatch| (CAR |r|) |t| NIL |vars|)) '|failed|))
             (SETQ |bfVar#4|
                     (CONS
                      (AND (NULL (EQ SL '|failed|))
                           (|subCopy| (COPY (CDR |r|)) SL))
                      |bfVar#4|)))))
          (SETQ |bfVar#3| (CDR |bfVar#3|))))
       NIL |varRules| NIL)))))

; termMatch(tp,t,SL,vars) ==
;   -- t is a term pattern, t a term
;   -- then the result is the augmented substitution SL or 'failed
;   tp=t => SL
;   atom tp =>
;     MEMQ(tp,vars) =>
;       p := assoc(tp, SL) => (rest p = t)
;       CONS(CONS(tp,t),SL)
;     'failed
;   atom t => 'failed
;   [tp1,:tp2]:= tp
;   [t1,:t2]:= t
;   SL:= termMatch(tp1,t1,SL,vars)
;   SL='failed => 'failed
;   tp2 and t2 => termMatch(tp2,t2,SL,vars)
;   tp2 or t2 => 'failed
;   SL

(DEFUN |termMatch| (|tp| |t| SL |vars|)
  (PROG (|p| |tp1| |tp2| |t1| |t2|)
    (RETURN
     (COND ((EQUAL |tp| |t|) SL)
           ((ATOM |tp|)
            (COND
             ((MEMQ |tp| |vars|)
              (COND ((SETQ |p| (|assoc| |tp| SL)) (EQUAL (CDR |p|) |t|))
                    (#1='T (CONS (CONS |tp| |t|) SL))))
             (#1# '|failed|)))
           ((ATOM |t|) '|failed|)
           (#1#
            (PROGN
             (SETQ |tp1| (CAR |tp|))
             (SETQ |tp2| (CDR |tp|))
             (SETQ |t1| (CAR |t|))
             (SETQ |t2| (CDR |t|))
             (SETQ SL (|termMatch| |tp1| |t1| SL |vars|))
             (COND ((EQ SL '|failed|) '|failed|)
                   ((AND |tp2| |t2|) (|termMatch| |tp2| |t2| SL |vars|))
                   ((OR |tp2| |t2|) '|failed|) (#1# SL))))))))

; augmentSub(v,t,SL) ==
;   -- destructively adds the pair (v,t) to the substitution list SL
;   -- t doesn't contain any of the variables of SL
;   q:= CONS(v,t)
;   null SL => [q]
; --  for p in SL repeat RPLACD(p, SUBSTQ(t, v, rest p))
;   CONS(q,SL)

(DEFUN |augmentSub| (|v| |t| SL)
  (PROG (|q|)
    (RETURN
     (PROGN
      (SETQ |q| (CONS |v| |t|))
      (COND ((NULL SL) (LIST |q|)) ('T (CONS |q| SL)))))))

; mergeSubs(S1,S2) ==
;   -- augments S2 by each pair of S1
;   -- S1 doesn't contain any of the variables of S2
;   null S1 => S2
;   null S2 => S1
;   S3 := [p for p in S2 | not ASSQ(first p, S1)]
; --  for p in S1 repeat S3 := augmentSub(first p, rest p, S3)
;   APPEND(S1,S3)

(DEFUN |mergeSubs| (S1 S2)
  (PROG (S3)
    (RETURN
     (COND ((NULL S1) S2) ((NULL S2) S1)
           (#1='T
            (PROGN
             (SETQ S3
                     ((LAMBDA (|bfVar#6| |bfVar#5| |p|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#5|)
                               (PROGN (SETQ |p| (CAR |bfVar#5|)) NIL))
                           (RETURN (NREVERSE |bfVar#6|)))
                          (#1#
                           (AND (NULL (ASSQ (CAR |p|) S1))
                                (SETQ |bfVar#6| (CONS |p| |bfVar#6|)))))
                         (SETQ |bfVar#5| (CDR |bfVar#5|))))
                      NIL S2 NIL))
             (APPEND S1 S3)))))))

; subCopy(t,SL) ==
;   -- t is any LISP structure, SL a substitution list for sharp variables
;   -- then t is substituted and copied if necessary
;   SL=NIL => t
;   subCopy0(t,SL)

(DEFUN |subCopy| (|t| SL)
  (PROG () (RETURN (COND ((NULL SL) |t|) ('T (|subCopy0| |t| SL))))))

; subCopy0(t, SL) ==
;   p := subCopyOrNil(t, SL) => rest p
;   t

(DEFUN |subCopy0| (|t| SL)
  (PROG (|p|)
    (RETURN (COND ((SETQ |p| (|subCopyOrNil| |t| SL)) (CDR |p|)) ('T |t|)))))

; subCopyOrNil(t,SL) ==
;   -- the same as subCopy, but the result is NIL if nothing was copied
;   p:= assoc(t,SL) => p
;   atom t => NIL
;   [t1,:t2]:= t
;   t0:= subCopyOrNil(t1,SL) =>
;     t2 => CONS(t, CONS(rest t0, subCopy0(t2, SL)))
;     CONS(t, CONS(rest t0, t2))
;   t2 and (t0 := subCopyOrNil(t2, SL)) => CONS(t, CONS(t1, rest t0))
;   NIL

(DEFUN |subCopyOrNil| (|t| SL)
  (PROG (|p| |t1| |t2| |t0|)
    (RETURN
     (COND ((SETQ |p| (|assoc| |t| SL)) |p|) ((ATOM |t|) NIL)
           (#1='T
            (PROGN
             (SETQ |t1| (CAR |t|))
             (SETQ |t2| (CDR |t|))
             (COND
              ((SETQ |t0| (|subCopyOrNil| |t1| SL))
               (COND (|t2| (CONS |t| (CONS (CDR |t0|) (|subCopy0| |t2| SL))))
                     (#1# (CONS |t| (CONS (CDR |t0|) |t2|)))))
              ((AND |t2| (SETQ |t0| (|subCopyOrNil| |t2| SL)))
               (CONS |t| (CONS |t1| (CDR |t0|))))
              (#1# NIL))))))))

; deepSubCopy(t,SL) ==
;   -- t is any LISP structure, SL a substitution list for sharp variables
;   -- then t is substituted and copied if necessary
;   SL=NIL => t
;   deepSubCopy0(t,SL)

(DEFUN |deepSubCopy| (|t| SL)
  (PROG () (RETURN (COND ((NULL SL) |t|) ('T (|deepSubCopy0| |t| SL))))))

; deepSubCopy0(t, SL) ==
;   p := deepSubCopyOrNil(t, SL) => rest p
;   t

(DEFUN |deepSubCopy0| (|t| SL)
  (PROG (|p|)
    (RETURN
     (COND ((SETQ |p| (|deepSubCopyOrNil| |t| SL)) (CDR |p|)) ('T |t|)))))

; deepSubCopyOrNil(t,SL) ==
;   -- the same as subCopy, but the result is NIL if nothing was copied
;   p := assoc(t, SL) => CONS(t, deepSubCopy0(rest p, SL))
;   atom t => NIL
;   [t1,:t2]:= t
;   t0:= deepSubCopyOrNil(t1,SL) =>
;     t2 => CONS(t, CONS(rest t0, deepSubCopy0(t2, SL)))
;     CONS(t, CONS(rest t0, t2))
;   t2 and (t0 := deepSubCopyOrNil(t2, SL)) => CONS(t, CONS(t1, rest t0))

(DEFUN |deepSubCopyOrNil| (|t| SL)
  (PROG (|p| |t1| |t2| |t0|)
    (RETURN
     (COND
      ((SETQ |p| (|assoc| |t| SL)) (CONS |t| (|deepSubCopy0| (CDR |p|) SL)))
      ((ATOM |t|) NIL)
      (#1='T
       (PROGN
        (SETQ |t1| (CAR |t|))
        (SETQ |t2| (CDR |t|))
        (COND
         ((SETQ |t0| (|deepSubCopyOrNil| |t1| SL))
          (COND (|t2| (CONS |t| (CONS (CDR |t0|) (|deepSubCopy0| |t2| SL))))
                (#1# (CONS |t| (CONS (CDR |t0|) |t2|)))))
         ((AND |t2| (SETQ |t0| (|deepSubCopyOrNil| |t2| SL)))
          (CONS |t| (CONS |t1| (CDR |t0|)))))))))))


; )package "BOOT"

(IN-PACKAGE "BOOT")

; isSharpVar x ==
;   IDENTP x and SCHAR(SYMBOL_-NAME x,0) = char "#"

(DEFUN |isSharpVar| (|x|)
  (PROG ()
    (RETURN
     (AND (IDENTP |x|) (EQUAL (SCHAR (SYMBOL-NAME |x|) 0) (|char| '|#|))))))

; isSharpVarWithNum x ==
;   null isSharpVar x => nil
;   (n := QCSIZE(p := PNAME x)) < 2 => nil
;   ok := true
;   c := 0
;   for i in 1..(n-1) while ok repeat
;     d := ELT(p,i)
;     ok := DIGITP d => c := 10*c + DIG2FIX d
;   if ok then c else nil

(DEFUN |isSharpVarWithNum| (|x|)
  (PROG (|p| |n| |ok| |c| |d|)
    (RETURN
     (COND ((NULL (|isSharpVar| |x|)) NIL)
           ((< (SETQ |n| (QCSIZE (SETQ |p| (PNAME |x|)))) 2) NIL)
           (#1='T
            (PROGN
             (SETQ |ok| T)
             (SETQ |c| 0)
             ((LAMBDA (|bfVar#1| |i|)
                (LOOP
                 (COND ((OR (> |i| |bfVar#1|) (NOT |ok|)) (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |d| (ELT |p| |i|))
                         (COND
                          ((SETQ |ok| (DIGITP |d|))
                           (SETQ |c| (+ (* 10 |c|) (DIG2FIX |d|))))))))
                 (SETQ |i| (+ |i| 1))))
              (- |n| 1) 1)
             (COND (|ok| |c|) (#1# NIL))))))))

; rread(key, rstream) ==
;   if IDENTP key then key := PNAME key
;   rread0(key, rstream)

(DEFUN |rread| (|key| |rstream|)
  (PROG ()
    (RETURN
     (PROGN
      (COND ((IDENTP |key|) (SETQ |key| (PNAME |key|))))
      (|rread0| |key| |rstream|)))))

; rread_list(key, rstream) ==
;     if IDENTP key then key := PNAME key
;     rread1(key, rstream, [])

(DEFUN |rread_list| (|key| |rstream|)
  (PROG ()
    (RETURN
     (PROGN
      (COND ((IDENTP |key|) (SETQ |key| (PNAME |key|))))
      (|rread1| |key| |rstream| NIL)))))

; rwrite(key,val,stream) ==
;   if IDENTP key then key := PNAME key
;   rwrite0(key,val,stream)

(DEFUN |rwrite| (|key| |val| |stream|)
  (PROG ()
    (RETURN
     (PROGN
      (COND ((IDENTP |key|) (SETQ |key| (PNAME |key|))))
      (|rwrite0| |key| |val| |stream|)))))

; editFile file ==
;   MEMQ(INTERN('"WIN32",FIND_-PACKAGE("KEYWORD")),_*FEATURES_*) =>
;     OBEY STRCONC('"notepad ", namestring pathname file)
;   OBEY STRCONC('"$FRICAS/lib/SPADEDIT ",namestring pathname file)

(DEFUN |editFile| (|file|)
  (PROG ()
    (RETURN
     (COND
      ((MEMQ (INTERN "WIN32" (FIND-PACKAGE 'KEYWORD)) *FEATURES*)
       (OBEY (STRCONC "notepad " (|namestring| (|pathname| |file|)))))
      ('T
       (OBEY
        (STRCONC "$FRICAS/lib/SPADEDIT "
         (|namestring| (|pathname| |file|)))))))))

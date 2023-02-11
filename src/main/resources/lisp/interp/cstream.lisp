
; )package "BOOT"

(IN-PACKAGE "BOOT")

; npNull x== StreamNull x

(DEFUN |npNull| (|x|) (PROG () (RETURN (|StreamNull| |x|))))

; StreamExplicitlyNull(x) ==
;     null x or EQCAR (x, "nullstream") => true
;     false

(DEFUN |StreamExplicitlyNull| (|x|)
  (PROG ()
    (RETURN (COND ((OR (NULL |x|) (EQCAR |x| '|nullstream|)) T) ('T NIL)))))

; StreamNull x==
;   StreamExplicitlyNull(x) => true
;   while EQCAR(x,"nonnullstream") repeat
;           st:=APPLY(CADR x,CDDR x)
;           RPLACA(x, first st)
;           RPLACD(x, rest st)
;   EQCAR(x,"nullstream")

(DEFUN |StreamNull| (|x|)
  (PROG (|st|)
    (RETURN
     (COND ((|StreamExplicitlyNull| |x|) T)
           (#1='T
            (PROGN
             ((LAMBDA ()
                (LOOP
                 (COND ((NOT (EQCAR |x| '|nonnullstream|)) (RETURN NIL))
                       (#1#
                        (PROGN
                         (SETQ |st| (APPLY (CADR |x|) (CDDR |x|)))
                         (RPLACA |x| (CAR |st|))
                         (RPLACD |x| (CDR |st|))))))))
             (EQCAR |x| '|nullstream|)))))))

; Delay(f,x)==cons("nonnullstream",[f,:x])

(DEFUN |Delay| (|f| |x|)
  (PROG () (RETURN (CONS '|nonnullstream| (CONS |f| |x|)))))

; StreamNil:= ["nullstream"]

(EVAL-WHEN (EVAL LOAD) (SETQ |StreamNil| (LIST '|nullstream|)))

; incRgen s==Delay(function incRgen1,[s])

(DEFUN |incRgen| (|s|) (PROG () (RETURN (|Delay| #'|incRgen1| (LIST |s|)))))

; incRgen1(:z)==
;         [s]:=z
;         a := READ_-LINE(s, nil, nil)
;         if NULL a
;         then (CLOSE s;StreamNil)
;
;         else cons(a,incRgen s)

(DEFUN |incRgen1| (&REST |z|)
  (PROG (|s| |a|)
    (RETURN
     (PROGN
      (SETQ |s| (CAR |z|))
      (SETQ |a| (READ-LINE |s| NIL NIL))
      (COND ((NULL |a|) (CLOSE |s|) |StreamNil|)
            ('T (CONS |a| (|incRgen| |s|))))))))

; incIgen n==Delay(function incIgen1,[n])

(DEFUN |incIgen| (|n|) (PROG () (RETURN (|Delay| #'|incIgen1| (LIST |n|)))))

; incIgen1(:z)==
;         [n]:=z
;         n:=n+1
;         cons(n,incIgen n)

(DEFUN |incIgen1| (&REST |z|)
  (PROG (|n|)
    (RETURN
     (PROGN
      (SETQ |n| (CAR |z|))
      (SETQ |n| (+ |n| 1))
      (CONS |n| (|incIgen| |n|))))))

; incZip(g,f1,f2)==Delay(function incZip1,[g,f1,f2])

(DEFUN |incZip| (|g| |f1| |f2|)
  (PROG () (RETURN (|Delay| #'|incZip1| (LIST |g| |f1| |f2|)))))

; incZip1(:z)==
;      [g,f1,f2]:=z
;      StreamNull f1 => StreamNil
;      StreamNull f2 => StreamNil
;      cons(FUNCALL(g,car f1,car f2),incZip(g,cdr f1,cdr f2))

(DEFUN |incZip1| (&REST |z|)
  (PROG (|g| |f1| |f2|)
    (RETURN
     (PROGN
      (SETQ |g| (CAR |z|))
      (SETQ |f1| (CADR . #1=(|z|)))
      (SETQ |f2| (CADDR . #1#))
      (COND ((|StreamNull| |f1|) |StreamNil|) ((|StreamNull| |f2|) |StreamNil|)
            ('T
             (CONS (FUNCALL |g| (CAR |f1|) (CAR |f2|))
                   (|incZip| |g| (CDR |f1|) (CDR |f2|)))))))))

; incAppend(x, y) ==
;     StreamExplicitlyNull(x) => y
;     Delay(function incAppend1,[x,y])

(DEFUN |incAppend| (|x| |y|)
  (PROG ()
    (RETURN
     (COND ((|StreamExplicitlyNull| |x|) |y|)
           ('T (|Delay| #'|incAppend1| (LIST |x| |y|)))))))

; incAppend1(:z)==
;      [x,y]:=z
;      if StreamNull x
;      then if StreamNull y
;           then StreamNil
;           else y
;      else cons(car x,incAppend(cdr x,y))

(DEFUN |incAppend1| (&REST |z|)
  (PROG (|x| |y|)
    (RETURN
     (PROGN
      (SETQ |x| (CAR |z|))
      (SETQ |y| (CADR |z|))
      (COND
       ((|StreamNull| |x|) (COND ((|StreamNull| |y|) |StreamNil|) (#1='T |y|)))
       (#1# (CONS (CAR |x|) (|incAppend| (CDR |x|) |y|))))))))

; next(f,s)==Delay(function next1,[f,s])

(DEFUN |next| (|f| |s|) (PROG () (RETURN (|Delay| #'|next1| (LIST |f| |s|)))))

; next1(:z)==
;       [f,s]:=z
;       StreamNull s=> StreamNil
;       h:= APPLY(f, [s])
;       incAppend(car h,next(f,cdr h))

(DEFUN |next1| (&REST |z|)
  (PROG (|f| |s| |h|)
    (RETURN
     (PROGN
      (SETQ |f| (CAR |z|))
      (SETQ |s| (CADR |z|))
      (COND ((|StreamNull| |s|) |StreamNil|)
            ('T
             (PROGN
              (SETQ |h| (APPLY |f| (LIST |s|)))
              (|incAppend| (CAR |h|) (|next| |f| (CDR |h|))))))))))

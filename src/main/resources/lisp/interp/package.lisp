
; )package "BOOT"

(IN-PACKAGE "BOOT")

; mkList u ==
;   u => ["LIST",:u]
;   nil

(DEFUN |mkList| (|u|) (PROG () (RETURN (COND (|u| (CONS 'LIST |u|)) ('T NIL)))))

; mkOperatorEntry(opSig is [op,sig,:flag],pred,count) ==
;   null flag => [opSig,pred,["ELT","$",count]]
;   first flag="constant" => [[op,sig],pred,["CONST","$",count]]
;   systemError ["unknown variable mode: ",flag]

(DEFUN |mkOperatorEntry| (|opSig| |pred| |count|)
  (PROG (|op| |sig| |flag|)
    (RETURN
     (PROGN
      (SETQ |op| (CAR |opSig|))
      (SETQ |sig| (CADR . #1=(|opSig|)))
      (SETQ |flag| (CDDR . #1#))
      (COND ((NULL |flag|) (LIST |opSig| |pred| (LIST 'ELT '$ |count|)))
            ((EQ (CAR |flag|) '|constant|)
             (LIST (LIST |op| |sig|) |pred| (LIST 'CONST '$ |count|)))
            ('T (|systemError| (LIST '|unknown variable mode: | |flag|))))))))

; encodeFunctionName(fun,package is [packageName,:arglist],signature,sep,count)
;    ==
;     signature':= substitute("$",package,signature)
;     reducedSig:= mkRepititionAssoc [:rest signature',first signature']
;     encodedSig:=
;       ("STRCONC"/[encodedPair for [n,:x] in reducedSig]) where
;         encodedPair() ==
;           n=1 => encodeItem x
;           STRCONC(STRINGIMAGE n,encodeItem x)
;     encodedName := INTERN(CONCAT(getAbbreviation(packageName, #arglist), ";",
;         encodeItem(fun), ";", encodedSig, sep, STRINGIMAGE(count)))
;     encodedName

(DEFUN |encodeFunctionName| (|fun| |package| |signature| |sep| |count|)
  (PROG (|packageName| |arglist| |signature'| |reducedSig| |n| |x| |encodedSig|
         |encodedName|)
    (RETURN
     (PROGN
      (SETQ |packageName| (CAR |package|))
      (SETQ |arglist| (CDR |package|))
      (SETQ |signature'| (|substitute| '$ |package| |signature|))
      (SETQ |reducedSig|
              (|mkRepititionAssoc|
               (APPEND (CDR |signature'|) (CONS (CAR |signature'|) NIL))))
      (SETQ |encodedSig|
              ((LAMBDA (|bfVar#3| |bfVar#2| |bfVar#1|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#2|)
                        (PROGN (SETQ |bfVar#1| (CAR |bfVar#2|)) NIL))
                    (RETURN |bfVar#3|))
                   (#1='T
                    (AND (CONSP |bfVar#1|)
                         (PROGN
                          (SETQ |n| (CAR |bfVar#1|))
                          (SETQ |x| (CDR |bfVar#1|))
                          #1#)
                         (SETQ |bfVar#3|
                                 (STRCONC |bfVar#3|
                                  (COND ((EQL |n| 1) (|encodeItem| |x|))
                                        (#1#
                                         (STRCONC (STRINGIMAGE |n|)
                                          (|encodeItem| |x|)))))))))
                  (SETQ |bfVar#2| (CDR |bfVar#2|))))
               "" |reducedSig| NIL))
      (SETQ |encodedName|
              (INTERN
               (CONCAT (|getAbbreviation| |packageName| (LENGTH |arglist|))
                       '|;| (|encodeItem| |fun|) '|;| |encodedSig| |sep|
                       (STRINGIMAGE |count|))))
      |encodedName|))))

; mkRepititionAssoc l ==
;   mkRepfun(l,1) where
;     mkRepfun(l,n) ==
;       null l => nil
;       l is [x] => [[n,:x]]
;       l is [x, =x,:l'] => mkRepfun(rest l,n+1)
;       [[n,:first l],:mkRepfun(rest l,1)]

(DEFUN |mkRepititionAssoc| (|l|)
  (PROG () (RETURN (|mkRepititionAssoc,mkRepfun| |l| 1))))
(DEFUN |mkRepititionAssoc,mkRepfun| (|l| |n|)
  (PROG (|x| |ISTMP#1| |l'|)
    (RETURN
     (COND ((NULL |l|) NIL)
           ((AND (CONSP |l|) (EQ (CDR |l|) NIL)
                 (PROGN (SETQ |x| (CAR |l|)) #1='T))
            (LIST (CONS |n| |x|)))
           ((AND (CONSP |l|)
                 (PROGN
                  (SETQ |x| (CAR |l|))
                  (SETQ |ISTMP#1| (CDR |l|))
                  (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) |x|)
                       (PROGN (SETQ |l'| (CDR |ISTMP#1|)) #1#))))
            (|mkRepititionAssoc,mkRepfun| (CDR |l|) (+ |n| 1)))
           (#1#
            (CONS (CONS |n| (CAR |l|))
                  (|mkRepititionAssoc,mkRepfun| (CDR |l|) 1)))))))

; encodeItem x ==
;   x is [op,:argl] => getCaps op
;   IDENTP x => PNAME x
;   STRINGIMAGE x

(DEFUN |encodeItem| (|x|)
  (PROG (|op| |argl|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN (SETQ |op| (CAR |x|)) (SETQ |argl| (CDR |x|)) #1='T))
       (|getCaps| |op|))
      ((IDENTP |x|) (PNAME |x|)) (#1# (STRINGIMAGE |x|))))))

; getCaps x ==
;   s:= STRINGIMAGE x
;   clist:= [c for i in 0..MAXINDEX s | UPPER_-CASE_-P (c:= s.i)]
;   null clist => '"__"
;   "STRCONC"/[first clist,:[DOWNCASE u for u in rest clist]]

(DEFUN |getCaps| (|x|)
  (PROG (|s| |c| |clist|)
    (RETURN
     (PROGN
      (SETQ |s| (STRINGIMAGE |x|))
      (SETQ |clist|
              ((LAMBDA (|bfVar#5| |bfVar#4| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#4|) (RETURN (NREVERSE |bfVar#5|)))
                        (#1='T
                         (AND (UPPER-CASE-P (SETQ |c| (ELT |s| |i|)))
                              (SETQ |bfVar#5| (CONS |c| |bfVar#5|)))))
                  (SETQ |i| (+ |i| 1))))
               NIL (MAXINDEX |s|) 0))
      (COND ((NULL |clist|) "_")
            (#1#
             ((LAMBDA (|bfVar#8| |bfVar#10| |bfVar#9|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#10|)
                       (PROGN (SETQ |bfVar#9| (CAR |bfVar#10|)) NIL))
                   (RETURN |bfVar#8|))
                  (#1# (SETQ |bfVar#8| (STRCONC |bfVar#8| |bfVar#9|))))
                 (SETQ |bfVar#10| (CDR |bfVar#10|))))
              ""
              (CONS (CAR |clist|)
                    ((LAMBDA (|bfVar#7| |bfVar#6| |u|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#6|)
                              (PROGN (SETQ |u| (CAR |bfVar#6|)) NIL))
                          (RETURN (NREVERSE |bfVar#7|)))
                         (#1#
                          (SETQ |bfVar#7| (CONS (DOWNCASE |u|) |bfVar#7|))))
                        (SETQ |bfVar#6| (CDR |bfVar#6|))))
                     NIL (CDR |clist|) NIL))
              NIL)))))))

; DEFPARAMETER($abbreviationTable, '())

(DEFPARAMETER |$abbreviationTable| 'NIL)

; getAbbreviation(name,c) ==
;   --returns abbreviation of name with c arguments
;   x := constructor? name
;   X := ASSQ(x,$abbreviationTable) =>
;     N:= ASSQ(name,rest X) =>
;       C:= ASSQ(c,rest N) => rest C --already there
;       newAbbreviation:= mkAbbrev(X,x)
;       rplac(rest N, [[c, :newAbbreviation], :rest N])
;       newAbbreviation
;     newAbbreviation:= mkAbbrev(X,x)
;     rplac(rest X, [[name, [c, :newAbbreviation]], :rest X])
;     newAbbreviation
;   $abbreviationTable:= [[x,[name,[c,:x]]],:$abbreviationTable]
;   x

(DEFUN |getAbbreviation| (|name| |c|)
  (PROG (|x| X N C |newAbbreviation|)
    (RETURN
     (PROGN
      (SETQ |x| (|constructor?| |name|))
      (COND
       ((SETQ X (ASSQ |x| |$abbreviationTable|))
        (COND
         ((SETQ N (ASSQ |name| (CDR X)))
          (COND ((SETQ C (ASSQ |c| (CDR N))) (CDR C))
                (#1='T
                 (PROGN
                  (SETQ |newAbbreviation| (|mkAbbrev| X |x|))
                  (|rplac| (CDR N) (CONS (CONS |c| |newAbbreviation|) (CDR N)))
                  |newAbbreviation|))))
         (#1#
          (PROGN
           (SETQ |newAbbreviation| (|mkAbbrev| X |x|))
           (|rplac| (CDR X)
            (CONS (LIST |name| (CONS |c| |newAbbreviation|)) (CDR X)))
           |newAbbreviation|))))
       (#1#
        (PROGN
         (SETQ |$abbreviationTable|
                 (CONS (LIST |x| (LIST |name| (CONS |c| |x|)))
                       |$abbreviationTable|))
         |x|)))))))

; mkAbbrev(X,x) == addSuffix(alistSize rest X,x)

(DEFUN |mkAbbrev| (X |x|)
  (PROG () (RETURN (|addSuffix| (|alistSize| (CDR X)) |x|))))

; alistSize c ==
;   count(c,1) where
;     count(x,level) ==
;       level=2 => #x
;       null x => 0
;       count(CDAR x,level+1)+count(rest x,level)

(DEFUN |alistSize| (|c|) (PROG () (RETURN (|alistSize,count| |c| 1))))
(DEFUN |alistSize,count| (|x| |level|)
  (PROG ()
    (RETURN
     (COND ((EQL |level| 2) (LENGTH |x|)) ((NULL |x|) 0)
           ('T
            (+ (|alistSize,count| (CDAR |x|) (+ |level| 1))
               (|alistSize,count| (CDR |x|) |level|)))))))

; addSuffix(n,u) ==
;   ALPHA_-CHAR_-P((s := STRINGIMAGE u).(MAXINDEX s)) =>
;       INTERNL1(s, STRINGIMAGE(n))
;   INTERN(CONCAT(s, '";", STRINGIMAGE(n)))

(DEFUN |addSuffix| (|n| |u|)
  (PROG (|s|)
    (RETURN
     (COND
      ((ALPHA-CHAR-P (ELT (SETQ |s| (STRINGIMAGE |u|)) (MAXINDEX |s|)))
       (INTERNL1 |s| (STRINGIMAGE |n|)))
      ('T (INTERN (CONCAT |s| ";" (STRINGIMAGE |n|))))))))

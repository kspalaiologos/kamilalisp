
; )package "BOOT"

(IN-PACKAGE "BOOT")

; simpBool x == dnf_to_pf reduceDnf b_to_dnf x

(DEFUN |simpBool| (|x|)
  (PROG () (RETURN (|dnf_to_pf| (|reduceDnf| (|b_to_dnf| |x|))))))

; reduceDnf u ==
; -- (OR (AND ..b..) b) ==> (OR  b  )
;   atom u => u
;   for x in u repeat
;     ok := true
;     for y in u repeat
;       x = y => 'skip
;       dnfContains(x,y) => return (ok := false)
;     ok = true => acc := [x,:acc]
;   NREVERSE acc

(DEFUN |reduceDnf| (|u|)
  (PROG (|ok| |acc|)
    (RETURN
     (COND ((ATOM |u|) |u|)
           (#1='T
            (PROGN
             ((LAMBDA (|bfVar#1| |x|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#1|) (PROGN (SETQ |x| (CAR |bfVar#1|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (PROGN
                    (SETQ |ok| T)
                    ((LAMBDA (|bfVar#2| |y|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#2|)
                              (PROGN (SETQ |y| (CAR |bfVar#2|)) NIL))
                          (RETURN NIL))
                         (#1#
                          (COND ((EQUAL |x| |y|) '|skip|)
                                ((|dnfContains| |x| |y|)
                                 (RETURN (SETQ |ok| NIL))))))
                        (SETQ |bfVar#2| (CDR |bfVar#2|))))
                     |u| NIL)
                    (COND ((EQUAL |ok| T) (SETQ |acc| (CONS |x| |acc|)))))))
                 (SETQ |bfVar#1| (CDR |bfVar#1|))))
              |u| NIL)
             (NREVERSE |acc|)))))))

; dnfContains([a,b],[c,d]) == fn(a,c) and fn(b,d) where
;   fn(x,y) == and/[member(u,x) for u in y]

(DEFUN |dnfContains| (|bfVar#5| |bfVar#6|)
  (PROG (|c| |d| |a| |b|)
    (RETURN
     (PROGN
      (SETQ |c| (CAR |bfVar#6|))
      (SETQ |d| (CADR |bfVar#6|))
      (SETQ |a| (CAR |bfVar#5|))
      (SETQ |b| (CADR |bfVar#5|))
      (AND (|dnfContains,fn| |a| |c|) (|dnfContains,fn| |b| |d|))))))
(DEFUN |dnfContains,fn| (|x| |y|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#4| |bfVar#3| |u|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#3|) (PROGN (SETQ |u| (CAR |bfVar#3|)) NIL))
           (RETURN |bfVar#4|))
          ('T
           (PROGN
            (SETQ |bfVar#4| (|member| |u| |x|))
            (COND ((NOT |bfVar#4|) (RETURN NIL))))))
         (SETQ |bfVar#3| (CDR |bfVar#3|))))
      T |y| NIL))))

; dnf_to_pf(x) ==
;   x = 'true => 'T
;   x = 'false => nil
;   atom x => x
;   MKPF(
;     [MKPF([:[k for k in b],:[['not,k] for k in a]],'AND) for [a,b] in x],'OR)

(DEFUN |dnf_to_pf| (|x|)
  (PROG (|a| |ISTMP#1| |b|)
    (RETURN
     (COND ((EQ |x| '|true|) 'T) ((EQ |x| '|false|) NIL) ((ATOM |x|) |x|)
           (#1='T
            (MKPF
             ((LAMBDA (|bfVar#13| |bfVar#12| |bfVar#11|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#12|)
                       (PROGN (SETQ |bfVar#11| (CAR |bfVar#12|)) NIL))
                   (RETURN (NREVERSE |bfVar#13|)))
                  (#1#
                   (AND (CONSP |bfVar#11|)
                        (PROGN
                         (SETQ |a| (CAR |bfVar#11|))
                         (SETQ |ISTMP#1| (CDR |bfVar#11|))
                         (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                              (PROGN (SETQ |b| (CAR |ISTMP#1|)) #1#)))
                        (SETQ |bfVar#13|
                                (CONS
                                 (MKPF
                                  (APPEND
                                   ((LAMBDA (|bfVar#8| |bfVar#7| |k|)
                                      (LOOP
                                       (COND
                                        ((OR (ATOM |bfVar#7|)
                                             (PROGN
                                              (SETQ |k| (CAR |bfVar#7|))
                                              NIL))
                                         (RETURN (NREVERSE |bfVar#8|)))
                                        (#1#
                                         (SETQ |bfVar#8|
                                                 (CONS |k| |bfVar#8|))))
                                       (SETQ |bfVar#7| (CDR |bfVar#7|))))
                                    NIL |b| NIL)
                                   ((LAMBDA (|bfVar#10| |bfVar#9| |k|)
                                      (LOOP
                                       (COND
                                        ((OR (ATOM |bfVar#9|)
                                             (PROGN
                                              (SETQ |k| (CAR |bfVar#9|))
                                              NIL))
                                         (RETURN (NREVERSE |bfVar#10|)))
                                        (#1#
                                         (SETQ |bfVar#10|
                                                 (CONS (LIST '|not| |k|)
                                                       |bfVar#10|))))
                                       (SETQ |bfVar#9| (CDR |bfVar#9|))))
                                    NIL |a| NIL))
                                  'AND)
                                 |bfVar#13|)))))
                 (SETQ |bfVar#12| (CDR |bfVar#12|))))
              NIL |x| NIL)
             'OR))))))

; b_to_dnf x ==
;   x = 'T => 'true
;   x = NIL => 'false
;   atom x => bassert x
;   [op,:argl] := x
;   MEMQ(op,'(AND and)) => band argl
;   MEMQ(op,'(OR or))   => bor argl
;   MEMQ(op,'(NOT not)) => bnot first argl
;   bassert x

(DEFUN |b_to_dnf| (|x|)
  (PROG (|op| |argl|)
    (RETURN
     (COND ((EQ |x| 'T) '|true|) ((NULL |x|) '|false|)
           ((ATOM |x|) (|bassert| |x|))
           (#1='T
            (PROGN
             (SETQ |op| (CAR |x|))
             (SETQ |argl| (CDR |x|))
             (COND ((MEMQ |op| '(AND |and|)) (|band| |argl|))
                   ((MEMQ |op| '(OR |or|)) (|bor| |argl|))
                   ((MEMQ |op| '(NOT |not|)) (|bnot| (CAR |argl|)))
                   (#1# (|bassert| |x|)))))))))

; band x ==
;   x is [h, :t] => andDnf(b_to_dnf h, band t)
;   'true

(DEFUN |band| (|x|)
  (PROG (|h| |t|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN (SETQ |h| (CAR |x|)) (SETQ |t| (CDR |x|)) #1='T))
       (|andDnf| (|b_to_dnf| |h|) (|band| |t|)))
      (#1# '|true|)))))

; bor x ==
;   x is [a, :b] => orDnf(b_to_dnf a, bor b)
;   'false

(DEFUN |bor| (|x|)
  (PROG (|a| |b|)
    (RETURN
     (COND
      ((AND (CONSP |x|)
            (PROGN (SETQ |a| (CAR |x|)) (SETQ |b| (CDR |x|)) #1='T))
       (|orDnf| (|b_to_dnf| |a|) (|bor| |b|)))
      (#1# '|false|)))))

; bnot x == notDnf b_to_dnf x

(DEFUN |bnot| (|x|) (PROG () (RETURN (|notDnf| (|b_to_dnf| |x|)))))

; bassert x == [[nil,[x]]]

(DEFUN |bassert| (|x|) (PROG () (RETURN (LIST (LIST NIL (LIST |x|))))))

; bassertNot x == [[[x],nil]]

(DEFUN |bassertNot| (|x|) (PROG () (RETURN (LIST (LIST (LIST |x|) NIL)))))

; orDnf(a,b) ==                   -- or:  (dnf, dnf) -> dnf
;   a = 'false => b
;   b = 'false => a
;   a = 'true or b = 'true => 'true
;   null a => b     --null list means false
;   a is [c] = coafOrDnf(c,b)
;   coafOrDnf(first a,orDnf(rest a,b))

(DEFUN |orDnf| (|a| |b|)
  (PROG (|c|)
    (RETURN
     (COND ((EQ |a| '|false|) |b|) ((EQ |b| '|false|) |a|)
           ((OR (EQ |a| '|true|) (EQ |b| '|true|)) '|true|) ((NULL |a|) |b|)
           (#1='T
            (PROGN
             (EQUAL
              (AND (CONSP |a|) (EQ (CDR |a|) NIL)
                   (PROGN (SETQ |c| (CAR |a|)) #1#))
              (|coafOrDnf| |c| |b|))
             (|coafOrDnf| (CAR |a|) (|orDnf| (CDR |a|) |b|))))))))

; andDnf(a,b) ==                  -- and: (dnf, dnf) -> dnf
;   a = 'true => b
;   b = 'true => a
;   a = 'false or b = 'false => 'false
;   null a => 'false  --null list means false
;   a is [c] => coafAndDnf(c,b)
;   x := coafAndDnf(first a,b)
;   y := andDnf(rest a,b)
;   x = 'false => y
;   y = 'false => x
;   ordUnion(x,y)

(DEFUN |andDnf| (|a| |b|)
  (PROG (|c| |x| |y|)
    (RETURN
     (COND ((EQ |a| '|true|) |b|) ((EQ |b| '|true|) |a|)
           ((OR (EQ |a| '|false|) (EQ |b| '|false|)) '|false|)
           ((NULL |a|) '|false|)
           ((AND (CONSP |a|) (EQ (CDR |a|) NIL)
                 (PROGN (SETQ |c| (CAR |a|)) #1='T))
            (|coafAndDnf| |c| |b|))
           (#1#
            (PROGN
             (SETQ |x| (|coafAndDnf| (CAR |a|) |b|))
             (SETQ |y| (|andDnf| (CDR |a|) |b|))
             (COND ((EQ |x| '|false|) |y|) ((EQ |y| '|false|) |x|)
                   (#1# (|ordUnion| |x| |y|)))))))))

; notDnf l ==                     -- not: dnf  ->  dnf
;   l = 'true => 'false
;   l = 'false => 'true
;   null l =>     'true --null list means false
;   l is [x] => notCoaf x
;   andDnf(notCoaf first l,notDnf rest l)

(DEFUN |notDnf| (|l|)
  (PROG (|x|)
    (RETURN
     (COND ((EQ |l| '|true|) '|false|) ((EQ |l| '|false|) '|true|)
           ((NULL |l|) '|true|)
           ((AND (CONSP |l|) (EQ (CDR |l|) NIL)
                 (PROGN (SETQ |x| (CAR |l|)) #1='T))
            (|notCoaf| |x|))
           (#1# (|andDnf| (|notCoaf| (CAR |l|)) (|notDnf| (CDR |l|))))))))

; coafOrDnf(a,l) ==               -- or:  (coaf, dnf) -> dnf
;   a = 'true or l = 'true => 'true
;   a = 'false => l
;   member(a,l) => l
;   y := notCoaf a
;   x := ordIntersection(y,l)
;   null x => ordUnion([a], l)
;   x = y => 'true
;   ordUnion(notDnf ordSetDiff(y,x),l)

(DEFUN |coafOrDnf| (|a| |l|)
  (PROG (|y| |x|)
    (RETURN
     (COND ((OR (EQ |a| '|true|) (EQ |l| '|true|)) '|true|)
           ((EQ |a| '|false|) |l|) ((|member| |a| |l|) |l|)
           (#1='T
            (PROGN
             (SETQ |y| (|notCoaf| |a|))
             (SETQ |x| (|ordIntersection| |y| |l|))
             (COND ((NULL |x|) (|ordUnion| (LIST |a|) |l|))
                   ((EQUAL |x| |y|) '|true|)
                   (#1#
                    (|ordUnion| (|notDnf| (|ordSetDiff| |y| |x|)) |l|)))))))))

; coafAndDnf(a,b) ==              --and: (coaf, dnf) -> dnf
;   a = 'true => b
;   a = 'false => 'false
;   [c,:r] := b
;   x := coafAndCoaf(a, c)      --dnf
;   null r => x
;   y := coafAndDnf(a,r)       --dnf
;   x = 'false => y
;   y = 'false => x
;   ordUnion(x,y)

(DEFUN |coafAndDnf| (|a| |b|)
  (PROG (|c| |r| |x| |y|)
    (RETURN
     (COND ((EQ |a| '|true|) |b|) ((EQ |a| '|false|) '|false|)
           (#1='T
            (PROGN
             (SETQ |c| (CAR |b|))
             (SETQ |r| (CDR |b|))
             (SETQ |x| (|coafAndCoaf| |a| |c|))
             (COND ((NULL |r|) |x|)
                   (#1#
                    (PROGN
                     (SETQ |y| (|coafAndDnf| |a| |r|))
                     (COND ((EQ |x| '|false|) |y|) ((EQ |y| '|false|) |x|)
                           (#1# (|ordUnion| |x| |y|))))))))))))

; coafAndCoaf([a,b],[p,q]) ==                  --and: (coaf,coaf) -> dnf
;   ordIntersection(a,q) or ordIntersection(b,p) => 'false
;   [[ordUnion(a,p),ordUnion(b,q)]]

(DEFUN |coafAndCoaf| (|bfVar#14| |bfVar#15|)
  (PROG (|p| |q| |a| |b|)
    (RETURN
     (PROGN
      (SETQ |p| (CAR |bfVar#15|))
      (SETQ |q| (CADR |bfVar#15|))
      (SETQ |a| (CAR |bfVar#14|))
      (SETQ |b| (CADR |bfVar#14|))
      (COND
       ((OR (|ordIntersection| |a| |q|) (|ordIntersection| |b| |p|)) '|false|)
       ('T (LIST (LIST (|ordUnion| |a| |p|) (|ordUnion| |b| |q|)))))))))

; notCoaf [a,b] ==
;     orderList([:[[nil, [x]] for x in a], :[[[x], nil] for x in b]])

(DEFUN |notCoaf| (|bfVar#20|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |a| (CAR |bfVar#20|))
      (SETQ |b| (CADR |bfVar#20|))
      (|orderList|
       (APPEND
        ((LAMBDA (|bfVar#17| |bfVar#16| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#16|) (PROGN (SETQ |x| (CAR |bfVar#16|)) NIL))
              (RETURN (NREVERSE |bfVar#17|)))
             (#1='T (SETQ |bfVar#17| (CONS (LIST NIL (LIST |x|)) |bfVar#17|))))
            (SETQ |bfVar#16| (CDR |bfVar#16|))))
         NIL |a| NIL)
        ((LAMBDA (|bfVar#19| |bfVar#18| |x|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#18|) (PROGN (SETQ |x| (CAR |bfVar#18|)) NIL))
              (RETURN (NREVERSE |bfVar#19|)))
             (#1# (SETQ |bfVar#19| (CONS (LIST (LIST |x|) NIL) |bfVar#19|))))
            (SETQ |bfVar#18| (CDR |bfVar#18|))))
         NIL |b| NIL)))))))

; ordUnion(a,b) ==
;   a isnt [c,:r] => b
;   b isnt [d,:s] => a
;   c=d => [c,:ordUnion(r,s)]
;   ?ORDER(c, d) => [c, :ordUnion(r, b)]
;   [d,:ordUnion(s,a)]

(DEFUN |ordUnion| (|a| |b|)
  (PROG (|c| |r| |d| |s|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |a|)
             (PROGN (SETQ |c| (CAR |a|)) (SETQ |r| (CDR |a|)) #1='T)))
       |b|)
      ((NOT
        (AND (CONSP |b|)
             (PROGN (SETQ |d| (CAR |b|)) (SETQ |s| (CDR |b|)) #1#)))
       |a|)
      ((EQUAL |c| |d|) (CONS |c| (|ordUnion| |r| |s|)))
      ((?ORDER |c| |d|) (CONS |c| (|ordUnion| |r| |b|)))
      (#1# (CONS |d| (|ordUnion| |s| |a|)))))))

; ordIntersection(a,b) ==
;   a isnt [h,:t] => nil
;   member(h,b) => [h,:ordIntersection(t,b)]
;   ordIntersection(t,b)

(DEFUN |ordIntersection| (|a| |b|)
  (PROG (|h| |t|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |a|)
             (PROGN (SETQ |h| (CAR |a|)) (SETQ |t| (CDR |a|)) #1='T)))
       NIL)
      ((|member| |h| |b|) (CONS |h| (|ordIntersection| |t| |b|)))
      (#1# (|ordIntersection| |t| |b|))))))

; ordSetDiff(a,b) ==
;   b isnt [h,:t] => a
;   member(h,a) => ordSetDiff(delete(h,a),t)
;   ordSetDiff(a,t)

(DEFUN |ordSetDiff| (|a| |b|)
  (PROG (|h| |t|)
    (RETURN
     (COND
      ((NOT
        (AND (CONSP |b|)
             (PROGN (SETQ |h| (CAR |b|)) (SETQ |t| (CDR |b|)) #1='T)))
       |a|)
      ((|member| |h| |a|) (|ordSetDiff| (|delete| |h| |a|) |t|))
      (#1# (|ordSetDiff| |a| |t|))))))

; testPredList u ==
;   for x in u repeat
;     y := simpBool x
;     x = y => nil
;     pp x
;     pp '"==========>"
;     pp y

(DEFUN |testPredList| (|u|)
  (PROG (|y|)
    (RETURN
     ((LAMBDA (|bfVar#21| |x|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#21|) (PROGN (SETQ |x| (CAR |bfVar#21|)) NIL))
           (RETURN NIL))
          (#1='T
           (PROGN
            (SETQ |y| (|simpBool| |x|))
            (COND ((EQUAL |x| |y|) NIL)
                  (#1# (PROGN (|pp| |x|) (|pp| "==========>") (|pp| |y|)))))))
         (SETQ |bfVar#21| (CDR |bfVar#21|))))
      |u| NIL))))


; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFPARAMETER($coerceFailure, GENSYM())

(DEFPARAMETER |$coerceFailure| (GENSYM))

; position1(x,y) ==
;   -- this is used where we want to assume a 1-based index
;   1 + position(x,y)

(DEFUN |position1| (|x| |y|) (PROG () (RETURN (+ 1 (|position| |x| |y|)))))

; Zeros n ==
;     BOUNDP '$ZeroVecCache and #$ZeroVecCache = n => $ZeroVecCache
;     $ZeroVecCache := MAKE_VEC(n)
;     for i in 0..n-1 repeat $ZeroVecCache.i := 0
;     $ZeroVecCache

(DEFUN |Zeros| (|n|)
  (PROG ()
    (RETURN
     (COND
      ((AND (BOUNDP '|$ZeroVecCache|) (EQL (LENGTH |$ZeroVecCache|) |n|))
       |$ZeroVecCache|)
      (#1='T
       (PROGN
        (SETQ |$ZeroVecCache| (MAKE_VEC |n|))
        ((LAMBDA (|bfVar#1| |i|)
           (LOOP
            (COND ((> |i| |bfVar#1|) (RETURN NIL))
                  (#1# (SETF (ELT |$ZeroVecCache| |i|) 0)))
            (SETQ |i| (+ |i| 1))))
         (- |n| 1) 0)
        |$ZeroVecCache|))))))

; LZeros n ==
;     n < 1 => nil
;     l := [0]
;     for i in 2..n repeat l := [0, :l]
;     l

(DEFUN |LZeros| (|n|)
  (PROG (|l|)
    (RETURN
     (COND ((< |n| 1) NIL)
           (#1='T
            (PROGN
             (SETQ |l| (LIST 0))
             ((LAMBDA (|i|)
                (LOOP
                 (COND ((> |i| |n|) (RETURN NIL))
                       (#1# (SETQ |l| (CONS 0 |l|))))
                 (SETQ |i| (+ |i| 1))))
              2)
             |l|))))))

; DP2DP(u,source is [.,n,S],target is [.,m,T]) ==
;   n ~= m => nil
;   u = '_$fromCoerceable_$ => canCoerce(S,T)
;   null (u' := coerceInt(objNewWrap(u,['Vector,S]),['Vector,T])) =>
;     coercionFailure()
;   objValUnwrap u'

(DEFUN DP2DP (|u| |source| |target|)
  (PROG (|m| T$ |n| S |u'|)
    (RETURN
     (PROGN
      (SETQ |m| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |n| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND ((NOT (EQUAL |n| |m|)) NIL)
            ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S T$))
            ((NULL
              (SETQ |u'|
                      (|coerceInt| (|objNewWrap| |u| (LIST '|Vector| S))
                       (LIST '|Vector| T$))))
             (|coercionFailure|))
            ('T (|objValUnwrap| |u'|)))))))

; Dmp2Dmp(u,source is [dmp,v1,S], target is [.,v2,T]) ==
;   -- the variable lists must share some variables, or u is a constant
;   u = '_$fromCoerceable_$ =>
;     v:= intersection(v1,v2)
;     v and
;       w2:= SETDIFFERENCE(v2,v)
;       t1:= if w1 then [dmp,w1,S] else S
;       t2:= if w2 then [dmp,w2,T] else T
;       canCoerce(t1,t2)
;   null u => domainZero(target)
;   u is [[e,:c]] and e=LIST2VEC [0 for v in v1] =>
;     z:= coerceInt(objNewWrap(c,S),target) => objValUnwrap(z)
;     coercionFailure()
;   v:= intersection(v1,v2) =>
;     w1:= SETDIFFERENCE(v1,v) =>
;       coerceDmp1(u,source,target,v,w1)
;     coerceDmp2(u,source,target)
;   coercionFailure()

(DEFUN |Dmp2Dmp| (|u| |source| |target|)
  (PROG (|v2| T$ |dmp| |v1| S |v| |w2| |t1| |t2| |ISTMP#1| |e| |c| |z| |w1|)
    (RETURN
     (PROGN
      (SETQ |v2| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |dmp| (CAR |source|))
      (SETQ |v1| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (PROGN
         (SETQ |v| (|intersection| |v1| |v2|))
         (AND |v|
              (PROGN
               (SETQ |w2| (SETDIFFERENCE |v2| |v|))
               (SETQ |t1| (COND (|w1| (LIST |dmp| |w1| S)) (#3='T S)))
               (SETQ |t2| (COND (|w2| (LIST |dmp| |w2| T$)) (#3# T$)))
               (|canCoerce| |t1| |t2|)))))
       ((NULL |u|) (|domainZero| |target|))
       ((AND (CONSP |u|) (EQ (CDR |u|) NIL)
             (PROGN
              (SETQ |ISTMP#1| (CAR |u|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |e| (CAR |ISTMP#1|))
                    (SETQ |c| (CDR |ISTMP#1|))
                    #3#)))
             (EQUAL |e|
                    (LIST2VEC
                     ((LAMBDA (|bfVar#3| |bfVar#2| |v|)
                        (LOOP
                         (COND
                          ((OR (ATOM |bfVar#2|)
                               (PROGN (SETQ |v| (CAR |bfVar#2|)) NIL))
                           (RETURN (NREVERSE |bfVar#3|)))
                          (#3# (SETQ |bfVar#3| (CONS 0 |bfVar#3|))))
                         (SETQ |bfVar#2| (CDR |bfVar#2|))))
                      NIL |v1| NIL))))
        (COND
         ((SETQ |z| (|coerceInt| (|objNewWrap| |c| S) |target|))
          (|objValUnwrap| |z|))
         (#3# (|coercionFailure|))))
       ((SETQ |v| (|intersection| |v1| |v2|))
        (COND
         ((SETQ |w1| (SETDIFFERENCE |v1| |v|))
          (|coerceDmp1| |u| |source| |target| |v| |w1|))
         (#3# (|coerceDmp2| |u| |source| |target|))))
       (#3# (|coercionFailure|)))))))

; coerceDmp1(u,source is [.,v1,S],target is [.,v2,T],v,w) ==
;   -- coerces one Dmp to another, where v1 is not a subset of v2
;   -- v is the intersection, w the complement of v1 and v2
;   t:= ['DistributedMultivariatePolynomial,w,S]
;   x:= domainZero(target)
;   one:= domainOne(T)
;   plusfunc:= getFunctionFromDomain('_+,target,[target,target])
;   multfunc:= getFunctionFromDomain('_*,target,[target,target])
;   pat1:= [member(x,v) for x in v1]
;   pat2:= [member(x,w) for x in v1]
;   pat3:= [member(x,v) and POSN1(x,v) for x in v2]
;   for [e,:c] in u until not z repeat
;     exp:= LIST2VEC [y for x in pat2 for y in VEC2LIST e | x]
;     z:= coerceInt(objNewWrap([CONS(exp,c)],t),target) =>
;       li:= [y for x in pat1 for y in VEC2LIST e | x]
;       a:= [CONS(LIST2VEC [if x then li.x else 0 for x in pat3],one)]
;       x:= SPADCALL(x,SPADCALL(objValUnwrap(z),a,multfunc),plusfunc)
;   z => x
;   coercionFailure()

(DEFUN |coerceDmp1| (|u| |source| |target| |v| |w|)
  (PROG (|v2| T$ |v1| S |t| |x| |one| |plusfunc| |multfunc| |pat1| |pat2|
         |pat3| |e| |c| |exp| |z| |li| |a|)
    (RETURN
     (PROGN
      (SETQ |v2| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |v1| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (SETQ |t| (LIST '|DistributedMultivariatePolynomial| |w| S))
      (SETQ |x| (|domainZero| |target|))
      (SETQ |one| (|domainOne| T$))
      (SETQ |plusfunc|
              (|getFunctionFromDomain| '+ |target| (LIST |target| |target|)))
      (SETQ |multfunc|
              (|getFunctionFromDomain| '* |target| (LIST |target| |target|)))
      (SETQ |pat1|
              ((LAMBDA (|bfVar#5| |bfVar#4| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#4|)
                        (PROGN (SETQ |x| (CAR |bfVar#4|)) NIL))
                    (RETURN (NREVERSE |bfVar#5|)))
                   (#3='T
                    (SETQ |bfVar#5| (CONS (|member| |x| |v|) |bfVar#5|))))
                  (SETQ |bfVar#4| (CDR |bfVar#4|))))
               NIL |v1| NIL))
      (SETQ |pat2|
              ((LAMBDA (|bfVar#7| |bfVar#6| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#6|)
                        (PROGN (SETQ |x| (CAR |bfVar#6|)) NIL))
                    (RETURN (NREVERSE |bfVar#7|)))
                   (#3# (SETQ |bfVar#7| (CONS (|member| |x| |w|) |bfVar#7|))))
                  (SETQ |bfVar#6| (CDR |bfVar#6|))))
               NIL |v1| NIL))
      (SETQ |pat3|
              ((LAMBDA (|bfVar#9| |bfVar#8| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#8|)
                        (PROGN (SETQ |x| (CAR |bfVar#8|)) NIL))
                    (RETURN (NREVERSE |bfVar#9|)))
                   (#3#
                    (SETQ |bfVar#9|
                            (CONS (AND (|member| |x| |v|) (POSN1 |x| |v|))
                                  |bfVar#9|))))
                  (SETQ |bfVar#8| (CDR |bfVar#8|))))
               NIL |v2| NIL))
      ((LAMBDA (|bfVar#11| |bfVar#10| |bfVar#12|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#11|)
                (PROGN (SETQ |bfVar#10| (CAR |bfVar#11|)) NIL) |bfVar#12|)
            (RETURN NIL))
           (#3#
            (AND (CONSP |bfVar#10|)
                 (PROGN
                  (SETQ |e| (CAR |bfVar#10|))
                  (SETQ |c| (CDR |bfVar#10|))
                  #3#)
                 (PROGN
                  (SETQ |exp|
                          (LIST2VEC
                           ((LAMBDA (|bfVar#15| |bfVar#13| |x| |bfVar#14| |y|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#13|)
                                     (PROGN (SETQ |x| (CAR |bfVar#13|)) NIL)
                                     (ATOM |bfVar#14|)
                                     (PROGN (SETQ |y| (CAR |bfVar#14|)) NIL))
                                 (RETURN (NREVERSE |bfVar#15|)))
                                (#3#
                                 (AND |x|
                                      (SETQ |bfVar#15|
                                              (CONS |y| |bfVar#15|)))))
                               (SETQ |bfVar#13| (CDR |bfVar#13|))
                               (SETQ |bfVar#14| (CDR |bfVar#14|))))
                            NIL |pat2| NIL (VEC2LIST |e|) NIL)))
                  (COND
                   ((SETQ |z|
                            (|coerceInt|
                             (|objNewWrap| (LIST (CONS |exp| |c|)) |t|)
                             |target|))
                    (PROGN
                     (SETQ |li|
                             ((LAMBDA
                                  (|bfVar#18| |bfVar#16| |x| |bfVar#17| |y|)
                                (LOOP
                                 (COND
                                  ((OR (ATOM |bfVar#16|)
                                       (PROGN (SETQ |x| (CAR |bfVar#16|)) NIL)
                                       (ATOM |bfVar#17|)
                                       (PROGN (SETQ |y| (CAR |bfVar#17|)) NIL))
                                   (RETURN (NREVERSE |bfVar#18|)))
                                  (#3#
                                   (AND |x|
                                        (SETQ |bfVar#18|
                                                (CONS |y| |bfVar#18|)))))
                                 (SETQ |bfVar#16| (CDR |bfVar#16|))
                                 (SETQ |bfVar#17| (CDR |bfVar#17|))))
                              NIL |pat1| NIL (VEC2LIST |e|) NIL))
                     (SETQ |a|
                             (LIST
                              (CONS
                               (LIST2VEC
                                ((LAMBDA (|bfVar#20| |bfVar#19| |x|)
                                   (LOOP
                                    (COND
                                     ((OR (ATOM |bfVar#19|)
                                          (PROGN
                                           (SETQ |x| (CAR |bfVar#19|))
                                           NIL))
                                      (RETURN (NREVERSE |bfVar#20|)))
                                     (#3#
                                      (SETQ |bfVar#20|
                                              (CONS
                                               (COND (|x| (ELT |li| |x|))
                                                     (#3# 0))
                                               |bfVar#20|))))
                                    (SETQ |bfVar#19| (CDR |bfVar#19|))))
                                 NIL |pat3| NIL))
                               |one|)))
                     (SETQ |x|
                             (SPADCALL |x|
                              (SPADCALL (|objValUnwrap| |z|) |a| |multfunc|)
                              |plusfunc|)))))))))
          (SETQ |bfVar#11| (CDR |bfVar#11|))
          (SETQ |bfVar#12| (NULL |z|))))
       |u| NIL NIL)
      (COND (|z| |x|) (#3# (|coercionFailure|)))))))

; coerceDmp2(u,source is [.,v1,S],target is [.,v2,T]) ==
;   -- coerces one Dmp to another, where v1 is included in v2
;   x:= domainZero(target)
;   one:= domainOne(T)
;   plusfunc:= getFunctionFromDomain('_+,target,[target,target])
;   multfunc:= getFunctionFromDomain('_*,target,[target,target])
;   pat:= [member(x,v1) and POSN1(x,v1) for x in v2]
;   for [e,:c] in u until not z repeat
;     z:= coerceInt(objNewWrap(c,S),target) =>
;       li:= VEC2LIST e
;       a:= [CONS(LIST2VEC [if x then li.x else 0 for x in pat],one)]
;       x:= SPADCALL(x,SPADCALL(objValUnwrap(z),a,multfunc),plusfunc)
;     NIL
;   z => x
;   coercionFailure()

(DEFUN |coerceDmp2| (|u| |source| |target|)
  (PROG (|v2| T$ |v1| S |x| |one| |plusfunc| |multfunc| |pat| |e| |c| |z| |li|
         |a|)
    (RETURN
     (PROGN
      (SETQ |v2| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |v1| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (SETQ |x| (|domainZero| |target|))
      (SETQ |one| (|domainOne| T$))
      (SETQ |plusfunc|
              (|getFunctionFromDomain| '+ |target| (LIST |target| |target|)))
      (SETQ |multfunc|
              (|getFunctionFromDomain| '* |target| (LIST |target| |target|)))
      (SETQ |pat|
              ((LAMBDA (|bfVar#22| |bfVar#21| |x|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#21|)
                        (PROGN (SETQ |x| (CAR |bfVar#21|)) NIL))
                    (RETURN (NREVERSE |bfVar#22|)))
                   (#3='T
                    (SETQ |bfVar#22|
                            (CONS (AND (|member| |x| |v1|) (POSN1 |x| |v1|))
                                  |bfVar#22|))))
                  (SETQ |bfVar#21| (CDR |bfVar#21|))))
               NIL |v2| NIL))
      ((LAMBDA (|bfVar#24| |bfVar#23| |bfVar#25|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#24|)
                (PROGN (SETQ |bfVar#23| (CAR |bfVar#24|)) NIL) |bfVar#25|)
            (RETURN NIL))
           (#3#
            (AND (CONSP |bfVar#23|)
                 (PROGN
                  (SETQ |e| (CAR |bfVar#23|))
                  (SETQ |c| (CDR |bfVar#23|))
                  #3#)
                 (COND
                  ((SETQ |z| (|coerceInt| (|objNewWrap| |c| S) |target|))
                   (PROGN
                    (SETQ |li| (VEC2LIST |e|))
                    (SETQ |a|
                            (LIST
                             (CONS
                              (LIST2VEC
                               ((LAMBDA (|bfVar#27| |bfVar#26| |x|)
                                  (LOOP
                                   (COND
                                    ((OR (ATOM |bfVar#26|)
                                         (PROGN
                                          (SETQ |x| (CAR |bfVar#26|))
                                          NIL))
                                     (RETURN (NREVERSE |bfVar#27|)))
                                    (#3#
                                     (SETQ |bfVar#27|
                                             (CONS
                                              (COND (|x| (ELT |li| |x|))
                                                    (#3# 0))
                                              |bfVar#27|))))
                                   (SETQ |bfVar#26| (CDR |bfVar#26|))))
                                NIL |pat| NIL))
                              |one|)))
                    (SETQ |x|
                            (SPADCALL |x|
                             (SPADCALL (|objValUnwrap| |z|) |a| |multfunc|)
                             |plusfunc|))))
                  (#3# NIL)))))
          (SETQ |bfVar#24| (CDR |bfVar#24|))
          (SETQ |bfVar#25| (NULL |z|))))
       |u| NIL NIL)
      (COND (|z| |x|) (#3# (|coercionFailure|)))))))

; Dmp2Expr(u,source is [dmp,vars,S], target is [Expr,T]) ==
;     u = '_$fromCoerceable_$ => canCoerce(S, target)
;
;     null vars =>
;         [[., :c]] := u
;         not (c := coerceInt(objNewWrap(c, S), target)) => coercionFailure()
;         objValUnwrap(c)
;
;     syms := [objValUnwrap coerceInt(objNewWrap(var, $Symbol), target) for
;                 var in vars]
;     sum := domainZero(target)
;
;     plus := getFunctionFromDomain("+",  target, [target, target])
;     mult := getFunctionFromDomain("*",  target, [target, target])
;     expn := getFunctionFromDomain("^", target, [target, $Integer])
;
;     for [e, :c] in u repeat
;         not (c := coerceInt(objNewWrap(c, S), target)) => coercionFailure()
;         c := objValUnwrap(c)
;         term := domainOne(target)
;         for i in 0.. for sym in syms repeat
;             exp := e.i
;             e.i > 0 => term := SPADCALL(term, SPADCALL(sym, e.i, expn), mult)
;         sum := SPADCALL(sum, SPADCALL(c, term, mult), plus)
;
;     sum

(DEFUN |Dmp2Expr| (|u| |source| |target|)
  (PROG (|Expr| T$ |dmp| |vars| S |c| |syms| |sum| |plus| |mult| |expn| |e|
         |term| |exp|)
    (RETURN
     (PROGN
      (SETQ |Expr| (CAR |target|))
      (SETQ T$ (CADR |target|))
      (SETQ |dmp| (CAR |source|))
      (SETQ |vars| (CADR . #1=(|source|)))
      (SETQ S (CADDR . #1#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S |target|))
            ((NULL |vars|)
             (PROGN
              (SETQ |c| (CDAR |u|))
              (COND
               ((NULL (SETQ |c| (|coerceInt| (|objNewWrap| |c| S) |target|)))
                (|coercionFailure|))
               (#2='T (|objValUnwrap| |c|)))))
            (#2#
             (PROGN
              (SETQ |syms|
                      ((LAMBDA (|bfVar#29| |bfVar#28| |var|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#28|)
                                (PROGN (SETQ |var| (CAR |bfVar#28|)) NIL))
                            (RETURN (NREVERSE |bfVar#29|)))
                           (#2#
                            (SETQ |bfVar#29|
                                    (CONS
                                     (|objValUnwrap|
                                      (|coerceInt|
                                       (|objNewWrap| |var| |$Symbol|)
                                       |target|))
                                     |bfVar#29|))))
                          (SETQ |bfVar#28| (CDR |bfVar#28|))))
                       NIL |vars| NIL))
              (SETQ |sum| (|domainZero| |target|))
              (SETQ |plus|
                      (|getFunctionFromDomain| '+ |target|
                       (LIST |target| |target|)))
              (SETQ |mult|
                      (|getFunctionFromDomain| '* |target|
                       (LIST |target| |target|)))
              (SETQ |expn|
                      (|getFunctionFromDomain| '^ |target|
                       (LIST |target| |$Integer|)))
              ((LAMBDA (|bfVar#31| |bfVar#30|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#31|)
                        (PROGN (SETQ |bfVar#30| (CAR |bfVar#31|)) NIL))
                    (RETURN NIL))
                   (#2#
                    (AND (CONSP |bfVar#30|)
                         (PROGN
                          (SETQ |e| (CAR |bfVar#30|))
                          (SETQ |c| (CDR |bfVar#30|))
                          #2#)
                         (COND
                          ((NULL
                            (SETQ |c|
                                    (|coerceInt| (|objNewWrap| |c| S)
                                     |target|)))
                           (|coercionFailure|))
                          (#2#
                           (PROGN
                            (SETQ |c| (|objValUnwrap| |c|))
                            (SETQ |term| (|domainOne| |target|))
                            ((LAMBDA (|i| |bfVar#32| |sym|)
                               (LOOP
                                (COND
                                 ((OR (ATOM |bfVar#32|)
                                      (PROGN
                                       (SETQ |sym| (CAR |bfVar#32|))
                                       NIL))
                                  (RETURN NIL))
                                 (#2#
                                  (PROGN
                                   (SETQ |exp| (ELT |e| |i|))
                                   (COND
                                    ((< 0 (ELT |e| |i|))
                                     (SETQ |term|
                                             (SPADCALL |term|
                                              (SPADCALL |sym| (ELT |e| |i|)
                                               |expn|)
                                              |mult|)))))))
                                (SETQ |i| (+ |i| 1))
                                (SETQ |bfVar#32| (CDR |bfVar#32|))))
                             0 |syms| NIL)
                            (SETQ |sum|
                                    (SPADCALL |sum|
                                     (SPADCALL |c| |term| |mult|)
                                     |plus|))))))))
                  (SETQ |bfVar#31| (CDR |bfVar#31|))))
               |u| NIL)
              |sum|)))))))

; Dmp2Mp(u, source is [dmp, x, S], target is [mp, y, T]) ==
;   source' := [dmp,y,T]
;   u = '_$fromCoerceable_$ =>
;     x = y => canCoerce(S,T)
;     canCoerce(source',target)
;   null u => domainZero(target)  -- 0 dmp is = nil
;   x ~= y =>
;     (u' := coerceInt(objNewWrap(u,source),source')) or coercionFailure()
;     (u' := coerceInt(u',target)) or coercionFailure()
;     objValUnwrap(u')
;
;   -- slight optimization for case #u = 1, x=y , #x =1 and S=T
;   -- I know it's pathological, but it may avoid an instantiation
;   (x=y) and (1 = #u) and (1 = #x) and (S = T) =>
;     [1,1,[(CAAR u).0,0,:CDAR u]]
;
;   (u' := coerceDmpCoeffs(u,S,T)) = 'failed =>
;     coercionFailure()
;   plusfunc := getFunctionFromDomain("+",target,[target,target])
;   u'' := genMpFromDmpTerm(u'.0, 0)
;   for i in 1..(#u' - 1) repeat
;     u'' := SPADCALL(u'',genMpFromDmpTerm(u'.i, 0),plusfunc)
;   u''

(DEFUN |Dmp2Mp| (|u| |source| |target|)
  (PROG (|mp| |y| T$ |dmp| |x| S |source'| |u'| |plusfunc| |u''|)
    (RETURN
     (PROGN
      (SETQ |mp| (CAR |target|))
      (SETQ |y| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |dmp| (CAR |source|))
      (SETQ |x| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (SETQ |source'| (LIST |dmp| |y| T$))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND ((EQUAL |x| |y|) (|canCoerce| S T$))
              (#3='T (|canCoerce| |source'| |target|))))
       ((NULL |u|) (|domainZero| |target|))
       ((NOT (EQUAL |x| |y|))
        (PROGN
         (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) |source'|))
             (|coercionFailure|))
         (OR (SETQ |u'| (|coerceInt| |u'| |target|)) (|coercionFailure|))
         (|objValUnwrap| |u'|)))
       ((AND (EQUAL |x| |y|) (EQL 1 (LENGTH |u|)) (EQL 1 (LENGTH |x|))
             (EQUAL S T$))
        (LIST 1 1 (CONS (ELT (CAAR |u|) 0) (CONS 0 (CDAR |u|)))))
       ((EQ (SETQ |u'| (|coerceDmpCoeffs| |u| S T$)) '|failed|)
        (|coercionFailure|))
       (#3#
        (PROGN
         (SETQ |plusfunc|
                 (|getFunctionFromDomain| '+ |target|
                  (LIST |target| |target|)))
         (SETQ |u''| (|genMpFromDmpTerm| (ELT |u'| 0) 0))
         ((LAMBDA (|bfVar#33| |i|)
            (LOOP
             (COND ((> |i| |bfVar#33|) (RETURN NIL))
                   (#3#
                    (SETQ |u''|
                            (SPADCALL |u''|
                             (|genMpFromDmpTerm| (ELT |u'| |i|) 0)
                             |plusfunc|))))
             (SETQ |i| (+ |i| 1))))
          (- (LENGTH |u'|) 1) 1)
         |u''|)))))))

; coerceDmpCoeffs(u,S,T) ==
;   -- u is a dmp, S is domain of coeffs, T is domain to coerce coeffs to
;   S = T => u
;   u' := nil
;   bad := nil
;   for [e,:c] in u repeat
;     bad => nil
;     null (c' := coerceInt(objNewWrap(c,S),T)) => return (bad := true)
;     u' := [[e,:objValUnwrap(c')],:u']
;   bad => 'failed
;   nreverse u'

(DEFUN |coerceDmpCoeffs| (|u| S T$)
  (PROG (|u'| |bad| |e| |c| |c'|)
    (RETURN
     (COND ((EQUAL S T$) |u|)
           (#1='T
            (PROGN
             (SETQ |u'| NIL)
             (SETQ |bad| NIL)
             ((LAMBDA (|bfVar#35| |bfVar#34|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#35|)
                       (PROGN (SETQ |bfVar#34| (CAR |bfVar#35|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |bfVar#34|)
                        (PROGN
                         (SETQ |e| (CAR |bfVar#34|))
                         (SETQ |c| (CDR |bfVar#34|))
                         #1#)
                        (COND (|bad| NIL)
                              ((NULL
                                (SETQ |c'|
                                        (|coerceInt| (|objNewWrap| |c| S) T$)))
                               (RETURN (SETQ |bad| T)))
                              (#1#
                               (SETQ |u'|
                                       (CONS (CONS |e| (|objValUnwrap| |c'|))
                                             |u'|)))))))
                 (SETQ |bfVar#35| (CDR |bfVar#35|))))
              |u| NIL)
             (COND (|bad| '|failed|) (#1# (NREVERSE |u'|)))))))))

; sortAndReorderDmpExponents(u,vl) ==
;   vl' := reverse MSORT vl
;   n := (-1) + #vl
;   pos := LIST2VEC LZeros (n+1)
;   for i in 0..n repeat pos.i := position(vl.i,vl')
;   u' := nil
;   for [e,:c] in u repeat
;     e' := LIST2VEC LZeros (n+1)
;     for i in 0..n repeat e'.(pos.i) := e.i
;     u' := [[e',:c],:u']
;   reverse u'

(DEFUN |sortAndReorderDmpExponents| (|u| |vl|)
  (PROG (|vl'| |n| |pos| |u'| |e| |c| |e'|)
    (RETURN
     (PROGN
      (SETQ |vl'| (REVERSE (MSORT |vl|)))
      (SETQ |n| (+ (- 1) (LENGTH |vl|)))
      (SETQ |pos| (LIST2VEC (|LZeros| (+ |n| 1))))
      ((LAMBDA (|i|)
         (LOOP
          (COND ((> |i| |n|) (RETURN NIL))
                (#1='T
                 (SETF (ELT |pos| |i|) (|position| (ELT |vl| |i|) |vl'|))))
          (SETQ |i| (+ |i| 1))))
       0)
      (SETQ |u'| NIL)
      ((LAMBDA (|bfVar#37| |bfVar#36|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#37|)
                (PROGN (SETQ |bfVar#36| (CAR |bfVar#37|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#36|)
                 (PROGN
                  (SETQ |e| (CAR |bfVar#36|))
                  (SETQ |c| (CDR |bfVar#36|))
                  #1#)
                 (PROGN
                  (SETQ |e'| (LIST2VEC (|LZeros| (+ |n| 1))))
                  ((LAMBDA (|i|)
                     (LOOP
                      (COND ((> |i| |n|) (RETURN NIL))
                            (#1#
                             (SETF (ELT |e'| (ELT |pos| |i|)) (ELT |e| |i|))))
                      (SETQ |i| (+ |i| 1))))
                   0)
                  (SETQ |u'| (CONS (CONS |e'| |c|) |u'|))))))
          (SETQ |bfVar#37| (CDR |bfVar#37|))))
       |u| NIL)
      (REVERSE |u'|)))))

; domain2NDmp(u, source, target is [., y, T]) ==
;   target' := ['DistributedMultivariatePolynomial,y,T]
;   u = '_$fromCoerceable_$ => canCoerce(source,target')
;   (u' := coerceInt(objNewWrap(u,source),target')) =>
;     (u'' := coerceInt(u',target)) =>
;       objValUnwrap(u'')
;     coercionFailure()
;   coercionFailure()

(DEFUN |domain2NDmp| (|u| |source| |target|)
  (PROG (|y| T$ |target'| |u'| |u''|)
    (RETURN
     (PROGN
      (SETQ |y| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |target'| (LIST '|DistributedMultivariatePolynomial| |y| T$))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| |target'|))
            ((SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) |target'|))
             (COND
              ((SETQ |u''| (|coerceInt| |u'| |target|)) (|objValUnwrap| |u''|))
              (#2='T (|coercionFailure|))))
            (#2# (|coercionFailure|)))))))

; Dmp2NDmp(u,source is [dmp,x,S],target is [ndmp,y,T]) ==
;   -- a null DMP = 0
;   null u => domainZero(target)
;   target' := [dmp,y,T]
;   u = '_$fromCoerceable_$ => Dmp2Dmp(u,source,target')
;   (u' := Dmp2Dmp(u,source,target')) => addDmpLikeTermsAsTarget(u',target)
;   coercionFailure()

(DEFUN |Dmp2NDmp| (|u| |source| |target|)
  (PROG (|ndmp| |y| T$ |dmp| |x| S |target'| |u'|)
    (RETURN
     (PROGN
      (SETQ |ndmp| (CAR |target|))
      (SETQ |y| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |dmp| (CAR |source|))
      (SETQ |x| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND ((NULL |u|) (|domainZero| |target|))
            (#3='T
             (PROGN
              (SETQ |target'| (LIST |dmp| |y| T$))
              (COND
               ((EQ |u| '|$fromCoerceable$|)
                (|Dmp2Dmp| |u| |source| |target'|))
               ((SETQ |u'| (|Dmp2Dmp| |u| |source| |target'|))
                (|addDmpLikeTermsAsTarget| |u'| |target|))
               (#3# (|coercionFailure|))))))))))

; addDmpLikeTermsAsTarget(u,target) ==
;   u' := domainZero(target)
;   func := getFunctionFromDomain("+",target,[target,target])
;   for t in u repeat u' := SPADCALL(u',[t],func)
;   u'

(DEFUN |addDmpLikeTermsAsTarget| (|u| |target|)
  (PROG (|u'| |func|)
    (RETURN
     (PROGN
      (SETQ |u'| (|domainZero| |target|))
      (SETQ |func|
              (|getFunctionFromDomain| '+ |target| (LIST |target| |target|)))
      ((LAMBDA (|bfVar#38| |t|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#38|) (PROGN (SETQ |t| (CAR |bfVar#38|)) NIL))
            (RETURN NIL))
           ('T (SETQ |u'| (SPADCALL |u'| (LIST |t|) |func|))))
          (SETQ |bfVar#38| (CDR |bfVar#38|))))
       |u| NIL)
      |u'|))))

; Dmp2P(u, source is [dmp,vl, S], target is [.,T]) ==
;   -- a null DMP = 0
;   null u => domainZero(target)
;   u = '_$fromCoerceable_$ =>
;     t := canCoerce(S,T)
;     null t => canCoerce(S,target)
;     t
;
;   S is ['Polynomial,.] =>
;     mp := coerceInt(objNewWrap(u,source),['MultivariatePolynomial,vl,S])
;       or coercionFailure()
;     p := coerceInt(mp,target) or coercionFailure()
;     objValUnwrap p
;
;   -- slight optimization for case #u = 1, #vl =1 and S=T
;   -- I know it's pathological, but it may avoid an instantiation
;   (1 = #u) and (1 = #vl) and (S = T) =>
;     -- scalar
;     (lexp:= (CAAR u).0) = 0 =>
;        [0,:CDAR u]
;     [1,vl.0,[lexp,0,:CDAR u]]
;
;   vl' := reverse MSORT vl
;   source' := [dmp,vl',S]
;   target' := ['MultivariatePolynomial,vl',S]
;   u' := sortAndReorderDmpExponents(u,vl)
;   u' := coerceInt(objNewWrap(u',source'),target')
;   if u' then
;     u' := translateMpVars2PVars (objValUnwrap(u'),vl')
;     u' := coerceInt(objNewWrap(u',['Polynomial,S]),target)
;   u' => objValUnwrap(u')
;   -- get drastic. create monomials
;   source' := [dmp,vl,T]
;   u' := domainZero(target)
;   oneT := domainOne(T)
;   plusfunc := getFunctionFromDomain("+",target,[target,target])
;   multfunc := getFunctionFromDomain("*",target,[target,target])
;   for [e,:c] in u repeat
;     (c' := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     (e' := coerceInt(objNewWrap([[e,:oneT]],source'),target)) or
;       coercionFailure()
;     t := SPADCALL(objValUnwrap(e'),objValUnwrap(c'),multfunc)
;     u' := SPADCALL(u',t,plusfunc)
;   coercionFailure()

(DEFUN |Dmp2P| (|u| |source| |target|)
  (PROG (T$ |dmp| |vl| S |t| |ISTMP#1| |mp| |p| |lexp| |vl'| |source'|
         |target'| |u'| |oneT| |plusfunc| |multfunc| |e| |c| |c'| |e'|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ |dmp| (CAR |source|))
      (SETQ |vl| (CADR . #1=(|source|)))
      (SETQ S (CADDR . #1#))
      (COND ((NULL |u|) (|domainZero| |target|))
            ((EQ |u| '|$fromCoerceable$|)
             (PROGN
              (SETQ |t| (|canCoerce| S T$))
              (COND ((NULL |t|) (|canCoerce| S |target|)) (#2='T |t|))))
            ((AND (CONSP S) (EQ (CAR S) '|Polynomial|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR S))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
             (PROGN
              (SETQ |mp|
                      (OR
                       (|coerceInt| (|objNewWrap| |u| |source|)
                        (LIST '|MultivariatePolynomial| |vl| S))
                       (|coercionFailure|)))
              (SETQ |p| (OR (|coerceInt| |mp| |target|) (|coercionFailure|)))
              (|objValUnwrap| |p|)))
            ((AND (EQL 1 (LENGTH |u|)) (EQL 1 (LENGTH |vl|)) (EQUAL S T$))
             (COND
              ((EQL (SETQ |lexp| (ELT (CAAR |u|) 0)) 0) (CONS 0 (CDAR |u|)))
              (#2# (LIST 1 (ELT |vl| 0) (CONS |lexp| (CONS 0 (CDAR |u|)))))))
            (#2#
             (PROGN
              (SETQ |vl'| (REVERSE (MSORT |vl|)))
              (SETQ |source'| (LIST |dmp| |vl'| S))
              (SETQ |target'| (LIST '|MultivariatePolynomial| |vl'| S))
              (SETQ |u'| (|sortAndReorderDmpExponents| |u| |vl|))
              (SETQ |u'| (|coerceInt| (|objNewWrap| |u'| |source'|) |target'|))
              (COND
               (|u'|
                (SETQ |u'|
                        (|translateMpVars2PVars| (|objValUnwrap| |u'|) |vl'|))
                (SETQ |u'|
                        (|coerceInt| (|objNewWrap| |u'| (LIST '|Polynomial| S))
                         |target|))))
              (COND (|u'| (|objValUnwrap| |u'|))
                    (#2#
                     (PROGN
                      (SETQ |source'| (LIST |dmp| |vl| T$))
                      (SETQ |u'| (|domainZero| |target|))
                      (SETQ |oneT| (|domainOne| T$))
                      (SETQ |plusfunc|
                              (|getFunctionFromDomain| '+ |target|
                               (LIST |target| |target|)))
                      (SETQ |multfunc|
                              (|getFunctionFromDomain| '* |target|
                               (LIST |target| |target|)))
                      ((LAMBDA (|bfVar#40| |bfVar#39|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#40|)
                                (PROGN (SETQ |bfVar#39| (CAR |bfVar#40|)) NIL))
                            (RETURN NIL))
                           (#2#
                            (AND (CONSP |bfVar#39|)
                                 (PROGN
                                  (SETQ |e| (CAR |bfVar#39|))
                                  (SETQ |c| (CDR |bfVar#39|))
                                  #2#)
                                 (PROGN
                                  (OR
                                   (SETQ |c'|
                                           (|coerceInt| (|objNewWrap| |c| S)
                                            |target|))
                                   (|coercionFailure|))
                                  (OR
                                   (SETQ |e'|
                                           (|coerceInt|
                                            (|objNewWrap|
                                             (LIST (CONS |e| |oneT|))
                                             |source'|)
                                            |target|))
                                   (|coercionFailure|))
                                  (SETQ |t|
                                          (SPADCALL (|objValUnwrap| |e'|)
                                           (|objValUnwrap| |c'|) |multfunc|))
                                  (SETQ |u'|
                                          (SPADCALL |u'| |t| |plusfunc|))))))
                          (SETQ |bfVar#40| (CDR |bfVar#40|))))
                       |u| NIL)
                      (|coercionFailure|)))))))))))

; translateMpVars2PVars (u, vl) ==
;   u is [ =1, v, :termlist] =>
;     [ 1, vl.(v-1),
;       :[[e,:translateMpVars2PVars(c,vl)] for [e,:c] in termlist]]
;   u

(DEFUN |translateMpVars2PVars| (|u| |vl|)
  (PROG (|ISTMP#1| |v| |termlist| |e| |c|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQUAL (CAR |u|) 1)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |v| (CAR |ISTMP#1|))
                   (SETQ |termlist| (CDR |ISTMP#1|))
                   #1='T))))
       (CONS 1
             (CONS (ELT |vl| (- |v| 1))
                   ((LAMBDA (|bfVar#43| |bfVar#42| |bfVar#41|)
                      (LOOP
                       (COND
                        ((OR (ATOM |bfVar#42|)
                             (PROGN (SETQ |bfVar#41| (CAR |bfVar#42|)) NIL))
                         (RETURN (NREVERSE |bfVar#43|)))
                        (#1#
                         (AND (CONSP |bfVar#41|)
                              (PROGN
                               (SETQ |e| (CAR |bfVar#41|))
                               (SETQ |c| (CDR |bfVar#41|))
                               #1#)
                              (SETQ |bfVar#43|
                                      (CONS
                                       (CONS |e|
                                             (|translateMpVars2PVars| |c|
                                              |vl|))
                                       |bfVar#43|)))))
                       (SETQ |bfVar#42| (CDR |bfVar#42|))))
                    NIL |termlist| NIL))))
      (#1# |u|)))))

; Dmp2Up(u, source is [dmp,vl,S],target is [up,var,T]) ==
;   null u =>    -- this is true if u = 0
;     domainZero(target)
;
;   u = '_$fromCoerceable_$ =>
;     member(var,vl) =>
;       vl' := remove(vl,var)
;       null vl' =>         -- no remaining variables
;         canCoerce(S,T)
;       null rest vl' =>    -- one remaining variable
;         canCoerce([up,first vl',S],T)
;       canCoerce([dmp,vl',S], T)
;     canCoerce(source,T)
;
;   -- check constant case
;   (null rest u) and (first(u) is [e,:c]) and
;     ( and/[(0 = e.i) for i in 0..(-1 + #vl)] ) =>
;       (x := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;       objValUnwrap(x)
;
;   -- check non-member case
;   null member(var,vl) =>
;     (u' := coerceInt(objNewWrap(u,source),T)) or coercionFailure()
;     [[0,:objValUnwrap u']]
;
;   vl' := remove(vl,var)
;
;   -- only one variable in DMP case
;   null vl' =>
;     u' := nreverse SORTBY('CAR,[[e.0,:c] for [e,:c] in u])
;     (u' := coerceInt(objNewWrap(u',[up,var,S]),target)) or
;       coercionFailure()
;     objValUnwrap u'
;
;   S1 := [dmp,vl',S]
;   plusfunc:= getFunctionFromDomain('_+,T,[T,T])
;   zero := getConstantFromDomain('(Zero),T)
;   x := NIL
;   pos:= POSN1(var,vl)
;   for [e,:c] in u until not y repeat
;     exp:= e.pos
;     e1:= removeVectorElt(e,pos)
;     y:= coerceInt(objNewWrap([[e1,:c]],S1),T) =>
;       -- need to be careful about zeros
;       p:= ASSQ(exp,x) =>
;         c' := SPADCALL(rest p, objValUnwrap(y), plusfunc)
;         c' = zero => x := REMALIST(x,exp)
;         RPLACD(p,c')
;       zero = objValUnwrap(y) => 'iterate
;       x := CONS(CONS(exp,objValUnwrap(y)),x)
;   y => nreverse SORTBY('CAR,x)
;   coercionFailure()

(DEFUN |Dmp2Up| (|u| |source| |target|)
  (PROG (|up| |var| T$ |dmp| |vl| S |vl'| |ISTMP#1| |e| |c| |x| |u'| S1
         |plusfunc| |zero| |pos| |exp| |e1| |y| |p| |c'|)
    (RETURN
     (PROGN
      (SETQ |up| (CAR |target|))
      (SETQ |var| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |dmp| (CAR |source|))
      (SETQ |vl| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND ((NULL |u|) (|domainZero| |target|))
            ((EQ |u| '|$fromCoerceable$|)
             (COND
              ((|member| |var| |vl|)
               (PROGN
                (SETQ |vl'| (|remove| |vl| |var|))
                (COND ((NULL |vl'|) (|canCoerce| S T$))
                      ((NULL (CDR |vl'|))
                       (|canCoerce| (LIST |up| (CAR |vl'|) S) T$))
                      (#3='T (|canCoerce| (LIST |dmp| |vl'| S) T$)))))
              (#3# (|canCoerce| |source| T$))))
            ((AND (NULL (CDR |u|))
                  (PROGN
                   (SETQ |ISTMP#1| (CAR |u|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |e| (CAR |ISTMP#1|))
                         (SETQ |c| (CDR |ISTMP#1|))
                         #3#)))
                  ((LAMBDA (|bfVar#45| |bfVar#44| |i|)
                     (LOOP
                      (COND ((> |i| |bfVar#44|) (RETURN |bfVar#45|))
                            (#3#
                             (PROGN
                              (SETQ |bfVar#45| (EQL 0 (ELT |e| |i|)))
                              (COND ((NOT |bfVar#45|) (RETURN NIL))))))
                      (SETQ |i| (+ |i| 1))))
                   T (+ (- 1) (LENGTH |vl|)) 0))
             (PROGN
              (OR (SETQ |x| (|coerceInt| (|objNewWrap| |c| S) |target|))
                  (|coercionFailure|))
              (|objValUnwrap| |x|)))
            ((NULL (|member| |var| |vl|))
             (PROGN
              (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) T$))
                  (|coercionFailure|))
              (LIST (CONS 0 (|objValUnwrap| |u'|)))))
            (#3#
             (PROGN
              (SETQ |vl'| (|remove| |vl| |var|))
              (COND
               ((NULL |vl'|)
                (PROGN
                 (SETQ |u'|
                         (NREVERSE
                          (SORTBY 'CAR
                           ((LAMBDA (|bfVar#48| |bfVar#47| |bfVar#46|)
                              (LOOP
                               (COND
                                ((OR (ATOM |bfVar#47|)
                                     (PROGN
                                      (SETQ |bfVar#46| (CAR |bfVar#47|))
                                      NIL))
                                 (RETURN (NREVERSE |bfVar#48|)))
                                (#3#
                                 (AND (CONSP |bfVar#46|)
                                      (PROGN
                                       (SETQ |e| (CAR |bfVar#46|))
                                       (SETQ |c| (CDR |bfVar#46|))
                                       #3#)
                                      (SETQ |bfVar#48|
                                              (CONS (CONS (ELT |e| 0) |c|)
                                                    |bfVar#48|)))))
                               (SETQ |bfVar#47| (CDR |bfVar#47|))))
                            NIL |u| NIL))))
                 (OR
                  (SETQ |u'|
                          (|coerceInt| (|objNewWrap| |u'| (LIST |up| |var| S))
                           |target|))
                  (|coercionFailure|))
                 (|objValUnwrap| |u'|)))
               (#3#
                (PROGN
                 (SETQ S1 (LIST |dmp| |vl'| S))
                 (SETQ |plusfunc| (|getFunctionFromDomain| '+ T$ (LIST T$ T$)))
                 (SETQ |zero| (|getConstantFromDomain| '(|Zero|) T$))
                 (SETQ |x| NIL)
                 (SETQ |pos| (POSN1 |var| |vl|))
                 ((LAMBDA (|bfVar#50| |bfVar#49| |bfVar#51|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#50|)
                           (PROGN (SETQ |bfVar#49| (CAR |bfVar#50|)) NIL)
                           |bfVar#51|)
                       (RETURN NIL))
                      (#3#
                       (AND (CONSP |bfVar#49|)
                            (PROGN
                             (SETQ |e| (CAR |bfVar#49|))
                             (SETQ |c| (CDR |bfVar#49|))
                             #3#)
                            (PROGN
                             (SETQ |exp| (ELT |e| |pos|))
                             (SETQ |e1| (|removeVectorElt| |e| |pos|))
                             (COND
                              ((SETQ |y|
                                       (|coerceInt|
                                        (|objNewWrap| (LIST (CONS |e1| |c|))
                                         S1)
                                        T$))
                               (COND
                                ((SETQ |p| (ASSQ |exp| |x|))
                                 (PROGN
                                  (SETQ |c'|
                                          (SPADCALL (CDR |p|)
                                           (|objValUnwrap| |y|) |plusfunc|))
                                  (COND
                                   ((EQUAL |c'| |zero|)
                                    (SETQ |x| (REMALIST |x| |exp|)))
                                   (#3# (RPLACD |p| |c'|)))))
                                ((EQUAL |zero| (|objValUnwrap| |y|))
                                 '|iterate|)
                                (#3#
                                 (SETQ |x|
                                         (CONS
                                          (CONS |exp| (|objValUnwrap| |y|))
                                          |x|))))))))))
                     (SETQ |bfVar#50| (CDR |bfVar#50|))
                     (SETQ |bfVar#51| (NULL |y|))))
                  |u| NIL NIL)
                 (COND (|y| (NREVERSE (SORTBY 'CAR |x|)))
                       (#3# (|coercionFailure|)))))))))))))

; removeVectorElt(v,pos) ==
;   -- removes the pos'th element from vector v
;   LIST2VEC [x for x in VEC2LIST v for y in 0.. | not (y=pos)]

(DEFUN |removeVectorElt| (|v| |pos|)
  (PROG ()
    (RETURN
     (LIST2VEC
      ((LAMBDA (|bfVar#53| |bfVar#52| |x| |y|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#52|) (PROGN (SETQ |x| (CAR |bfVar#52|)) NIL))
            (RETURN (NREVERSE |bfVar#53|)))
           ('T
            (AND (NULL (EQUAL |y| |pos|))
                 (SETQ |bfVar#53| (CONS |x| |bfVar#53|)))))
          (SETQ |bfVar#52| (CDR |bfVar#52|))
          (SETQ |y| (+ |y| 1))))
       NIL (VEC2LIST |v|) NIL 0)))))

; removeListElt(l,pos) ==
;   pos = 0 => rest l
;   [first l, :removeListElt(rest l, pos - 1)]

(DEFUN |removeListElt| (|l| |pos|)
  (PROG ()
    (RETURN
     (COND ((EQL |pos| 0) (CDR |l|))
           ('T (CONS (CAR |l|) (|removeListElt| (CDR |l|) (- |pos| 1))))))))

; NDmp2domain(u,source is [ndmp,x,S],target) ==
;   -- a null NDMP = 0
;   null u => domainZero(target)
;   dmp := 'DistributedMultivariatePolynomial
;   source' := [dmp,x,S]
;   u = '_$fromCoerceable_$ => canCoerce(source',target)
;   u' := addDmpLikeTermsAsTarget(u,source')
;   (u'' := coerceInt(objNewWrap(u',source'),target)) =>
;     objValUnwrap(u'')
;   coercionFailure()

(DEFUN |NDmp2domain| (|u| |source| |target|)
  (PROG (|ndmp| |x| S |dmp| |source'| |u'| |u''|)
    (RETURN
     (PROGN
      (SETQ |ndmp| (CAR |source|))
      (SETQ |x| (CADR . #1=(|source|)))
      (SETQ S (CADDR . #1#))
      (COND ((NULL |u|) (|domainZero| |target|))
            (#2='T
             (PROGN
              (SETQ |dmp| '|DistributedMultivariatePolynomial|)
              (SETQ |source'| (LIST |dmp| |x| S))
              (COND
               ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source'| |target|))
               (#2#
                (PROGN
                 (SETQ |u'| (|addDmpLikeTermsAsTarget| |u| |source'|))
                 (COND
                  ((SETQ |u''|
                           (|coerceInt| (|objNewWrap| |u'| |source'|)
                            |target|))
                   (|objValUnwrap| |u''|))
                  (#2# (|coercionFailure|)))))))))))))

; NDmp2NDmp(u,source is [ndmp,x,S],target is [.,y,T]) ==
;   -- a null NDMP = 0
;   null u => domainZero(target)
;   dmp := 'DistributedMultivariatePolynomial
;   source' := [dmp,x,S]
;   target' := [dmp,y,T]
;   u = '_$fromCoerceable_$ => canCoerce(source',target')
;   u' := addDmpLikeTermsAsTarget(u,source')
;   (u'' := coerceInt(objNewWrap(u',source'),target')) =>
;     addDmpLikeTermsAsTarget(objValUnwrap(u''),target)
;   coercionFailure()

(DEFUN |NDmp2NDmp| (|u| |source| |target|)
  (PROG (|y| T$ |ndmp| |x| S |dmp| |source'| |target'| |u'| |u''|)
    (RETURN
     (PROGN
      (SETQ |y| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |ndmp| (CAR |source|))
      (SETQ |x| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND ((NULL |u|) (|domainZero| |target|))
            (#3='T
             (PROGN
              (SETQ |dmp| '|DistributedMultivariatePolynomial|)
              (SETQ |source'| (LIST |dmp| |x| S))
              (SETQ |target'| (LIST |dmp| |y| T$))
              (COND
               ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source'| |target'|))
               (#3#
                (PROGN
                 (SETQ |u'| (|addDmpLikeTermsAsTarget| |u| |source'|))
                 (COND
                  ((SETQ |u''|
                           (|coerceInt| (|objNewWrap| |u'| |source'|)
                            |target'|))
                   (|addDmpLikeTermsAsTarget| (|objValUnwrap| |u''|) |target|))
                  (#3# (|coercionFailure|)))))))))))))

; Expr2Complex(u,source is [.,S], target is [.,T]) ==
;     u = '_$fromCoerceable_$ => nil   -- can't tell, in general
;
;     not member(S, [$Integer, $Float, $DoubleFloat]) => coercionFailure()
;     not member(T, [$Float, $DoubleFloat]) => coercionFailure()
;
;     complexNumeric := getFunctionFromDomain("complexNumeric", ['Numeric, S], [source])
;
;     -- the following might fail
;     cf := SPADCALL(u,complexNumeric)  -- returns a Float
;     T = $DoubleFloat =>
;         null (z := coerceInt(objNewWrap(cf, ['Complex, $Float]), ['Complex, $DoubleFloat])) =>
;             coercionFailure()
;         objValUnwrap z
;     cf

(DEFUN |Expr2Complex| (|u| |source| |target|)
  (PROG (T$ S |complexNumeric| |cf| |z|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL)
            ((NULL (|member| S (LIST |$Integer| |$Float| |$DoubleFloat|)))
             (|coercionFailure|))
            ((NULL (|member| T$ (LIST |$Float| |$DoubleFloat|)))
             (|coercionFailure|))
            (#1='T
             (PROGN
              (SETQ |complexNumeric|
                      (|getFunctionFromDomain| '|complexNumeric|
                       (LIST '|Numeric| S) (LIST |source|)))
              (SETQ |cf| (SPADCALL |u| |complexNumeric|))
              (COND
               ((EQUAL T$ |$DoubleFloat|)
                (COND
                 ((NULL
                   (SETQ |z|
                           (|coerceInt|
                            (|objNewWrap| |cf| (LIST '|Complex| |$Float|))
                            (LIST '|Complex| |$DoubleFloat|))))
                  (|coercionFailure|))
                 (#1# (|objValUnwrap| |z|))))
               (#1# |cf|)))))))))

; Expr2Dmp(u,source is [Expr,S], target is [dmp,v2,T]) ==
;     u = '_$fromCoerceable_$ => canCoerce(source, T)
;
;     null v2 =>
;         not (z := coerceInt(objNewWrap(u, source), T)) => coercionFailure()
;         [[LIST2VEC NIL, :objValUnwrap z]]
;
;     obj := objNewWrap(u, source)
;     univ := coerceInt(obj, ['UnivariatePolynomial, first v2, T])
;     not univ =>
;         T = source => coercionFailure()
;         not (z := coerceInt(obj, [dmp, v2, source])) =>
;             coercionFailure()
;         z := objValUnwrap z
;         for term in z repeat
;             [., :c] := term
;             not (c := coerceInt(objNewWrap(c, source), T)) => coercionFailure()
;             RPLACD(term, objValUnwrap c)
;         z
;
;     univ := objValUnwrap univ
;
;     -- only one variable
;
;     null rest v2 =>
;         for term in univ repeat
;             RPLACA(term, VECTOR first term)
;         univ
;
;     -- more than one variable
;
;     summands := nil
;     for [e,:c] in univ repeat
;         summands := Expr2Dmp1(summands,
;             LIST2VEC [e, :[0 for v in rest v2]], c, T, 1, rest v2, T)
;
;     plus := getFunctionFromDomain("+", target, [target, target])
;     sum  := domainZero target
;     for summand in summands repeat
;         sum := SPADCALL([summand], sum, plus)
;     sum

(DEFUN |Expr2Dmp| (|u| |source| |target|)
  (PROG (|dmp| |v2| T$ |Expr| S |z| |obj| |univ| |c| |summands| |e| |plus|
         |sum|)
    (RETURN
     (PROGN
      (SETQ |dmp| (CAR |target|))
      (SETQ |v2| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |Expr| (CAR |source|))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| T$))
            ((NULL |v2|)
             (COND
              ((NULL (SETQ |z| (|coerceInt| (|objNewWrap| |u| |source|) T$)))
               (|coercionFailure|))
              (#2='T (LIST (CONS (LIST2VEC NIL) (|objValUnwrap| |z|))))))
            (#2#
             (PROGN
              (SETQ |obj| (|objNewWrap| |u| |source|))
              (SETQ |univ|
                      (|coerceInt| |obj|
                       (LIST '|UnivariatePolynomial| (CAR |v2|) T$)))
              (COND
               ((NULL |univ|)
                (COND ((EQUAL T$ |source|) (|coercionFailure|))
                      ((NULL
                        (SETQ |z|
                                (|coerceInt| |obj|
                                 (LIST |dmp| |v2| |source|))))
                       (|coercionFailure|))
                      (#2#
                       (PROGN
                        (SETQ |z| (|objValUnwrap| |z|))
                        ((LAMBDA (|bfVar#54| |term|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#54|)
                                  (PROGN (SETQ |term| (CAR |bfVar#54|)) NIL))
                              (RETURN NIL))
                             (#2#
                              (PROGN
                               (SETQ |c| (CDR |term|))
                               (COND
                                ((NULL
                                  (SETQ |c|
                                          (|coerceInt|
                                           (|objNewWrap| |c| |source|) T$)))
                                 (|coercionFailure|))
                                (#2# (RPLACD |term| (|objValUnwrap| |c|)))))))
                            (SETQ |bfVar#54| (CDR |bfVar#54|))))
                         |z| NIL)
                        |z|))))
               (#2#
                (PROGN
                 (SETQ |univ| (|objValUnwrap| |univ|))
                 (COND
                  ((NULL (CDR |v2|))
                   (PROGN
                    ((LAMBDA (|bfVar#55| |term|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#55|)
                              (PROGN (SETQ |term| (CAR |bfVar#55|)) NIL))
                          (RETURN NIL))
                         (#2# (RPLACA |term| (VECTOR (CAR |term|)))))
                        (SETQ |bfVar#55| (CDR |bfVar#55|))))
                     |univ| NIL)
                    |univ|))
                  (#2#
                   (PROGN
                    (SETQ |summands| NIL)
                    ((LAMBDA (|bfVar#57| |bfVar#56|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#57|)
                              (PROGN (SETQ |bfVar#56| (CAR |bfVar#57|)) NIL))
                          (RETURN NIL))
                         (#2#
                          (AND (CONSP |bfVar#56|)
                               (PROGN
                                (SETQ |e| (CAR |bfVar#56|))
                                (SETQ |c| (CDR |bfVar#56|))
                                #2#)
                               (SETQ |summands|
                                       (|Expr2Dmp1| |summands|
                                        (LIST2VEC
                                         (CONS |e|
                                               ((LAMBDA
                                                    (|bfVar#59| |bfVar#58| |v|)
                                                  (LOOP
                                                   (COND
                                                    ((OR (ATOM |bfVar#58|)
                                                         (PROGN
                                                          (SETQ |v|
                                                                  (CAR
                                                                   |bfVar#58|))
                                                          NIL))
                                                     (RETURN
                                                      (NREVERSE |bfVar#59|)))
                                                    (#2#
                                                     (SETQ |bfVar#59|
                                                             (CONS 0
                                                                   |bfVar#59|))))
                                                   (SETQ |bfVar#58|
                                                           (CDR |bfVar#58|))))
                                                NIL (CDR |v2|) NIL)))
                                        |c| T$ 1 (CDR |v2|) T$)))))
                        (SETQ |bfVar#57| (CDR |bfVar#57|))))
                     |univ| NIL)
                    (SETQ |plus|
                            (|getFunctionFromDomain| '+ |target|
                             (LIST |target| |target|)))
                    (SETQ |sum| (|domainZero| |target|))
                    ((LAMBDA (|bfVar#60| |summand|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#60|)
                              (PROGN (SETQ |summand| (CAR |bfVar#60|)) NIL))
                          (RETURN NIL))
                         (#2#
                          (SETQ |sum|
                                  (SPADCALL (LIST |summand|) |sum| |plus|))))
                        (SETQ |bfVar#60| (CDR |bfVar#60|))))
                     |summands| NIL)
                    |sum|)))))))))))))

; Expr2Dmp1(summands, vec, c, source, index, varList, T) ==
;     if null varList then
;         if not (source = T) then
;             not (c := coerceInt(objNewWrap(c, source), T)) => coercionFailure()
;             c := objValUnwrap c
;         summands := [[vec, :c], :summands]
;     else
;         univ := coerceInt(objNewWrap(c, source),
;             ['UnivariatePolynomial, first varList, T])
;         univ := objValUnwrap univ
;
;         for [e,:c] in univ repeat
;             vec := COPY_-SEQ vec
;             vec.index := e
;             summands := Expr2Dmp1(summands, vec, c, T, index+1, rest varList, T)
;     summands

(DEFUN |Expr2Dmp1| (|summands| |vec| |c| |source| |index| |varList| T$)
  (PROG (|univ| |e|)
    (RETURN
     (PROGN
      (COND
       ((NULL |varList|)
        (COND
         ((NULL (EQUAL |source| T$))
          (COND
           ((NULL (SETQ |c| (|coerceInt| (|objNewWrap| |c| |source|) T$)))
            (|coercionFailure|))
           (#1='T (SETQ |c| (|objValUnwrap| |c|))))))
        (SETQ |summands| (CONS (CONS |vec| |c|) |summands|)))
       (#1#
        (SETQ |univ|
                (|coerceInt| (|objNewWrap| |c| |source|)
                 (LIST '|UnivariatePolynomial| (CAR |varList|) T$)))
        (SETQ |univ| (|objValUnwrap| |univ|))
        ((LAMBDA (|bfVar#62| |bfVar#61|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#62|)
                  (PROGN (SETQ |bfVar#61| (CAR |bfVar#62|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#61|)
                   (PROGN
                    (SETQ |e| (CAR |bfVar#61|))
                    (SETQ |c| (CDR |bfVar#61|))
                    #1#)
                   (PROGN
                    (SETQ |vec| (COPY-SEQ |vec|))
                    (SETF (ELT |vec| |index|) |e|)
                    (SETQ |summands|
                            (|Expr2Dmp1| |summands| |vec| |c| T$ (+ |index| 1)
                             (CDR |varList|) T$))))))
            (SETQ |bfVar#62| (CDR |bfVar#62|))))
         |univ| NIL)))
      |summands|))))

; Expr2Mp(u,source is [Expr,S], target is [.,v2,T]) ==
;     u = '_$fromCoerceable_$ => canCoerce(source, T)
;
;     dmp := ['DistributedMultivariatePolynomial,v2,T]
;     d   := Expr2Dmp(u,source, dmp)
;     not (m := coerceInt(objNewWrap(d, dmp), target)) => coercionFailure()
;     objValUnwrap m

(DEFUN |Expr2Mp| (|u| |source| |target|)
  (PROG (|v2| T$ |Expr| S |dmp| |d| |m|)
    (RETURN
     (PROGN
      (SETQ |v2| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |Expr| (CAR |source|))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| T$))
            (#2='T
             (PROGN
              (SETQ |dmp| (LIST '|DistributedMultivariatePolynomial| |v2| T$))
              (SETQ |d| (|Expr2Dmp| |u| |source| |dmp|))
              (COND
               ((NULL
                 (SETQ |m| (|coerceInt| (|objNewWrap| |d| |dmp|) |target|)))
                (|coercionFailure|))
               (#2# (|objValUnwrap| |m|))))))))))

; Expr2Up(u,source is [Expr,S], target is [.,var,T]) ==
;     u = '_$fromCoerceable_$ => canCoerce(source, T)
;     kernelFunc := getFunctionFromDomain("kernels", source, [source])
;     kernelDom  := ['Kernel, source]
;     nameFunc   := getFunctionFromDomain("name", kernelDom, [kernelDom])
;     kernels    := SPADCALL(u,kernelFunc)
;     v1         := [SPADCALL(kernel, nameFunc) for kernel in kernels]
;
;     not member(var, v1) => coercionFailure()
;
;     -- variable is a kernel
;
;     varKernel  := kernels.(POSN1(var, v1))
;     univFunc   := getFunctionFromDomain("univariate", source, [source, kernelDom])
;     sup        := ['SparseUnivariatePolynomial, source]
;
;     fracUniv   := SPADCALL(u, varKernel, univFunc)
;     denom      := rest fracUniv
;
;     not equalOne(denom, sup) => coercionFailure()
;
;     numer      := first fracUniv
;     uniType := ['UnivariatePolynomial, var, source]
;     (z := coerceInt(objNewWrap(numer, uniType), target)) => objValUnwrap z
;     coercionFailure()

(DEFUN |Expr2Up| (|u| |source| |target|)
  (PROG (|var| T$ |Expr| S |kernelFunc| |kernelDom| |nameFunc| |kernels| |v1|
         |varKernel| |univFunc| |sup| |fracUniv| |denom| |numer| |uniType| |z|)
    (RETURN
     (PROGN
      (SETQ |var| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |Expr| (CAR |source|))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| T$))
            (#2='T
             (PROGN
              (SETQ |kernelFunc|
                      (|getFunctionFromDomain| '|kernels| |source|
                       (LIST |source|)))
              (SETQ |kernelDom| (LIST '|Kernel| |source|))
              (SETQ |nameFunc|
                      (|getFunctionFromDomain| '|name| |kernelDom|
                       (LIST |kernelDom|)))
              (SETQ |kernels| (SPADCALL |u| |kernelFunc|))
              (SETQ |v1|
                      ((LAMBDA (|bfVar#64| |bfVar#63| |kernel|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#63|)
                                (PROGN (SETQ |kernel| (CAR |bfVar#63|)) NIL))
                            (RETURN (NREVERSE |bfVar#64|)))
                           (#2#
                            (SETQ |bfVar#64|
                                    (CONS (SPADCALL |kernel| |nameFunc|)
                                          |bfVar#64|))))
                          (SETQ |bfVar#63| (CDR |bfVar#63|))))
                       NIL |kernels| NIL))
              (COND ((NULL (|member| |var| |v1|)) (|coercionFailure|))
                    (#2#
                     (PROGN
                      (SETQ |varKernel| (ELT |kernels| (POSN1 |var| |v1|)))
                      (SETQ |univFunc|
                              (|getFunctionFromDomain| '|univariate| |source|
                               (LIST |source| |kernelDom|)))
                      (SETQ |sup|
                              (LIST '|SparseUnivariatePolynomial| |source|))
                      (SETQ |fracUniv| (SPADCALL |u| |varKernel| |univFunc|))
                      (SETQ |denom| (CDR |fracUniv|))
                      (COND
                       ((NULL (|equalOne| |denom| |sup|)) (|coercionFailure|))
                       (#2#
                        (PROGN
                         (SETQ |numer| (CAR |fracUniv|))
                         (SETQ |uniType|
                                 (LIST '|UnivariatePolynomial| |var| |source|))
                         (COND
                          ((SETQ |z|
                                   (|coerceInt|
                                    (|objNewWrap| |numer| |uniType|) |target|))
                           (|objValUnwrap| |z|))
                          (#2# (|coercionFailure|))))))))))))))))

; Ker2Ker(u,source is [.,S], target is [.,T]) ==
;   u = '_$fromCoerceable_$ => canCoerce(S, T)
;   not (m := coerceInt(objNewWrap(u, source), S)) => coercionFailure()
;   u' := objValUnwrap m
;   not (m' := coerceInt(objNewWrap(u', S), T)) => coercionFailure()
;   u'' := objValUnwrap m'
;   not (m'' := coerceInt(objNewWrap(u'', T), target)) => coercionFailure()
;   objValUnwrap m''

(DEFUN |Ker2Ker| (|u| |source| |target|)
  (PROG (T$ S |m| |u'| |m'| |u''| |m''|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S T$))
            ((NULL (SETQ |m| (|coerceInt| (|objNewWrap| |u| |source|) S)))
             (|coercionFailure|))
            (#1='T
             (PROGN
              (SETQ |u'| (|objValUnwrap| |m|))
              (COND
               ((NULL (SETQ |m'| (|coerceInt| (|objNewWrap| |u'| S) T$)))
                (|coercionFailure|))
               (#1#
                (PROGN
                 (SETQ |u''| (|objValUnwrap| |m'|))
                 (COND
                  ((NULL
                    (SETQ |m''|
                            (|coerceInt| (|objNewWrap| |u''| T$) |target|)))
                   (|coercionFailure|))
                  (#1# (|objValUnwrap| |m''|)))))))))))))

; Ker2Expr(u,source is [.,S], target) ==
;   u = '_$fromCoerceable_$ => canCoerce(S, target)
;   not (m := coerceByFunction(objNewWrap(u, source), S)) => coercionFailure()
;   u':= objValUnwrap m
;   not (m' := coerceInt(objNewWrap(u', S), target)) => coercionFailure()
;   objValUnwrap m'

(DEFUN |Ker2Expr| (|u| |source| |target|)
  (PROG (S |m| |u'| |m'|)
    (RETURN
     (PROGN
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S |target|))
            ((NULL
              (SETQ |m| (|coerceByFunction| (|objNewWrap| |u| |source|) S)))
             (|coercionFailure|))
            (#1='T
             (PROGN
              (SETQ |u'| (|objValUnwrap| |m|))
              (COND
               ((NULL (SETQ |m'| (|coerceInt| (|objNewWrap| |u'| S) |target|)))
                (|coercionFailure|))
               (#1# (|objValUnwrap| |m'|))))))))))

; Factored2Factored(u,oldmode,newmode) ==
;   [.,oldargmode,:.]:= oldmode
;   [.,newargmode,:.]:= newmode
;   u = '_$fromCoerceable_$ => canCoerce(oldargmode,newargmode)
;   u' := unwrap u
;   unit' := coerceInt(objNewWrap(first u',oldargmode),newargmode)
;   null unit' => coercionFailure()
;   factors := IFCDR u'
;   factors' := [(coerceFFE(x,oldargmode,newargmode)) for x in factors]
;   member('failed,factors') => coercionFailure()
;   [objValUnwrap(unit'),:factors']

(DEFUN |Factored2Factored| (|u| |oldmode| |newmode|)
  (PROG (|oldargmode| |newargmode| |u'| |unit'| |factors| |factors'|)
    (RETURN
     (PROGN
      (SETQ |oldargmode| (CADR |oldmode|))
      (SETQ |newargmode| (CADR |newmode|))
      (COND
       ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |oldargmode| |newargmode|))
       (#1='T
        (PROGN
         (SETQ |u'| (|unwrap| |u|))
         (SETQ |unit'|
                 (|coerceInt| (|objNewWrap| (CAR |u'|) |oldargmode|)
                  |newargmode|))
         (COND ((NULL |unit'|) (|coercionFailure|))
               (#1#
                (PROGN
                 (SETQ |factors| (IFCDR |u'|))
                 (SETQ |factors'|
                         ((LAMBDA (|bfVar#66| |bfVar#65| |x|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#65|)
                                   (PROGN (SETQ |x| (CAR |bfVar#65|)) NIL))
                               (RETURN (NREVERSE |bfVar#66|)))
                              (#1#
                               (SETQ |bfVar#66|
                                       (CONS
                                        (|coerceFFE| |x| |oldargmode|
                                         |newargmode|)
                                        |bfVar#66|))))
                             (SETQ |bfVar#65| (CDR |bfVar#65|))))
                          NIL |factors| NIL))
                 (COND ((|member| '|failed| |factors'|) (|coercionFailure|))
                       (#1#
                        (CONS (|objValUnwrap| |unit'|) |factors'|)))))))))))))

; coerceFFE(ffe, oldmode, newmode) ==
;   fac' := coerceInt(objNewWrap(ffe.1,oldmode),newmode)
;   null fac' => 'failed
;   LIST2VEC [ffe.0,objValUnwrap(fac'),ffe.2]

(DEFUN |coerceFFE| (|ffe| |oldmode| |newmode|)
  (PROG (|fac'|)
    (RETURN
     (PROGN
      (SETQ |fac'|
              (|coerceInt| (|objNewWrap| (ELT |ffe| 1) |oldmode|) |newmode|))
      (COND ((NULL |fac'|) '|failed|)
            ('T
             (LIST2VEC
              (LIST (ELT |ffe| 0) (|objValUnwrap| |fac'|) (ELT |ffe| 2)))))))))

; Complex2underDomain(u,[.,S],target) ==
;   u = '_$fromCoerceable_$ => nil
;   [r,:i] := u
;   i=domainZero(S) =>
;     [r',.,.]:= coerceInt(objNewWrap(r,S),target) or
;       coercionFailure()
;     r'
;   coercionFailure()

(DEFUN |Complex2underDomain| (|u| |bfVar#67| |target|)
  (PROG (S |r| |i| |LETTMP#1| |r'|)
    (RETURN
     (PROGN
      (SETQ S (CADR |bfVar#67|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL)
            (#1='T
             (PROGN
              (SETQ |r| (CAR |u|))
              (SETQ |i| (CDR |u|))
              (COND
               ((EQUAL |i| (|domainZero| S))
                (PROGN
                 (SETQ |LETTMP#1|
                         (OR (|coerceInt| (|objNewWrap| |r| S) |target|)
                             (|coercionFailure|)))
                 (SETQ |r'| (CAR |LETTMP#1|))
                 |r'|))
               (#1# (|coercionFailure|))))))))))

; Complex2FR(u,S is [.,R],target is [.,T]) ==
;   u = '_$fromCoerceable_$ =>
;     S ~= T => nil
;     R = $Integer => true
;     nil
;   S ~= T => coercionFailure()
;   package :=
;     R = $Integer => ['GaussianFactorizationPackage]
;     coercionFailure()
;   factor := getFunctionFromDomain('factor,package,[S])
;   SPADCALL(u,factor)

(DEFUN |Complex2FR| (|u| S |target|)
  (PROG (T$ R |package| |factor|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ R (CADR S))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND ((NOT (EQUAL S T$)) NIL) ((EQUAL R |$Integer|) T) (#1='T NIL)))
       ((NOT (EQUAL S T$)) (|coercionFailure|))
       (#1#
        (PROGN
         (SETQ |package|
                 (COND
                  ((EQUAL R |$Integer|) (LIST '|GaussianFactorizationPackage|))
                  (#1# (|coercionFailure|))))
         (SETQ |factor| (|getFunctionFromDomain| '|factor| |package| (LIST S)))
         (SPADCALL |u| |factor|))))))))

; Complex2Expr(u, source is [.,S], target is [., T]) ==
;   u = '_$fromCoerceable_$ =>
;     T is ['Complex, T1] and canCoerceFrom(S, T1) or coercionFailure()
;   E := defaultTargetFE source
;   negOne := coerceInt(objNewWrap(-1, $Integer), E)
;   null negOne => coercionFailure()
;   sqrtFun := getFunctionFromDomain('sqrt, E, [E])
;   i := SPADCALL(objValUnwrap negOne, sqrtFun)
;   realFun := getFunctionFromDomain('real, source, [source])
;   imagFun := getFunctionFromDomain('imag, source, [source])
;   real := SPADCALL(u, realFun)
;   imag := SPADCALL(u, imagFun)
;   realExp := coerceInt(objNewWrap(real, S), E)
;   null realExp => coercionFailure()
;   imagExp := coerceInt(objNewWrap(imag, S), E)
;   null imagExp => coercionFailure()
;   timesFun := getFunctionFromDomain('_*, E, [E, E])
;   plusFun  := getFunctionFromDomain('_+, E, [E, E])
;   newVal := SPADCALL(objValUnwrap(realExp),
;              SPADCALL(i, objValUnwrap imagExp, timesFun), plusFun)
;   newObj := objNewWrap(newVal, E)
;   finalObj := coerceInt(newObj, target)
;   finalObj => objValUnwrap finalObj
;   coercionFailure()

(DEFUN |Complex2Expr| (|u| |source| |target|)
  (PROG (T$ S |ISTMP#1| T1 E |negOne| |sqrtFun| |i| |realFun| |imagFun| |real|
         |imag| |realExp| |imagExp| |timesFun| |plusFun| |newVal| |newObj|
         |finalObj|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR
         (AND (CONSP T$) (EQ (CAR T$) '|Complex|)
              (PROGN
               (SETQ |ISTMP#1| (CDR T$))
               (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                    (PROGN (SETQ T1 (CAR |ISTMP#1|)) #1='T)))
              (|canCoerceFrom| S T1))
         (|coercionFailure|)))
       (#1#
        (PROGN
         (SETQ E (|defaultTargetFE| |source|))
         (SETQ |negOne| (|coerceInt| (|objNewWrap| (- 1) |$Integer|) E))
         (COND ((NULL |negOne|) (|coercionFailure|))
               (#1#
                (PROGN
                 (SETQ |sqrtFun| (|getFunctionFromDomain| '|sqrt| E (LIST E)))
                 (SETQ |i| (SPADCALL (|objValUnwrap| |negOne|) |sqrtFun|))
                 (SETQ |realFun|
                         (|getFunctionFromDomain| '|real| |source|
                          (LIST |source|)))
                 (SETQ |imagFun|
                         (|getFunctionFromDomain| '|imag| |source|
                          (LIST |source|)))
                 (SETQ |real| (SPADCALL |u| |realFun|))
                 (SETQ |imag| (SPADCALL |u| |imagFun|))
                 (SETQ |realExp| (|coerceInt| (|objNewWrap| |real| S) E))
                 (COND ((NULL |realExp|) (|coercionFailure|))
                       (#1#
                        (PROGN
                         (SETQ |imagExp|
                                 (|coerceInt| (|objNewWrap| |imag| S) E))
                         (COND ((NULL |imagExp|) (|coercionFailure|))
                               (#1#
                                (PROGN
                                 (SETQ |timesFun|
                                         (|getFunctionFromDomain| '* E
                                          (LIST E E)))
                                 (SETQ |plusFun|
                                         (|getFunctionFromDomain| '+ E
                                          (LIST E E)))
                                 (SETQ |newVal|
                                         (SPADCALL (|objValUnwrap| |realExp|)
                                          (SPADCALL |i|
                                           (|objValUnwrap| |imagExp|)
                                           |timesFun|)
                                          |plusFun|))
                                 (SETQ |newObj| (|objNewWrap| |newVal| E))
                                 (SETQ |finalObj|
                                         (|coerceInt| |newObj| |target|))
                                 (COND (|finalObj| (|objValUnwrap| |finalObj|))
                                       (#1#
                                        (|coercionFailure|)))))))))))))))))))

; I2PI(n,source,target) ==
;   n = '_$fromCoerceable_$ => nil
;   if n > 0 then n else coercionFailure()

(DEFUN I2PI (|n| |source| |target|)
  (PROG ()
    (RETURN
     (COND ((EQ |n| '|$fromCoerceable$|) NIL)
           (#1='T (COND ((< 0 |n|) |n|) (#1# (|coercionFailure|))))))))

; I2NNI(n,source,target) ==
;   n = '_$fromCoerceable_$ => nil
;   if n >= 0 then n else coercionFailure()

(DEFUN I2NNI (|n| |source| |target|)
  (PROG ()
    (RETURN
     (COND ((EQ |n| '|$fromCoerceable$|) NIL)
           (#1='T (COND ((NOT (MINUSP |n|)) |n|) (#1# (|coercionFailure|))))))))

; L2Tuple(val, source is [.,S], target is [.,T]) ==
;     val = '_$fromCoerceable_$ => canCoerce(S,T)
;     null (object := coerceInt1(mkObjWrap(val,source), ['List, T])) =>
;       coercionFailure()
;     asTupleNew0 objValUnwrap object

(DEFUN |L2Tuple| (|val| |source| |target|)
  (PROG (T$ S |object|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |source|))
      (COND ((EQ |val| '|$fromCoerceable$|) (|canCoerce| S T$))
            ((NULL
              (SETQ |object|
                      (|coerceInt1| (|mkObjWrap| |val| |source|)
                       (LIST '|List| T$))))
             (|coercionFailure|))
            ('T (|asTupleNew0| (|objValUnwrap| |object|))))))))

; L2DP(l, source is [.,S], target is [.,n,T]) ==
;   -- need to know size of the list
;   l = '_$fromCoerceable_$ => nil
;   n ~= SIZE l => coercionFailure()
;   (v := coerceInt(objNewWrap(LIST2VEC l,['Vector,S]),['Vector,T])) or
;     coercionFailure()
;   V2DP(objValUnwrap v, ['Vector, T], target)

(DEFUN L2DP (|l| |source| |target|)
  (PROG (|n| T$ S |v|)
    (RETURN
     (PROGN
      (SETQ |n| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ S (CADR |source|))
      (COND ((EQ |l| '|$fromCoerceable$|) NIL)
            ((NOT (EQL |n| (SIZE |l|))) (|coercionFailure|))
            ('T
             (PROGN
              (OR
               (SETQ |v|
                       (|coerceInt|
                        (|objNewWrap| (LIST2VEC |l|) (LIST '|Vector| S))
                        (LIST '|Vector| T$)))
               (|coercionFailure|))
              (V2DP (|objValUnwrap| |v|) (LIST '|Vector| T$) |target|))))))))

; V2DP(v, source is [.,S], target is [.,n,T]) ==
;   -- need to know size of the vector
;   v = '_$fromCoerceable_$ => nil
;   n ~= SIZE v => coercionFailure()
;   (v1 := coerceInt(objNewWrap(v,source),['Vector,T])) or
;     coercionFailure()
;   dpFun  := getFunctionFromDomain('directProduct, target, [['Vector,T]])
;   SPADCALL(objValUnwrap v1, dpFun)

(DEFUN V2DP (|v| |source| |target|)
  (PROG (|n| T$ S |v1| |dpFun|)
    (RETURN
     (PROGN
      (SETQ |n| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ S (CADR |source|))
      (COND ((EQ |v| '|$fromCoerceable$|) NIL)
            ((NOT (EQL |n| (SIZE |v|))) (|coercionFailure|))
            ('T
             (PROGN
              (OR
               (SETQ |v1|
                       (|coerceInt| (|objNewWrap| |v| |source|)
                        (LIST '|Vector| T$)))
               (|coercionFailure|))
              (SETQ |dpFun|
                      (|getFunctionFromDomain| '|directProduct| |target|
                       (LIST (LIST '|Vector| T$))))
              (SPADCALL (|objValUnwrap| |v1|) |dpFun|))))))))

; L2V(l, source is [.,S], target is [.,T]) ==
;   l = '_$fromCoerceable_$ => canCoerce(S,T)
;   (v := coerceInt(objNewWrap(LIST2VEC l,['Vector,S]),target)) or
;     coercionFailure()
;   objValUnwrap(v)

(DEFUN L2V (|l| |source| |target|)
  (PROG (T$ S |v|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |source|))
      (COND ((EQ |l| '|$fromCoerceable$|) (|canCoerce| S T$))
            ('T
             (PROGN
              (OR
               (SETQ |v|
                       (|coerceInt|
                        (|objNewWrap| (LIST2VEC |l|) (LIST '|Vector| S))
                        |target|))
               (|coercionFailure|))
              (|objValUnwrap| |v|))))))))

; V2L(v, source is [.,S], target is [.,T]) ==
;   v = '_$fromCoerceable_$ => canCoerce(S,T)
;   (l := coerceInt(objNewWrap(VEC2LIST v,['List,S]),target)) or
;     coercionFailure()
;   objValUnwrap(l)

(DEFUN V2L (|v| |source| |target|)
  (PROG (T$ S |l|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |source|))
      (COND ((EQ |v| '|$fromCoerceable$|) (|canCoerce| S T$))
            ('T
             (PROGN
              (OR
               (SETQ |l|
                       (|coerceInt|
                        (|objNewWrap| (VEC2LIST |v|) (LIST '|List| S))
                        |target|))
               (|coercionFailure|))
              (|objValUnwrap| |l|))))))))

; L2M(u,[.,D],[.,R]) ==
;   u = '_$fromCoerceable_$ => nil
;   D is ['List,E] and isRectangularList(u, n := #u, m :=# first u) =>
;     v := MAKE_MATRIX(n, m)
;     for x in u for i in 0..(n-1) repeat
;       for y in x for j in 0..(m-1) repeat
;         (y' := coerceInt(objNewWrap(y,E),R)) or coercionFailure()
;         QSETAREF2O(v, i, j, objValUnwrap(y'), 0, 0)
;     v
;   coercionFailure()

(DEFUN L2M (|u| |bfVar#72| |bfVar#73|)
  (PROG (R D |ISTMP#1| E |n| |m| |v| |y'|)
    (RETURN
     (PROGN
      (SETQ R (CADR |bfVar#73|))
      (SETQ D (CADR |bfVar#72|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL)
            ((AND (CONSP D) (EQ (CAR D) '|List|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR D))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ E (CAR |ISTMP#1|)) #1='T)))
                  (|isRectangularList| |u| (SETQ |n| (LENGTH |u|))
                   (SETQ |m| (LENGTH (CAR |u|)))))
             (PROGN
              (SETQ |v| (MAKE_MATRIX |n| |m|))
              ((LAMBDA (|bfVar#68| |x| |bfVar#69| |i|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#68|)
                        (PROGN (SETQ |x| (CAR |bfVar#68|)) NIL)
                        (> |i| |bfVar#69|))
                    (RETURN NIL))
                   (#1#
                    ((LAMBDA (|bfVar#70| |y| |bfVar#71| |j|)
                       (LOOP
                        (COND
                         ((OR (ATOM |bfVar#70|)
                              (PROGN (SETQ |y| (CAR |bfVar#70|)) NIL)
                              (> |j| |bfVar#71|))
                          (RETURN NIL))
                         (#1#
                          (PROGN
                           (OR (SETQ |y'| (|coerceInt| (|objNewWrap| |y| E) R))
                               (|coercionFailure|))
                           (QSETAREF2O |v| |i| |j| (|objValUnwrap| |y'|) 0
                            0))))
                        (SETQ |bfVar#70| (CDR |bfVar#70|))
                        (SETQ |j| (+ |j| 1))))
                     |x| NIL (- |m| 1) 0)))
                  (SETQ |bfVar#68| (CDR |bfVar#68|))
                  (SETQ |i| (+ |i| 1))))
               |u| NIL (- |n| 1) 0)
              |v|))
            (#1# (|coercionFailure|)))))))

; L2Record(l,[.,D],[.,:al]) ==
;   l = '_$fromCoerceable_$ => nil
;   #l = #al =>
;     v:= [u for x in l for [":",.,D'] in al] where u ==
;       T:= coerceInt(objNewWrap(x,D),D') or return 'failed
;       objValUnwrap(T)
;     v = 'failed => coercionFailure()
;     #v = 2 => [v.0,:v.1]
;     LIST2VEC v
;   coercionFailure()

(DEFUN |L2Record| (|l| |bfVar#78| |bfVar#79|)
  (PROG (|al| D |ISTMP#1| |ISTMP#2| |D'| T$ |v|)
    (RETURN
     (PROGN
      (SETQ |al| (CDR |bfVar#79|))
      (SETQ D (CADR |bfVar#78|))
      (COND ((EQ |l| '|$fromCoerceable$|) NIL)
            ((EQL (LENGTH |l|) (LENGTH |al|))
             (PROGN
              (SETQ |v|
                      ((LAMBDA
                           (|bfVar#77| |bfVar#74| |x| |bfVar#76| |bfVar#75|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#74|)
                                (PROGN (SETQ |x| (CAR |bfVar#74|)) NIL)
                                (ATOM |bfVar#76|)
                                (PROGN (SETQ |bfVar#75| (CAR |bfVar#76|)) NIL))
                            (RETURN (NREVERSE |bfVar#77|)))
                           (#1='T
                            (AND (CONSP |bfVar#75|) (EQ (CAR |bfVar#75|) '|:|)
                                 (PROGN
                                  (SETQ |ISTMP#1| (CDR |bfVar#75|))
                                  (AND (CONSP |ISTMP#1|)
                                       (PROGN
                                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                        (AND (CONSP |ISTMP#2|)
                                             (EQ (CDR |ISTMP#2|) NIL)
                                             (PROGN
                                              (SETQ |D'| (CAR |ISTMP#2|))
                                              #1#)))))
                                 (SETQ |bfVar#77|
                                         (CONS
                                          (PROGN
                                           (SETQ T$
                                                   (OR
                                                    (|coerceInt|
                                                     (|objNewWrap| |x| D) |D'|)
                                                    (RETURN '|failed|)))
                                           (|objValUnwrap| T$))
                                          |bfVar#77|)))))
                          (SETQ |bfVar#74| (CDR |bfVar#74|))
                          (SETQ |bfVar#76| (CDR |bfVar#76|))))
                       NIL |l| NIL |al| NIL))
              (COND ((EQ |v| '|failed|) (|coercionFailure|))
                    ((EQL (LENGTH |v|) 2) (CONS (ELT |v| 0) (ELT |v| 1)))
                    (#1# (LIST2VEC |v|)))))
            (#1# (|coercionFailure|)))))))

; L2Rm(u,source is [.,D],target is [.,n,m,R]) ==
;   u = '_$fromCoerceable_$ => nil
;   D is ['List,E] and isRectangularList(u,n,m) =>
;     L2M(u,source,['Matrix,R])
;   coercionFailure()

(DEFUN |L2Rm| (|u| |source| |target|)
  (PROG (|n| |m| R D |ISTMP#1| E)
    (RETURN
     (PROGN
      (SETQ |n| (CADR . #1=(|target|)))
      (SETQ |m| (CADDR . #1#))
      (SETQ R (CADDDR . #1#))
      (SETQ D (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL)
            ((AND (CONSP D) (EQ (CAR D) '|List|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR D))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ E (CAR |ISTMP#1|)) #2='T)))
                  (|isRectangularList| |u| |n| |m|))
             (L2M |u| |source| (LIST '|Matrix| R)))
            (#2# (|coercionFailure|)))))))

; L2Sm(u,source is [.,D],[.,n,R]) ==
;   u = '_$fromCoerceable_$ => nil
;   D is ['List,E] and isRectangularList(u,n,n) =>
;     L2M(u,source,['Matrix,R])
;   coercionFailure()

(DEFUN |L2Sm| (|u| |source| |bfVar#80|)
  (PROG (|n| R D |ISTMP#1| E)
    (RETURN
     (PROGN
      (SETQ |n| (CADR . #1=(|bfVar#80|)))
      (SETQ R (CADDR . #1#))
      (SETQ D (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL)
            ((AND (CONSP D) (EQ (CAR D) '|List|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR D))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ E (CAR |ISTMP#1|)) #2='T)))
                  (|isRectangularList| |u| |n| |n|))
             (L2M |u| |source| (LIST '|Matrix| R)))
            (#2# (|coercionFailure|)))))))

; L2Set(x,source is [.,S],target is [.,T]) ==
;   x = '_$fromCoerceable_$ => canCoerce(S,T)
;   -- call library function set to get a set
;   target' := ['Set,S]
;   u := objNewWrap(
;     SPADCALL(x, getFunctionFromDomain1('set, target', target', [source])),
;       target')
;   (u := coerceInt(u,target)) or coercionFailure()
;   objValUnwrap u

(DEFUN |L2Set| (|x| |source| |target|)
  (PROG (T$ S |target'| |u|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |source|))
      (COND ((EQ |x| '|$fromCoerceable$|) (|canCoerce| S T$))
            ('T
             (PROGN
              (SETQ |target'| (LIST '|Set| S))
              (SETQ |u|
                      (|objNewWrap|
                       (SPADCALL |x|
                        (|getFunctionFromDomain1| '|set| |target'| |target'|
                         (LIST |source|)))
                       |target'|))
              (OR (SETQ |u| (|coerceInt| |u| |target|)) (|coercionFailure|))
              (|objValUnwrap| |u|))))))))

; Set2L(x,source is [.,S],target is [.,T]) ==
;   x = '_$fromCoerceable_$ => canCoerce(S,T)
;   -- call library function  destruct  to get a list
;   u := objNewWrap(
;     SPADCALL(x,getFunctionFromDomain('destruct,source,[source])),
;       ['List,S])
;   (u := coerceInt(u,target)) or coercionFailure()
;   objValUnwrap u

(DEFUN |Set2L| (|x| |source| |target|)
  (PROG (T$ S |u|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |source|))
      (COND ((EQ |x| '|$fromCoerceable$|) (|canCoerce| S T$))
            ('T
             (PROGN
              (SETQ |u|
                      (|objNewWrap|
                       (SPADCALL |x|
                        (|getFunctionFromDomain| '|destruct| |source|
                         (LIST |source|)))
                       (LIST '|List| S)))
              (OR (SETQ |u| (|coerceInt| |u| |target|)) (|coercionFailure|))
              (|objValUnwrap| |u|))))))))

; Agg2Agg(x,source is [agg1,S],target is [.,T]) ==
;   x = '_$fromCoerceable_$ => canCoerce(S,T)
;   S = T => coercionFailure()         -- library function
;   target' := [agg1,T]
;   (u := coerceInt(objNewWrap(x,source),target')) or coercionFailure()
;   (u := coerceInt(u,target)) or coercionFailure()
;   objValUnwrap u

(DEFUN |Agg2Agg| (|x| |source| |target|)
  (PROG (T$ |agg1| S |target'| |u|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ |agg1| (CAR |source|))
      (SETQ S (CADR |source|))
      (COND ((EQ |x| '|$fromCoerceable$|) (|canCoerce| S T$))
            ((EQUAL S T$) (|coercionFailure|))
            ('T
             (PROGN
              (SETQ |target'| (LIST |agg1| T$))
              (OR
               (SETQ |u| (|coerceInt| (|objNewWrap| |x| |source|) |target'|))
               (|coercionFailure|))
              (OR (SETQ |u| (|coerceInt| |u| |target|)) (|coercionFailure|))
              (|objValUnwrap| |u|))))))))

; Agg2L2Agg(x,source is [.,S],target) ==
;   -- tries to use list as an intermediate type
;   mid := ['List,S]
;   x = '_$fromCoerceable_$ =>
;     canCoerce(source,mid) and canCoerce(mid,target)
;   (u := coerceInt(objNewWrap(x,source),mid)) or coercionFailure()
;   (u := coerceInt(u,target)) or coercionFailure()
;   objValUnwrap u

(DEFUN |Agg2L2Agg| (|x| |source| |target|)
  (PROG (S |mid| |u|)
    (RETURN
     (PROGN
      (SETQ S (CADR |source|))
      (SETQ |mid| (LIST '|List| S))
      (COND
       ((EQ |x| '|$fromCoerceable$|)
        (AND (|canCoerce| |source| |mid|) (|canCoerce| |mid| |target|)))
       ('T
        (PROGN
         (OR (SETQ |u| (|coerceInt| (|objNewWrap| |x| |source|) |mid|))
             (|coercionFailure|))
         (OR (SETQ |u| (|coerceInt| |u| |target|)) (|coercionFailure|))
         (|objValUnwrap| |u|))))))))

; isRectangularList(x,p,q) ==
;   p=0 or p=#x =>
;     n:= #first x
;     and/[n=#y for y in rest x] => p=0 or q=n

(DEFUN |isRectangularList| (|x| |p| |q|)
  (PROG (|n|)
    (RETURN
     (COND
      ((OR (EQL |p| 0) (EQL |p| (LENGTH |x|)))
       (IDENTITY
        (PROGN
         (SETQ |n| (LENGTH (CAR |x|)))
         (COND
          (((LAMBDA (|bfVar#82| |bfVar#81| |y|)
              (LOOP
               (COND
                ((OR (ATOM |bfVar#81|) (PROGN (SETQ |y| (CAR |bfVar#81|)) NIL))
                 (RETURN |bfVar#82|))
                ('T
                 (PROGN
                  (SETQ |bfVar#82| (EQL |n| (LENGTH |y|)))
                  (COND ((NOT |bfVar#82|) (RETURN NIL))))))
               (SETQ |bfVar#81| (CDR |bfVar#81|))))
            T (CDR |x|) NIL)
           (OR (EQL |p| 0) (EQUAL |q| |n|)))))))))))

; M2VV(x) ==
;     n := ANROWS(x)
;     m := ANCOLS(x)
;     v := MAKE_-ARRAY(n)
;     for i in 0..(n - 1) repeat
;         vi := MAKE_-ARRAY(m)
;         for j in 0..(m - 1) repeat
;             QSETAREF1(vi, j, QAREF2O(x, i, j, 0, 0))
;         QSETAREF1(v, i, vi)
;     v

(DEFUN M2VV (|x|)
  (PROG (|n| |m| |v| |vi|)
    (RETURN
     (PROGN
      (SETQ |n| (ANROWS |x|))
      (SETQ |m| (ANCOLS |x|))
      (SETQ |v| (MAKE-ARRAY |n|))
      ((LAMBDA (|bfVar#83| |i|)
         (LOOP
          (COND ((> |i| |bfVar#83|) (RETURN NIL))
                (#1='T
                 (PROGN
                  (SETQ |vi| (MAKE-ARRAY |m|))
                  ((LAMBDA (|bfVar#84| |j|)
                     (LOOP
                      (COND ((> |j| |bfVar#84|) (RETURN NIL))
                            (#1#
                             (QSETAREF1 |vi| |j| (QAREF2O |x| |i| |j| 0 0))))
                      (SETQ |j| (+ |j| 1))))
                   (- |m| 1) 0)
                  (QSETAREF1 |v| |i| |vi|))))
          (SETQ |i| (+ |i| 1))))
       (- |n| 1) 0)
      |v|))))

; M2L(x,[.,S],target) ==
;   mid := ['Vector,['Vector,S]]
;   x = '_$fromCoerceable_$ => canCoerce(mid,target)
;   (u := coerceInt(objNewWrap(M2VV x, mid), target)) or coercionFailure()
;   objValUnwrap u

(DEFUN M2L (|x| |bfVar#85| |target|)
  (PROG (S |mid| |u|)
    (RETURN
     (PROGN
      (SETQ S (CADR |bfVar#85|))
      (SETQ |mid| (LIST '|Vector| (LIST '|Vector| S)))
      (COND ((EQ |x| '|$fromCoerceable$|) (|canCoerce| |mid| |target|))
            ('T
             (PROGN
              (OR
               (SETQ |u|
                       (|coerceInt| (|objNewWrap| (M2VV |x|) |mid|) |target|))
               (|coercionFailure|))
              (|objValUnwrap| |u|))))))))

; M2M(x,[.,R],[.,S]) ==
;     x = '_$fromCoerceable_$ => canCoerce(R,S)
;     n := ANROWS(x)
;     m := ANCOLS(x)
;     v := MAKE_MATRIX(n, m)
;     for i in 0..(n - 1) repeat
;         for j in 0..(m - 1) repeat
;             y := QAREF2O(x, i, j, 0, 0)
;             (y' := coerceInt(objNewWrap(y, R), S)) or coercionFailure()
;             QSETAREF2O(v, i, j, objValUnwrap y', 0, 0)
;     v

(DEFUN M2M (|x| |bfVar#88| |bfVar#89|)
  (PROG (S R |n| |m| |v| |y| |y'|)
    (RETURN
     (PROGN
      (SETQ S (CADR |bfVar#89|))
      (SETQ R (CADR |bfVar#88|))
      (COND ((EQ |x| '|$fromCoerceable$|) (|canCoerce| R S))
            (#1='T
             (PROGN
              (SETQ |n| (ANROWS |x|))
              (SETQ |m| (ANCOLS |x|))
              (SETQ |v| (MAKE_MATRIX |n| |m|))
              ((LAMBDA (|bfVar#86| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#86|) (RETURN NIL))
                        (#1#
                         ((LAMBDA (|bfVar#87| |j|)
                            (LOOP
                             (COND ((> |j| |bfVar#87|) (RETURN NIL))
                                   (#1#
                                    (PROGN
                                     (SETQ |y| (QAREF2O |x| |i| |j| 0 0))
                                     (OR
                                      (SETQ |y'|
                                              (|coerceInt| (|objNewWrap| |y| R)
                                               S))
                                      (|coercionFailure|))
                                     (QSETAREF2O |v| |i| |j|
                                      (|objValUnwrap| |y'|) 0 0))))
                             (SETQ |j| (+ |j| 1))))
                          (- |m| 1) 0)))
                  (SETQ |i| (+ |i| 1))))
               (- |n| 1) 0)
              |v|)))))))

; M2Rm(x,source is [.,R],[.,p,q,S]) ==
;     x = '_$fromCoerceable_$ => nil
;     n := ANROWS(x)
;     m := ANCOLS(x)
;     n = p and m = q => M2M(x, source, [nil, S])
;     coercionFailure()

(DEFUN |M2Rm| (|x| |source| |bfVar#90|)
  (PROG (|p| |q| S R |n| |m|)
    (RETURN
     (PROGN
      (SETQ |p| (CADR . #1=(|bfVar#90|)))
      (SETQ |q| (CADDR . #1#))
      (SETQ S (CADDDR . #1#))
      (SETQ R (CADR |source|))
      (COND ((EQ |x| '|$fromCoerceable$|) NIL)
            (#2='T
             (PROGN
              (SETQ |n| (ANROWS |x|))
              (SETQ |m| (ANCOLS |x|))
              (COND
               ((AND (EQUAL |n| |p|) (EQUAL |m| |q|))
                (M2M |x| |source| (LIST NIL S)))
               (#2# (|coercionFailure|))))))))))

; M2Sm(x,source is [.,R],[.,p,S]) ==
;     x = '_$fromCoerceable_$ => nil
;     n := ANROWS(x)
;     m := ANCOLS(x)
;     n = m and m = p => M2M(x, source, [nil, S])
;     coercionFailure()

(DEFUN |M2Sm| (|x| |source| |bfVar#91|)
  (PROG (|p| S R |n| |m|)
    (RETURN
     (PROGN
      (SETQ |p| (CADR . #1=(|bfVar#91|)))
      (SETQ S (CADDR . #1#))
      (SETQ R (CADR |source|))
      (COND ((EQ |x| '|$fromCoerceable$|) NIL)
            (#2='T
             (PROGN
              (SETQ |n| (ANROWS |x|))
              (SETQ |m| (ANCOLS |x|))
              (COND
               ((AND (EQUAL |n| |m|) (EQUAL |m| |p|))
                (M2M |x| |source| (LIST NIL S)))
               (#2# (|coercionFailure|))))))))))

; M2V(x,[.,S],target) ==
;   mid := ['Vector,['Vector,S]]
;   x = '_$fromCoerceable_$ =>  canCoerce(mid,target)
;   (u := coerceInt(objNewWrap(M2VV x, mid), target)) or coercionFailure()
;   objValUnwrap u

(DEFUN M2V (|x| |bfVar#92| |target|)
  (PROG (S |mid| |u|)
    (RETURN
     (PROGN
      (SETQ S (CADR |bfVar#92|))
      (SETQ |mid| (LIST '|Vector| (LIST '|Vector| S)))
      (COND ((EQ |x| '|$fromCoerceable$|) (|canCoerce| |mid| |target|))
            ('T
             (PROGN
              (OR
               (SETQ |u|
                       (|coerceInt| (|objNewWrap| (M2VV |x|) |mid|) |target|))
               (|coercionFailure|))
              (|objValUnwrap| |u|))))))))

; Mp2Dmp(u, source is [., x, S], target is [dmp, y, T]) ==
;   -- Change the representation to a DMP with the same variables and
;   -- coerce.
;   target' := [dmp,x,S]
;   u = '_$fromCoerceable_$ => canCoerce(target',target)
;
;   -- check if we have a constant
;   u is [ =0,:c] =>
;     null (u' := coerceInt(objNewWrap(c,S),target)) =>
;       coercionFailure()
;     objValUnwrap(u')
;
;   plus := getFunctionFromDomain('_+,target',[target',target'])
;   mult := getFunctionFromDomain('_*,target',[target',target'])
;   one := domainOne(S)
;   zero := domainZero(S)
;   (u' := coerceInt(objNewWrap(Mp2SimilarDmp(u,S,#x,plus,mult,one,zero),
;     target'),target)) or coercionFailure()
;   objValUnwrap(u')

(DEFUN |Mp2Dmp| (|u| |source| |target|)
  (PROG (|dmp| |y| T$ |x| S |target'| |c| |u'| |plus| |mult| |one| |zero|)
    (RETURN
     (PROGN
      (SETQ |dmp| (CAR |target|))
      (SETQ |y| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |x| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (SETQ |target'| (LIST |dmp| |x| S))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |target'| |target|))
            ((AND (CONSP |u|) (EQUAL (CAR |u|) 0)
                  (PROGN (SETQ |c| (CDR |u|)) #3='T))
             (COND
              ((NULL (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|)))
               (|coercionFailure|))
              (#3# (|objValUnwrap| |u'|))))
            (#3#
             (PROGN
              (SETQ |plus|
                      (|getFunctionFromDomain| '+ |target'|
                       (LIST |target'| |target'|)))
              (SETQ |mult|
                      (|getFunctionFromDomain| '* |target'|
                       (LIST |target'| |target'|)))
              (SETQ |one| (|domainOne| S))
              (SETQ |zero| (|domainZero| S))
              (OR
               (SETQ |u'|
                       (|coerceInt|
                        (|objNewWrap|
                         (|Mp2SimilarDmp| |u| S (LENGTH |x|) |plus| |mult|
                          |one| |zero|)
                         |target'|)
                        |target|))
               (|coercionFailure|))
              (|objValUnwrap| |u'|))))))))

; Mp2SimilarDmp(u,S,n,plus,mult,one,zero) ==
;   u is [ =0,:c] =>
;     c = zero => NIL  -- zero for dmp
;     [[LIST2VEC LZeros n,:c]]
;   u is [ =1,x,:terms] =>
;     u' := NIL  -- zero for dmp
;     for [e,:c] in terms repeat
;       e' := LIST2VEC LZeros n
;       e'.(x-1) := e
;       t := [[e',:one]]
;       t := SPADCALL(t,Mp2SimilarDmp(c,S,n,plus,mult,one,zero),mult)
;       u' := SPADCALL(u',t,plus)
;     u'

(DEFUN |Mp2SimilarDmp| (|u| S |n| |plus| |mult| |one| |zero|)
  (PROG (|c| |ISTMP#1| |x| |terms| |u'| |e| |e'| |t|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQUAL (CAR |u|) 0) (PROGN (SETQ |c| (CDR |u|)) #1='T))
       (COND ((EQUAL |c| |zero|) NIL)
             (#1# (LIST (CONS (LIST2VEC (|LZeros| |n|)) |c|)))))
      ((AND (CONSP |u|) (EQUAL (CAR |u|) 1)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |x| (CAR |ISTMP#1|))
                   (SETQ |terms| (CDR |ISTMP#1|))
                   #1#))))
       (PROGN
        (SETQ |u'| NIL)
        ((LAMBDA (|bfVar#94| |bfVar#93|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#94|)
                  (PROGN (SETQ |bfVar#93| (CAR |bfVar#94|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#93|)
                   (PROGN
                    (SETQ |e| (CAR |bfVar#93|))
                    (SETQ |c| (CDR |bfVar#93|))
                    #1#)
                   (PROGN
                    (SETQ |e'| (LIST2VEC (|LZeros| |n|)))
                    (SETF (ELT |e'| (- |x| 1)) |e|)
                    (SETQ |t| (LIST (CONS |e'| |one|)))
                    (SETQ |t|
                            (SPADCALL |t|
                             (|Mp2SimilarDmp| |c| S |n| |plus| |mult| |one|
                              |zero|)
                             |mult|))
                    (SETQ |u'| (SPADCALL |u'| |t| |plus|))))))
            (SETQ |bfVar#94| (CDR |bfVar#94|))))
         |terms| NIL)
        |u'|))))))

; Mp2Expr(u,source is [mp,vars,S], target is [Expr,T]) ==
;     u = '_$fromCoerceable_$ => canCoerce(S, target)
;
;     dmp := ['DistributedMultivariatePolynomial, vars, S]
;     not (d := coerceInt(objNewWrap(u, source), dmp)) => coercionFailure()
;     Dmp2Expr(objValUnwrap d, dmp, target)

(DEFUN |Mp2Expr| (|u| |source| |target|)
  (PROG (|Expr| T$ |mp| |vars| S |dmp| |d|)
    (RETURN
     (PROGN
      (SETQ |Expr| (CAR |target|))
      (SETQ T$ (CADR |target|))
      (SETQ |mp| (CAR |source|))
      (SETQ |vars| (CADR . #1=(|source|)))
      (SETQ S (CADDR . #1#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S |target|))
            (#2='T
             (PROGN
              (SETQ |dmp| (LIST '|DistributedMultivariatePolynomial| |vars| S))
              (COND
               ((NULL
                 (SETQ |d| (|coerceInt| (|objNewWrap| |u| |source|) |dmp|)))
                (|coercionFailure|))
               (#2# (|Dmp2Expr| (|objValUnwrap| |d|) |dmp| |target|))))))))))

; Mp2FR(u,S is [.,vl,R],[.,T]) ==
;   u = '_$fromCoerceable_$ =>
;     S ~= T => nil
;     R in '((Integer) (Fraction (Integer))) => true
;     nil
;   S ~= T => coercionFailure()
;   package :=
;     R = $Integer =>
;       ovl := ['OrderedVariableList, vl]
;       ['MultivariateFactorize,ovl, ['IndexedExponents, ovl],R,S]
;     R is ['Fraction, D] =>
;       ovl := ['OrderedVariableList, vl]
;       package := ['MRationalFactorize,['IndexedExponents, ovl], ovl, D, S]
;     coercionFailure()
;   factor := getFunctionFromDomain('factor,package,[S])
;   SPADCALL(u,factor)

(DEFUN |Mp2FR| (|u| S |bfVar#95|)
  (PROG (T$ |vl| R |ovl| |ISTMP#1| D |package| |factor|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |bfVar#95|))
      (SETQ |vl| (CADR . #1=(S)))
      (SETQ R (CADDR . #1#))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND ((NOT (EQUAL S T$)) NIL)
              ((|member| R '((|Integer|) (|Fraction| (|Integer|)))) T)
              (#2='T NIL)))
       ((NOT (EQUAL S T$)) (|coercionFailure|))
       (#2#
        (PROGN
         (SETQ |package|
                 (COND
                  ((EQUAL R |$Integer|)
                   (PROGN
                    (SETQ |ovl| (LIST '|OrderedVariableList| |vl|))
                    (LIST '|MultivariateFactorize| |ovl|
                          (LIST '|IndexedExponents| |ovl|) R S)))
                  ((AND (CONSP R) (EQ (CAR R) '|Fraction|)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR R))
                         (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                              (PROGN (SETQ D (CAR |ISTMP#1|)) #2#))))
                   (PROGN
                    (SETQ |ovl| (LIST '|OrderedVariableList| |vl|))
                    (SETQ |package|
                            (LIST '|MRationalFactorize|
                                  (LIST '|IndexedExponents| |ovl|) |ovl| D
                                  S))))
                  (#2# (|coercionFailure|))))
         (SETQ |factor| (|getFunctionFromDomain| '|factor| |package| (LIST S)))
         (SPADCALL |u| |factor|))))))))

; Mp2Mp(u,source is [mp,x,S], target is [.,y,T]) ==
;   -- need not deal with case of x = y (coerceByMapping)
;   common := intersection(y,x)
;   x' := SETDIFFERENCE(x,common)
;   y' := SETDIFFERENCE(y,common)
;
;   u = '_$fromCoerceable_$ =>
;     x = y => canCoerce(S,T)
;     null common => canCoerce(source,T)
;     null x' => canCoerce(S,target)
;     null y' => canCoerce([mp,x',S],T)
;     canCoerce([mp,x',S],[mp,y',T])
;
;   -- first check for constant case
;   u is [ =0,:c] =>
;     (u' := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     objValUnwrap(u')
;
;   plus  := getFunctionFromDomain('_+,target,[target,target])
;
;   -- now no-common-variables case
;
;   null common =>
;     times := getFunctionFromDomain('_*,target,[target,target])
;     expn  := getFunctionFromDomain("^", target,
;       [target,$NonNegativeInteger])
;     Mp2MpAux0(u,S,target,x,plus,times,expn)
;
;   -- if source vars are all in target
;   null x' =>
;     monom := getFunctionFromDomain('monomial,target,
;       [target,['OrderedVariableList,y],$NonNegativeInteger])
;     Mp2MpAux1(u,S,target,x,y,plus,monom)
;
;   -- if target vars are all in source
;   null y' =>    -- change source to MP[common] MP[x'] S
;     univariate := getFunctionFromDomain('univariate,
;       source,[source,['OrderedVariableList,x]])
;     u' := Mp2MpAux2(u,x,common,x',common,x',univariate,S,NIL)
;     (u' := coerceInt(objNewWrap(u', [mp,common,[mp,x',S]]),target)) or
;       coercionFailure()
;     objValUnwrap(u')
;
;   -- we have a mixture
;   (u' := coerceInt(objNewWrap(u,source),[mp,common,[mp,x',S]])) or
;     coercionFailure()
;   (u' := coerceInt(u',target)) or coercionFailure()
;   objValUnwrap(u')

(DEFUN |Mp2Mp| (|u| |source| |target|)
  (PROG (|y| T$ |mp| |x| S |common| |x'| |y'| |c| |u'| |plus| |times| |expn|
         |monom| |univariate|)
    (RETURN
     (PROGN
      (SETQ |y| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |mp| (CAR |source|))
      (SETQ |x| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (SETQ |common| (|intersection| |y| |x|))
      (SETQ |x'| (SETDIFFERENCE |x| |common|))
      (SETQ |y'| (SETDIFFERENCE |y| |common|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND ((EQUAL |x| |y|) (|canCoerce| S T$))
              ((NULL |common|) (|canCoerce| |source| T$))
              ((NULL |x'|) (|canCoerce| S |target|))
              ((NULL |y'|) (|canCoerce| (LIST |mp| |x'| S) T$))
              (#3='T (|canCoerce| (LIST |mp| |x'| S) (LIST |mp| |y'| T$)))))
       ((AND (CONSP |u|) (EQUAL (CAR |u|) 0) (PROGN (SETQ |c| (CDR |u|)) #3#))
        (PROGN
         (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|))
             (|coercionFailure|))
         (|objValUnwrap| |u'|)))
       (#3#
        (PROGN
         (SETQ |plus|
                 (|getFunctionFromDomain| '+ |target|
                  (LIST |target| |target|)))
         (COND
          ((NULL |common|)
           (PROGN
            (SETQ |times|
                    (|getFunctionFromDomain| '* |target|
                     (LIST |target| |target|)))
            (SETQ |expn|
                    (|getFunctionFromDomain| '^ |target|
                     (LIST |target| |$NonNegativeInteger|)))
            (|Mp2MpAux0| |u| S |target| |x| |plus| |times| |expn|)))
          ((NULL |x'|)
           (PROGN
            (SETQ |monom|
                    (|getFunctionFromDomain| '|monomial| |target|
                     (LIST |target| (LIST '|OrderedVariableList| |y|)
                           |$NonNegativeInteger|)))
            (|Mp2MpAux1| |u| S |target| |x| |y| |plus| |monom|)))
          ((NULL |y'|)
           (PROGN
            (SETQ |univariate|
                    (|getFunctionFromDomain| '|univariate| |source|
                     (LIST |source| (LIST '|OrderedVariableList| |x|))))
            (SETQ |u'|
                    (|Mp2MpAux2| |u| |x| |common| |x'| |common| |x'|
                     |univariate| S NIL))
            (OR
             (SETQ |u'|
                     (|coerceInt|
                      (|objNewWrap| |u'|
                       (LIST |mp| |common| (LIST |mp| |x'| S)))
                      |target|))
             (|coercionFailure|))
            (|objValUnwrap| |u'|)))
          (#3#
           (PROGN
            (OR
             (SETQ |u'|
                     (|coerceInt| (|objNewWrap| |u| |source|)
                      (LIST |mp| |common| (LIST |mp| |x'| S))))
             (|coercionFailure|))
            (OR (SETQ |u'| (|coerceInt| |u'| |target|)) (|coercionFailure|))
            (|objValUnwrap| |u'|)))))))))))

; Mp2MpAux0(u,S,target,vars,plus,times,expn) ==
;   -- for case when no common variables
;   u is [ =0,:c] =>
;     (u' := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     objValUnwrap(u')
;   [.,var,:terms] := u
;   [mp,.,T] := target
;   x := coerceInt(objNewWrap(vars.(var-1),['Variable,vars.(var-1)]),
;     [mp,vars,$Integer]) or coercionFailure()
;   (x := coerceInt(x,T)) or coercionFailure()
;   x := [0,:objValUnwrap x]
;   sum := domainZero(target)
;   for [e,:c] in terms repeat
;     prod := SPADCALL(SPADCALL(x,e,expn),
;       Mp2MpAux0(c,S,target,vars,plus,times,expn),times)
;     sum := SPADCALL(sum,prod,plus)
;   sum

(DEFUN |Mp2MpAux0| (|u| S |target| |vars| |plus| |times| |expn|)
  (PROG (|c| |u'| |var| |terms| |mp| T$ |x| |sum| |e| |prod|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQUAL (CAR |u|) 0) (PROGN (SETQ |c| (CDR |u|)) #1='T))
       (PROGN
        (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|))
            (|coercionFailure|))
        (|objValUnwrap| |u'|)))
      (#1#
       (PROGN
        (SETQ |var| (CADR . #2=(|u|)))
        (SETQ |terms| (CDDR . #2#))
        (SETQ |mp| (CAR |target|))
        (SETQ T$ (CADDR |target|))
        (SETQ |x|
                (OR
                 (|coerceInt|
                  (|objNewWrap| (ELT |vars| (- |var| 1))
                   (LIST '|Variable| (ELT |vars| (- |var| 1))))
                  (LIST |mp| |vars| |$Integer|))
                 (|coercionFailure|)))
        (OR (SETQ |x| (|coerceInt| |x| T$)) (|coercionFailure|))
        (SETQ |x| (CONS 0 (|objValUnwrap| |x|)))
        (SETQ |sum| (|domainZero| |target|))
        ((LAMBDA (|bfVar#97| |bfVar#96|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#97|)
                  (PROGN (SETQ |bfVar#96| (CAR |bfVar#97|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#96|)
                   (PROGN
                    (SETQ |e| (CAR |bfVar#96|))
                    (SETQ |c| (CDR |bfVar#96|))
                    #1#)
                   (PROGN
                    (SETQ |prod|
                            (SPADCALL (SPADCALL |x| |e| |expn|)
                             (|Mp2MpAux0| |c| S |target| |vars| |plus| |times|
                              |expn|)
                             |times|))
                    (SETQ |sum| (SPADCALL |sum| |prod| |plus|))))))
            (SETQ |bfVar#97| (CDR |bfVar#97|))))
         |terms| NIL)
        |sum|))))))

; Mp2MpAux1(u,S,target,varl1,varl2,plus,monom) ==
;   -- for case when source vars are all in target
;   u is [ =0,:c] =>
;     (u' := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     objValUnwrap(u')
;   [.,var,:terms] := u
;   sum := domainZero(target)
;   for [e,:c] in terms repeat
;     mon := SPADCALL( Mp2MpAux1(c,S,target,varl1,varl2,plus,monom),
;       position1(varl1.(var-1), varl2),e,monom)
;     sum := SPADCALL(sum,mon,plus)
;   sum

(DEFUN |Mp2MpAux1| (|u| S |target| |varl1| |varl2| |plus| |monom|)
  (PROG (|c| |u'| |var| |terms| |sum| |e| |mon|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQUAL (CAR |u|) 0) (PROGN (SETQ |c| (CDR |u|)) #1='T))
       (PROGN
        (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|))
            (|coercionFailure|))
        (|objValUnwrap| |u'|)))
      (#1#
       (PROGN
        (SETQ |var| (CADR . #2=(|u|)))
        (SETQ |terms| (CDDR . #2#))
        (SETQ |sum| (|domainZero| |target|))
        ((LAMBDA (|bfVar#99| |bfVar#98|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#99|)
                  (PROGN (SETQ |bfVar#98| (CAR |bfVar#99|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#98|)
                   (PROGN
                    (SETQ |e| (CAR |bfVar#98|))
                    (SETQ |c| (CDR |bfVar#98|))
                    #1#)
                   (PROGN
                    (SETQ |mon|
                            (SPADCALL
                             (|Mp2MpAux1| |c| S |target| |varl1| |varl2| |plus|
                              |monom|)
                             (|position1| (ELT |varl1| (- |var| 1)) |varl2|)
                             |e| |monom|))
                    (SETQ |sum| (SPADCALL |sum| |mon| |plus|))))))
            (SETQ |bfVar#99| (CDR |bfVar#99|))))
         |terms| NIL)
        |sum|))))))

; Mp2MpAux2(u,x,oldcomm,oldrest,common,restvars,univariate,S,isUnder) ==
;   -- target vars are all in source
;   mp2 := ['MultivariatePolynomial,oldcomm,['MultivariatePolynomial,
;     oldrest,S]]
;   common =>
;     u is [ =0,:c] =>
;       (u' := coerceInt(objNewWrap(c,S),mp2)) or coercionFailure()
;       objValUnwrap(u')
;     [var,:common] := common
;     u' := SPADCALL(u,position1(var,x),univariate)
;     null(rest(u')) and (first(first(u')) = 0) =>
;       Mp2MpAux2(u,x,oldcomm,oldrest,common,restvars,univariate,S,isUnder)
;     [1,position1(var,oldcomm),:[[e,:Mp2MpAux2(c,x,oldcomm,oldrest,
;       common,restvars,univariate,S,isUnder)] for [e,:c] in u']]
;   null isUnder =>
;     [0,:Mp2MpAux2(u,x,oldcomm,oldrest,common,restvars,univariate,S,true)]
;   -- just treat like elt of [mp,x',S]
;   u is [ =0,:c] => u
;   [var,:restvars] := restvars
;   u' := SPADCALL(u,position1(var,x),univariate)
;   null(rest(u')) and (first(first(u')) = 0) =>
;     Mp2MpAux2(u,x,oldcomm,oldrest,common,restvars,univariate,S,isUnder)
;   [1,position1(var,oldrest),:[[e,:Mp2MpAux2(c,x,oldcomm,oldrest,
;     common,restvars,univariate,S,isUnder)] for [e,:c] in u']]

(DEFUN |Mp2MpAux2|
       (|u| |x| |oldcomm| |oldrest| |common| |restvars| |univariate| S
        |isUnder|)
  (PROG (|mp2| |c| |u'| |LETTMP#1| |var| |e|)
    (RETURN
     (PROGN
      (SETQ |mp2|
              (LIST '|MultivariatePolynomial| |oldcomm|
                    (LIST '|MultivariatePolynomial| |oldrest| S)))
      (COND
       (|common|
        (COND
         ((AND (CONSP |u|) (EQUAL (CAR |u|) 0)
               (PROGN (SETQ |c| (CDR |u|)) #1='T))
          (PROGN
           (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |mp2|))
               (|coercionFailure|))
           (|objValUnwrap| |u'|)))
         (#1#
          (PROGN
           (SETQ |LETTMP#1| |common|)
           (SETQ |var| (CAR |LETTMP#1|))
           (SETQ |common| (CDR |LETTMP#1|))
           (SETQ |u'| (SPADCALL |u| (|position1| |var| |x|) |univariate|))
           (COND
            ((AND (NULL (CDR |u'|)) (EQL (CAR (CAR |u'|)) 0))
             (|Mp2MpAux2| |u| |x| |oldcomm| |oldrest| |common| |restvars|
              |univariate| S |isUnder|))
            (#1#
             (CONS 1
                   (CONS (|position1| |var| |oldcomm|)
                         ((LAMBDA (|bfVar#102| |bfVar#101| |bfVar#100|)
                            (LOOP
                             (COND
                              ((OR (ATOM |bfVar#101|)
                                   (PROGN
                                    (SETQ |bfVar#100| (CAR |bfVar#101|))
                                    NIL))
                               (RETURN (NREVERSE |bfVar#102|)))
                              (#1#
                               (AND (CONSP |bfVar#100|)
                                    (PROGN
                                     (SETQ |e| (CAR |bfVar#100|))
                                     (SETQ |c| (CDR |bfVar#100|))
                                     #1#)
                                    (SETQ |bfVar#102|
                                            (CONS
                                             (CONS |e|
                                                   (|Mp2MpAux2| |c| |x|
                                                    |oldcomm| |oldrest|
                                                    |common| |restvars|
                                                    |univariate| S |isUnder|))
                                             |bfVar#102|)))))
                             (SETQ |bfVar#101| (CDR |bfVar#101|))))
                          NIL |u'| NIL)))))))))
       ((NULL |isUnder|)
        (CONS 0
              (|Mp2MpAux2| |u| |x| |oldcomm| |oldrest| |common| |restvars|
               |univariate| S T)))
       ((AND (CONSP |u|) (EQUAL (CAR |u|) 0) (PROGN (SETQ |c| (CDR |u|)) #1#))
        |u|)
       (#1#
        (PROGN
         (SETQ |LETTMP#1| |restvars|)
         (SETQ |var| (CAR |LETTMP#1|))
         (SETQ |restvars| (CDR |LETTMP#1|))
         (SETQ |u'| (SPADCALL |u| (|position1| |var| |x|) |univariate|))
         (COND
          ((AND (NULL (CDR |u'|)) (EQL (CAR (CAR |u'|)) 0))
           (|Mp2MpAux2| |u| |x| |oldcomm| |oldrest| |common| |restvars|
            |univariate| S |isUnder|))
          (#1#
           (CONS 1
                 (CONS (|position1| |var| |oldrest|)
                       ((LAMBDA (|bfVar#105| |bfVar#104| |bfVar#103|)
                          (LOOP
                           (COND
                            ((OR (ATOM |bfVar#104|)
                                 (PROGN
                                  (SETQ |bfVar#103| (CAR |bfVar#104|))
                                  NIL))
                             (RETURN (NREVERSE |bfVar#105|)))
                            (#1#
                             (AND (CONSP |bfVar#103|)
                                  (PROGN
                                   (SETQ |e| (CAR |bfVar#103|))
                                   (SETQ |c| (CDR |bfVar#103|))
                                   #1#)
                                  (SETQ |bfVar#105|
                                          (CONS
                                           (CONS |e|
                                                 (|Mp2MpAux2| |c| |x| |oldcomm|
                                                  |oldrest| |common| |restvars|
                                                  |univariate| S |isUnder|))
                                           |bfVar#105|)))))
                           (SETQ |bfVar#104| (CDR |bfVar#104|))))
                        NIL |u'| NIL))))))))))))

; genMpFromDmpTerm(u, oldlen) ==
;
;   -- given one term of a DMP representation of a polynomial, this creates
;   -- the corresponding MP term.
;
;   patlen := oldlen
;   [e,:c] := u
;   numexps := # e
;   patlen >= numexps => [0, :c]
;   for i in patlen..(numexps - 1) repeat
;     e.i = 0 => patlen := patlen + 1
;     return nil
;   patlen >= numexps => [0, :c]
;   [1, 1+patlen, [e.patlen,:genMpFromDmpTerm(u,patlen+1)]]

(DEFUN |genMpFromDmpTerm| (|u| |oldlen|)
  (PROG (|patlen| |e| |c| |numexps|)
    (RETURN
     (PROGN
      (SETQ |patlen| |oldlen|)
      (SETQ |e| (CAR |u|))
      (SETQ |c| (CDR |u|))
      (SETQ |numexps| (LENGTH |e|))
      (COND ((NOT (< |patlen| |numexps|)) (CONS 0 |c|))
            (#1='T
             (PROGN
              ((LAMBDA (|bfVar#106| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#106|) (RETURN NIL))
                        (#1#
                         (COND
                          ((EQL (ELT |e| |i|) 0)
                           (SETQ |patlen| (+ |patlen| 1)))
                          (#1# (RETURN NIL)))))
                  (SETQ |i| (+ |i| 1))))
               (- |numexps| 1) |patlen|)
              (COND ((NOT (< |patlen| |numexps|)) (CONS 0 |c|))
                    (#1#
                     (LIST 1 (+ 1 |patlen|)
                           (CONS (ELT |e| |patlen|)
                                 (|genMpFromDmpTerm| |u|
                                  (+ |patlen| 1)))))))))))))

; Mp2P(u, source is [mp,vl, S], target is [p,R]) ==
;   u = '_$fromCoerceable_$ => canCoerce(S,target)
;   S is ['Polynomial,.] => MpP2P(u,vl,S,R)
;   vl' := REVERSE MSORT vl
;   -- if Mp2Mp fails, a THROW will occur
;   u' := Mp2Mp(u,source,[mp,vl',S])
;   u' := translateMpVars2PVars (u',vl')
;   (u' := coerceInt(objNewWrap(u',[p,S]),target)) or coercionFailure()
;   objValUnwrap(u')

(DEFUN |Mp2P| (|u| |source| |target|)
  (PROG (|p| R |mp| |vl| S |ISTMP#1| |vl'| |u'|)
    (RETURN
     (PROGN
      (SETQ |p| (CAR |target|))
      (SETQ R (CADR |target|))
      (SETQ |mp| (CAR |source|))
      (SETQ |vl| (CADR . #1=(|source|)))
      (SETQ S (CADDR . #1#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S |target|))
            ((AND (CONSP S) (EQ (CAR S) '|Polynomial|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR S))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL))))
             (|MpP2P| |u| |vl| S R))
            ('T
             (PROGN
              (SETQ |vl'| (REVERSE (MSORT |vl|)))
              (SETQ |u'| (|Mp2Mp| |u| |source| (LIST |mp| |vl'| S)))
              (SETQ |u'| (|translateMpVars2PVars| |u'| |vl'|))
              (OR
               (SETQ |u'|
                       (|coerceInt| (|objNewWrap| |u'| (LIST |p| S)) |target|))
               (|coercionFailure|))
              (|objValUnwrap| |u'|))))))))

; MpP2P(u,vl,PS,R) ==
;   -- u has type MP(vl,PS). Want to coerce to P R.
;   PR := ['Polynomial,R]
;   u is [ =0,:c] =>
;     (u' :=coerceInt(objNewWrap(c,PS),PR)) or
;       coercionFailure()
;     objValUnwrap u'
;   [ .,pos,:ec] := u
;   multivariate := getFunctionFromDomain('multivariate,
;     PR,[['SparseUnivariatePolynomial,PR],$Symbol])
;   sup := [[e,:MpP2P(c,vl,PS,R)] for [e,:c] in ec]
;   p := SPADCALL(sup,vl.(pos-1),multivariate)

(DEFUN |MpP2P| (|u| |vl| PS R)
  (PROG (PR |c| |u'| |pos| |ec| |multivariate| |e| |sup| |p|)
    (RETURN
     (PROGN
      (SETQ PR (LIST '|Polynomial| R))
      (COND
       ((AND (CONSP |u|) (EQUAL (CAR |u|) 0)
             (PROGN (SETQ |c| (CDR |u|)) #1='T))
        (PROGN
         (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| PS) PR))
             (|coercionFailure|))
         (|objValUnwrap| |u'|)))
       (#1#
        (PROGN
         (SETQ |pos| (CADR . #2=(|u|)))
         (SETQ |ec| (CDDR . #2#))
         (SETQ |multivariate|
                 (|getFunctionFromDomain| '|multivariate| PR
                  (LIST (LIST '|SparseUnivariatePolynomial| PR) |$Symbol|)))
         (SETQ |sup|
                 ((LAMBDA (|bfVar#109| |bfVar#108| |bfVar#107|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#108|)
                           (PROGN (SETQ |bfVar#107| (CAR |bfVar#108|)) NIL))
                       (RETURN (NREVERSE |bfVar#109|)))
                      (#1#
                       (AND (CONSP |bfVar#107|)
                            (PROGN
                             (SETQ |e| (CAR |bfVar#107|))
                             (SETQ |c| (CDR |bfVar#107|))
                             #1#)
                            (SETQ |bfVar#109|
                                    (CONS (CONS |e| (|MpP2P| |c| |vl| PS R))
                                          |bfVar#109|)))))
                     (SETQ |bfVar#108| (CDR |bfVar#108|))))
                  NIL |ec| NIL))
         (SETQ |p|
                 (SPADCALL |sup| (ELT |vl| (- |pos| 1)) |multivariate|)))))))))

; Mp2Up(u,source is [mp,vl,S],target is [up,x,T]) ==
;   u = '_$fromCoerceable_$ =>
;     member(x,vl) =>
;       vl = [x] => canCoerce(S,T)
;       canCoerce([mp,delete(x,vl),S],T)
;     canCoerce(source,T)
;
;   u is [ =0,:c] =>      -- constant polynomial?
;     (u' := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     objValUnwrap u'
;
;   null member(x,vl) =>
;     (u' := coerceInt(objNewWrap(u,source),T)) or coercionFailure()
;     [[0,:objValUnwrap(u')]]
;
;   vl = [x] =>
;     u' := [[e,:c] for [e,.,:c] in CDDR u]
;     (u' := coerceInt(objNewWrap(u',[up,x,S]),target))
;       or coercionFailure()
;     objValUnwrap u'
;
;   -- do a univariate to transform u to a UP(x,P S) and then coerce again
;   var := position1(x,vl)
;   UPP := ['UnivariatePolynomial,x,source]
;   univariate := getFunctionFromDomain('univariate,
;     source,[source,['OrderedVariableList,vl]])
;   upU := SPADCALL(u,var,univariate)  -- we may assume this has type UPP
;   (u' := coerceInt(objNewWrap(upU,UPP),target)) or coercionFailure()
;   objValUnwrap u'

(DEFUN |Mp2Up| (|u| |source| |target|)
  (PROG (|up| |x| T$ |mp| |vl| S |c| |u'| |e| |ISTMP#1| |var| UPP |univariate|
         |upU|)
    (RETURN
     (PROGN
      (SETQ |up| (CAR |target|))
      (SETQ |x| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |mp| (CAR |source|))
      (SETQ |vl| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND
         ((|member| |x| |vl|)
          (COND ((EQUAL |vl| (LIST |x|)) (|canCoerce| S T$))
                (#3='T (|canCoerce| (LIST |mp| (|delete| |x| |vl|) S) T$))))
         (#3# (|canCoerce| |source| T$))))
       ((AND (CONSP |u|) (EQUAL (CAR |u|) 0) (PROGN (SETQ |c| (CDR |u|)) #3#))
        (PROGN
         (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|))
             (|coercionFailure|))
         (|objValUnwrap| |u'|)))
       ((NULL (|member| |x| |vl|))
        (PROGN
         (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) T$))
             (|coercionFailure|))
         (LIST (CONS 0 (|objValUnwrap| |u'|)))))
       ((EQUAL |vl| (LIST |x|))
        (PROGN
         (SETQ |u'|
                 ((LAMBDA (|bfVar#112| |bfVar#111| |bfVar#110|)
                    (LOOP
                     (COND
                      ((OR (ATOM |bfVar#111|)
                           (PROGN (SETQ |bfVar#110| (CAR |bfVar#111|)) NIL))
                       (RETURN (NREVERSE |bfVar#112|)))
                      (#3#
                       (AND (CONSP |bfVar#110|)
                            (PROGN
                             (SETQ |e| (CAR |bfVar#110|))
                             (SETQ |ISTMP#1| (CDR |bfVar#110|))
                             (AND (CONSP |ISTMP#1|)
                                  (PROGN (SETQ |c| (CDR |ISTMP#1|)) #3#)))
                            (SETQ |bfVar#112|
                                    (CONS (CONS |e| |c|) |bfVar#112|)))))
                     (SETQ |bfVar#111| (CDR |bfVar#111|))))
                  NIL (CDDR |u|) NIL))
         (OR
          (SETQ |u'|
                  (|coerceInt| (|objNewWrap| |u'| (LIST |up| |x| S)) |target|))
          (|coercionFailure|))
         (|objValUnwrap| |u'|)))
       (#3#
        (PROGN
         (SETQ |var| (|position1| |x| |vl|))
         (SETQ UPP (LIST '|UnivariatePolynomial| |x| |source|))
         (SETQ |univariate|
                 (|getFunctionFromDomain| '|univariate| |source|
                  (LIST |source| (LIST '|OrderedVariableList| |vl|))))
         (SETQ |upU| (SPADCALL |u| |var| |univariate|))
         (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |upU| UPP) |target|))
             (|coercionFailure|))
         (|objValUnwrap| |u'|))))))))

; OV2OV(u,source is [.,svl], target is [.,tvl]) ==
;   svl = intersection(svl,tvl) =>
;     u = '_$fromCoerceable_$ => true
;     position1(svl.(u-1),tvl)
;   u = '_$fromCoerceable_$ => nil
;   coercionFailure()

(DEFUN OV2OV (|u| |source| |target|)
  (PROG (|tvl| |svl|)
    (RETURN
     (PROGN
      (SETQ |tvl| (CADR |target|))
      (SETQ |svl| (CADR |source|))
      (COND
       ((EQUAL |svl| (|intersection| |svl| |tvl|))
        (COND ((EQ |u| '|$fromCoerceable$|) T)
              (#1='T (|position1| (ELT |svl| (- |u| 1)) |tvl|))))
       ((EQ |u| '|$fromCoerceable$|) NIL) (#1# (|coercionFailure|)))))))

; OV2P(u,source is [.,svl], target is [.,T]) ==
;   u = '_$fromCoerceable_$ => true
;   v := svl.(unwrap(u)-1)
;   [1,v,[1,0,:domainOne(T)]]

(DEFUN OV2P (|u| |source| |target|)
  (PROG (T$ |svl| |v|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ |svl| (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) T)
            ('T
             (PROGN
              (SETQ |v| (ELT |svl| (- (|unwrap| |u|) 1)))
              (LIST 1 |v| (CONS 1 (CONS 0 (|domainOne| T$)))))))))))

; OV2poly(u,source is [.,svl], target is [p,vl,T]) ==
;   u = '_$fromCoerceable_$ =>
;     p = 'UnivariatePolynomial => (# svl = 1) and (p = svl.0)
;     and/[member(v,vl) for v in svl]
;   v := svl.(unwrap(u)-1)
;   val' := [1,:domainOne(T)]
;   p = 'UnivariatePolynomial =>
;     v ~= vl => coercionFailure()
;     [[1,:domainOne(T)]]
;   null member(v,vl) => coercionFailure()
;   val' := [[1,:domainOne(T)]]
;   source' := ['UnivariatePolynomial,v,T]
;   (u' := coerceInt(objNewWrap(val',source'),target)) or
;     coercionFailure()
;   objValUnwrap(u')

(DEFUN |OV2poly| (|u| |source| |target|)
  (PROG (|p| |vl| T$ |svl| |v| |val'| |source'| |u'|)
    (RETURN
     (PROGN
      (SETQ |p| (CAR |target|))
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |svl| (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND
         ((EQ |p| '|UnivariatePolynomial|)
          (AND (EQL (LENGTH |svl|) 1) (EQUAL |p| (ELT |svl| 0))))
         (#2='T
          ((LAMBDA (|bfVar#114| |bfVar#113| |v|)
             (LOOP
              (COND
               ((OR (ATOM |bfVar#113|)
                    (PROGN (SETQ |v| (CAR |bfVar#113|)) NIL))
                (RETURN |bfVar#114|))
               (#2#
                (PROGN
                 (SETQ |bfVar#114| (|member| |v| |vl|))
                 (COND ((NOT |bfVar#114|) (RETURN NIL))))))
              (SETQ |bfVar#113| (CDR |bfVar#113|))))
           T |svl| NIL))))
       (#2#
        (PROGN
         (SETQ |v| (ELT |svl| (- (|unwrap| |u|) 1)))
         (SETQ |val'| (CONS 1 (|domainOne| T$)))
         (COND
          ((EQ |p| '|UnivariatePolynomial|)
           (COND ((NOT (EQUAL |v| |vl|)) (|coercionFailure|))
                 (#2# (LIST (CONS 1 (|domainOne| T$))))))
          ((NULL (|member| |v| |vl|)) (|coercionFailure|))
          (#2#
           (PROGN
            (SETQ |val'| (LIST (CONS 1 (|domainOne| T$))))
            (SETQ |source'| (LIST '|UnivariatePolynomial| |v| T$))
            (OR
             (SETQ |u'| (|coerceInt| (|objNewWrap| |val'| |source'|) |target|))
             (|coercionFailure|))
            (|objValUnwrap| |u'|)))))))))))

; OV2SE(u,source is [.,svl], target) ==
;   u = '_$fromCoerceable_$ => true
;   svl.(unwrap(u)-1)

(DEFUN OV2SE (|u| |source| |target|)
  (PROG (|svl|)
    (RETURN
     (PROGN
      (SETQ |svl| (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) T)
            ('T (ELT |svl| (- (|unwrap| |u|) 1))))))))

; OV2Sy(u,source is [.,svl], target) ==
;   u = '_$fromCoerceable_$ => true
;   svl.(unwrap(u)-1)

(DEFUN |OV2Sy| (|u| |source| |target|)
  (PROG (|svl|)
    (RETURN
     (PROGN
      (SETQ |svl| (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) T)
            ('T (ELT |svl| (- (|unwrap| |u|) 1))))))))

; varsInPoly(u) ==
;   u is [ =1, v, :termlist] =>
;     [v,:varsInPoly(c) for [e,:c] in termlist]
;   nil

(DEFUN |varsInPoly| (|u|)
  (PROG (|ISTMP#1| |v| |termlist| |e| |c|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQUAL (CAR |u|) 1)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |v| (CAR |ISTMP#1|))
                   (SETQ |termlist| (CDR |ISTMP#1|))
                   #1='T))))
       ((LAMBDA (|bfVar#117| |bfVar#116| |bfVar#115|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#116|)
                 (PROGN (SETQ |bfVar#115| (CAR |bfVar#116|)) NIL))
             (RETURN (NREVERSE |bfVar#117|)))
            (#1#
             (AND (CONSP |bfVar#115|)
                  (PROGN
                   (SETQ |e| (CAR |bfVar#115|))
                   (SETQ |c| (CDR |bfVar#115|))
                   #1#)
                  (SETQ |bfVar#117|
                          (APPEND (REVERSE (CONS |v| (|varsInPoly| |c|)))
                                  |bfVar#117|)))))
           (SETQ |bfVar#116| (CDR |bfVar#116|))))
        NIL |termlist| NIL))
      (#1# NIL)))))

; P2FR(u,S is [.,R],[.,T]) ==
;   u = '_$fromCoerceable_$ =>
;     S ~= T => nil
;     R in '((Integer) (Fraction (Integer))) => true
;     nil
;   S ~= T => coercionFailure()
;   package :=
;     R = $Integer =>
;       ['MultivariateFactorize,$Symbol,['IndexedExponents, $Symbol],R,S]
;     R is ['Fraction, D] =>
;       package := ['MRationalFactorize,['IndexedExponents, $Symbol],$Symbol,
;                  D, S]
;     coercionFailure()
;   factor := getFunctionFromDomain('factor,package,[S])
;   SPADCALL(u,factor)

(DEFUN P2FR (|u| S |bfVar#118|)
  (PROG (T$ R |ISTMP#1| D |package| |factor|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |bfVar#118|))
      (SETQ R (CADR S))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND ((NOT (EQUAL S T$)) NIL)
              ((|member| R '((|Integer|) (|Fraction| (|Integer|)))) T)
              (#1='T NIL)))
       ((NOT (EQUAL S T$)) (|coercionFailure|))
       (#1#
        (PROGN
         (SETQ |package|
                 (COND
                  ((EQUAL R |$Integer|)
                   (LIST '|MultivariateFactorize| |$Symbol|
                         (LIST '|IndexedExponents| |$Symbol|) R S))
                  ((AND (CONSP R) (EQ (CAR R) '|Fraction|)
                        (PROGN
                         (SETQ |ISTMP#1| (CDR R))
                         (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                              (PROGN (SETQ D (CAR |ISTMP#1|)) #1#))))
                   (SETQ |package|
                           (LIST '|MRationalFactorize|
                                 (LIST '|IndexedExponents| |$Symbol|) |$Symbol|
                                 D S)))
                  (#1# (|coercionFailure|))))
         (SETQ |factor| (|getFunctionFromDomain| '|factor| |package| (LIST S)))
         (SPADCALL |u| |factor|))))))))

; P2Dmp(u, source is [., S], target is [., y, T]) ==
;   u = '_$fromCoerceable_$ =>
;     -- might be able to say yes
;     canCoerce(source,T)
;   u is [ =0,:c] =>       -- polynomial is a constant
;     (u' := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     objValUnwrap(u')
;   univariate := getFunctionFromDomain('univariate,
;     source,[source,$Symbol])
;   plus := getFunctionFromDomain("+",target,[target,target])
;   monom := getFunctionFromDomain('monomial,target,
;     [target,['OrderedVariableList,y],$NonNegativeInteger])
;   P2DmpAux(u,source,S,target,copy y,y,T,univariate,plus,monom)

(DEFUN |P2Dmp| (|u| |source| |target|)
  (PROG (|y| T$ S |c| |u'| |univariate| |plus| |monom|)
    (RETURN
     (PROGN
      (SETQ |y| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| T$))
            ((AND (CONSP |u|) (EQUAL (CAR |u|) 0)
                  (PROGN (SETQ |c| (CDR |u|)) #2='T))
             (PROGN
              (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|))
                  (|coercionFailure|))
              (|objValUnwrap| |u'|)))
            (#2#
             (PROGN
              (SETQ |univariate|
                      (|getFunctionFromDomain| '|univariate| |source|
                       (LIST |source| |$Symbol|)))
              (SETQ |plus|
                      (|getFunctionFromDomain| '+ |target|
                       (LIST |target| |target|)))
              (SETQ |monom|
                      (|getFunctionFromDomain| '|monomial| |target|
                       (LIST |target| (LIST '|OrderedVariableList| |y|)
                             |$NonNegativeInteger|)))
              (|P2DmpAux| |u| |source| S |target| (COPY |y|) |y| T$
               |univariate| |plus| |monom|))))))))

; P2Expr(u, source is [.,S], target is [., T]) ==
;   u = '_$fromCoerceable_$ =>
;     canCoerce(S, T)
;   S = T => coercionFailure()
;   newS := ['Polynomial, T]
;   val := coerceInt(objNewWrap(u, source), newS)
;   null val => coercionFailure()
;   val := coerceInt(val, target)
;   null val => coercionFailure()
;   objValUnwrap val

(DEFUN |P2Expr| (|u| |source| |target|)
  (PROG (T$ S |newS| |val|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S T$))
            ((EQUAL S T$) (|coercionFailure|))
            (#1='T
             (PROGN
              (SETQ |newS| (LIST '|Polynomial| T$))
              (SETQ |val| (|coerceInt| (|objNewWrap| |u| |source|) |newS|))
              (COND ((NULL |val|) (|coercionFailure|))
                    (#1#
                     (PROGN
                      (SETQ |val| (|coerceInt| |val| |target|))
                      (COND ((NULL |val|) (|coercionFailure|))
                            (#1# (|objValUnwrap| |val|)))))))))))))

; P2DmpAux(u,source,S,target,varlist,vars,T,univariate,plus,monom) ==
;   u is [ =0,:c] =>       -- polynomial is a constant
;     (u' := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     objValUnwrap(u')
;
;   -- if no variables left, try to go to underdomain of target (T)
;   null vars =>
;     (u' := coerceInt(objNewWrap(u,source),T)) or coercionFailure()
;     -- if successful, embed
;     (u' := coerceByFunction(u',target)) or coercionFailure()
;     objValUnwrap(u')
;
;   -- there are variables, so get them out of u
;   [x,:vars] := vars
;   sup := SPADCALL(u,x,univariate)  -- this is a SUP P S
;   null sup =>           -- zero? unlikely.
;     domainZero(target)
;   -- degree 0 polynomial? (variable did not occur)
;   null(rest(sup)) and first(sup) is [ =0,:c] =>
;     -- call again, but with one less var
;     P2DmpAux(c,source,S,target,varlist,vars,T,univariate,plus,monom)
;   var := position1(x,varlist)
;   u' := domainZero(target)
;   for [e,:c] in sup repeat
;     u'' := SPADCALL(
;       P2DmpAux(c,source,S,target,varlist,vars,T,univariate,plus,monom),
;         var,e,monom)
;     u' := SPADCALL(u',u'',plus)
;   u'

(DEFUN |P2DmpAux|
       (|u| |source| S |target| |varlist| |vars| T$ |univariate| |plus|
        |monom|)
  (PROG (|c| |u'| |LETTMP#1| |x| |sup| |ISTMP#1| |var| |e| |u''|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQUAL (CAR |u|) 0) (PROGN (SETQ |c| (CDR |u|)) #1='T))
       (PROGN
        (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|))
            (|coercionFailure|))
        (|objValUnwrap| |u'|)))
      ((NULL |vars|)
       (PROGN
        (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) T$))
            (|coercionFailure|))
        (OR (SETQ |u'| (|coerceByFunction| |u'| |target|)) (|coercionFailure|))
        (|objValUnwrap| |u'|)))
      (#1#
       (PROGN
        (SETQ |LETTMP#1| |vars|)
        (SETQ |x| (CAR |LETTMP#1|))
        (SETQ |vars| (CDR |LETTMP#1|))
        (SETQ |sup| (SPADCALL |u| |x| |univariate|))
        (COND ((NULL |sup|) (|domainZero| |target|))
              ((AND (NULL (CDR |sup|))
                    (PROGN
                     (SETQ |ISTMP#1| (CAR |sup|))
                     (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) 0)
                          (PROGN (SETQ |c| (CDR |ISTMP#1|)) #1#))))
               (|P2DmpAux| |c| |source| S |target| |varlist| |vars| T$
                |univariate| |plus| |monom|))
              (#1#
               (PROGN
                (SETQ |var| (|position1| |x| |varlist|))
                (SETQ |u'| (|domainZero| |target|))
                ((LAMBDA (|bfVar#120| |bfVar#119|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#120|)
                          (PROGN (SETQ |bfVar#119| (CAR |bfVar#120|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (AND (CONSP |bfVar#119|)
                           (PROGN
                            (SETQ |e| (CAR |bfVar#119|))
                            (SETQ |c| (CDR |bfVar#119|))
                            #1#)
                           (PROGN
                            (SETQ |u''|
                                    (SPADCALL
                                     (|P2DmpAux| |c| |source| S |target|
                                      |varlist| |vars| T$ |univariate| |plus|
                                      |monom|)
                                     |var| |e| |monom|))
                            (SETQ |u'| (SPADCALL |u'| |u''| |plus|))))))
                    (SETQ |bfVar#120| (CDR |bfVar#120|))))
                 |sup| NIL)
                |u'|)))))))))

; P2Mp(u, source is [., S], target is [., y, T]) ==
;   u = '_$fromCoerceable_$ =>
;     -- might be able to say yes
;     canCoerce(source,T)
;   univariate := getFunctionFromDomain('univariate,
;     source,[source,$Symbol])
;   P2MpAux(u,source,S,target,copy y,y,T,univariate)

(DEFUN |P2Mp| (|u| |source| |target|)
  (PROG (|y| T$ S |univariate|)
    (RETURN
     (PROGN
      (SETQ |y| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| T$))
            ('T
             (PROGN
              (SETQ |univariate|
                      (|getFunctionFromDomain| '|univariate| |source|
                       (LIST |source| |$Symbol|)))
              (|P2MpAux| |u| |source| S |target| (COPY |y|) |y| T$
               |univariate|))))))))

; P2MpAux(u,source,S,target,varlist,vars,T,univariate) ==
;   u is [ =0,:c] =>       -- polynomial is a constant
;     (u' := coerceInt(objNewWrap(c,S),target)) or
;       coercionFailure()
;     objValUnwrap(u')
;
;   -- if no variables left, try to go to underdomain of target (T)
;   null vars =>
;     (u' := coerceInt(objNewWrap(u,source),T)) or
;       coercionFailure()
;     -- if successful, embed
;     [ 0,:objValUnwrap(u')]
;
;   -- there are variables, so get them out of u
;   [x,:vars] := vars
;   sup := SPADCALL(u,x,univariate)  -- this is a SUP P S
;   null sup =>           -- zero? unlikely.
;     domainZero(target)
;   -- degree 0 polynomial? (variable did not occur)
;   null(rest(sup)) and first(sup) is [ =0,:c] =>
;     -- call again, but with one less var
;     P2MpAux(c,source,S,target,varlist,vars,T,univariate)
;   terms := [[e,:P2MpAux(c,source,S,target,varlist,vars,T,univariate)] for
;     [e,:c] in sup]
;   [1, position1(x,varlist), :terms]

(DEFUN |P2MpAux| (|u| |source| S |target| |varlist| |vars| T$ |univariate|)
  (PROG (|c| |u'| |LETTMP#1| |x| |sup| |ISTMP#1| |e| |terms|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQUAL (CAR |u|) 0) (PROGN (SETQ |c| (CDR |u|)) #1='T))
       (PROGN
        (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|))
            (|coercionFailure|))
        (|objValUnwrap| |u'|)))
      ((NULL |vars|)
       (PROGN
        (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) T$))
            (|coercionFailure|))
        (CONS 0 (|objValUnwrap| |u'|))))
      (#1#
       (PROGN
        (SETQ |LETTMP#1| |vars|)
        (SETQ |x| (CAR |LETTMP#1|))
        (SETQ |vars| (CDR |LETTMP#1|))
        (SETQ |sup| (SPADCALL |u| |x| |univariate|))
        (COND ((NULL |sup|) (|domainZero| |target|))
              ((AND (NULL (CDR |sup|))
                    (PROGN
                     (SETQ |ISTMP#1| (CAR |sup|))
                     (AND (CONSP |ISTMP#1|) (EQUAL (CAR |ISTMP#1|) 0)
                          (PROGN (SETQ |c| (CDR |ISTMP#1|)) #1#))))
               (|P2MpAux| |c| |source| S |target| |varlist| |vars| T$
                |univariate|))
              (#1#
               (PROGN
                (SETQ |terms|
                        ((LAMBDA (|bfVar#123| |bfVar#122| |bfVar#121|)
                           (LOOP
                            (COND
                             ((OR (ATOM |bfVar#122|)
                                  (PROGN
                                   (SETQ |bfVar#121| (CAR |bfVar#122|))
                                   NIL))
                              (RETURN (NREVERSE |bfVar#123|)))
                             (#1#
                              (AND (CONSP |bfVar#121|)
                                   (PROGN
                                    (SETQ |e| (CAR |bfVar#121|))
                                    (SETQ |c| (CDR |bfVar#121|))
                                    #1#)
                                   (SETQ |bfVar#123|
                                           (CONS
                                            (CONS |e|
                                                  (|P2MpAux| |c| |source| S
                                                   |target| |varlist| |vars| T$
                                                   |univariate|))
                                            |bfVar#123|)))))
                            (SETQ |bfVar#122| (CDR |bfVar#122|))))
                         NIL |sup| NIL))
                (CONS 1 (CONS (|position1| |x| |varlist|) |terms|)))))))))))

; varIsOnlyVarInPoly(u, var) ==
;   u is [ =1, v, :termlist] =>
;     v ~= var => nil
;     and/[varIsOnlyVarInPoly(c,var) for [e,:c] in termlist]
;   true

(DEFUN |varIsOnlyVarInPoly| (|u| |var|)
  (PROG (|ISTMP#1| |v| |termlist| |e| |c|)
    (RETURN
     (COND
      ((AND (CONSP |u|) (EQUAL (CAR |u|) 1)
            (PROGN
             (SETQ |ISTMP#1| (CDR |u|))
             (AND (CONSP |ISTMP#1|)
                  (PROGN
                   (SETQ |v| (CAR |ISTMP#1|))
                   (SETQ |termlist| (CDR |ISTMP#1|))
                   #1='T))))
       (COND ((NOT (EQUAL |v| |var|)) NIL)
             (#1#
              ((LAMBDA (|bfVar#126| |bfVar#125| |bfVar#124|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#125|)
                        (PROGN (SETQ |bfVar#124| (CAR |bfVar#125|)) NIL))
                    (RETURN |bfVar#126|))
                   (#1#
                    (AND (CONSP |bfVar#124|)
                         (PROGN
                          (SETQ |e| (CAR |bfVar#124|))
                          (SETQ |c| (CDR |bfVar#124|))
                          #1#)
                         (PROGN
                          (SETQ |bfVar#126| (|varIsOnlyVarInPoly| |c| |var|))
                          (COND ((NOT |bfVar#126|) (RETURN NIL)))))))
                  (SETQ |bfVar#125| (CDR |bfVar#125|))))
               T |termlist| NIL))))
      (#1# T)))))

; P2Up(u,source is [.,S],target is [.,x,T]) ==
;   u = '_$fromCoerceable_$ => canCoerce(source,T)
;   u is [ =0,:c] =>
;     (u' := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     objValUnwrap(u')
;
;   -- see if the target var is the polynomial vars
;   varsFun := getFunctionFromDomain('variables,source,[source])
;   vars := SPADCALL(u,varsFun)
;   not member(x,vars) =>
;     (u' := coerceInt(objNewWrap(u,source),T)) or coercionFailure()
;     [[0,:objValUnwrap(u')]]
;
;   #vars = 1 and S = T =>
;       univariate := getFunctionFromDomain('univariate,
;           source,[source])
;       SPADCALL(u, univariate)
;   -- do a univariate to transform u to a UP(x,P S) and then coerce again
;   UPP := ['SparseUnivariatePolynomial, source]
;   univariate := getFunctionFromDomain('univariate,
;     source,[source,$Symbol])
;   upU := SPADCALL(u,x,univariate)  -- we may assume this has type UPP
;   SUP2Up_aux(upU, UPP, target)

(DEFUN |P2Up| (|u| |source| |target|)
  (PROG (|x| T$ S |c| |u'| |varsFun| |vars| |univariate| UPP |upU|)
    (RETURN
     (PROGN
      (SETQ |x| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| T$))
            ((AND (CONSP |u|) (EQUAL (CAR |u|) 0)
                  (PROGN (SETQ |c| (CDR |u|)) #2='T))
             (PROGN
              (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|))
                  (|coercionFailure|))
              (|objValUnwrap| |u'|)))
            (#2#
             (PROGN
              (SETQ |varsFun|
                      (|getFunctionFromDomain| '|variables| |source|
                       (LIST |source|)))
              (SETQ |vars| (SPADCALL |u| |varsFun|))
              (COND
               ((NULL (|member| |x| |vars|))
                (PROGN
                 (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) T$))
                     (|coercionFailure|))
                 (LIST (CONS 0 (|objValUnwrap| |u'|)))))
               ((AND (EQL (LENGTH |vars|) 1) (EQUAL S T$))
                (PROGN
                 (SETQ |univariate|
                         (|getFunctionFromDomain| '|univariate| |source|
                          (LIST |source|)))
                 (SPADCALL |u| |univariate|)))
               (#2#
                (PROGN
                 (SETQ UPP (LIST '|SparseUnivariatePolynomial| |source|))
                 (SETQ |univariate|
                         (|getFunctionFromDomain| '|univariate| |source|
                          (LIST |source| |$Symbol|)))
                 (SETQ |upU| (SPADCALL |u| |x| |univariate|))
                 (|SUP2Up_aux| |upU| UPP |target|)))))))))))

; Qf2PF(u,source is [.,D],target) ==
;   u = '_$fromCoerceable_$ => canCoerce(D,target)
;   [num,:den] := u
;   num':= coerceInt(objNewWrap(num,D),target) or
;     coercionFailure()
;   num' := objValUnwrap num'
;   den':= coerceInt(objNewWrap(den,D),target) or
;     coercionFailure()
;   den' := objValUnwrap den'
;   equalZero(den', target) => throwKeyedMsg("S2IA0001",NIL)
;   SPADCALL(num',den', getFunctionFromDomain("/",target,[target,target]))

(DEFUN |Qf2PF| (|u| |source| |target|)
  (PROG (D |num| |den| |num'| |den'|)
    (RETURN
     (PROGN
      (SETQ D (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| D |target|))
            (#1='T
             (PROGN
              (SETQ |num| (CAR |u|))
              (SETQ |den| (CDR |u|))
              (SETQ |num'|
                      (OR (|coerceInt| (|objNewWrap| |num| D) |target|)
                          (|coercionFailure|)))
              (SETQ |num'| (|objValUnwrap| |num'|))
              (SETQ |den'|
                      (OR (|coerceInt| (|objNewWrap| |den| D) |target|)
                          (|coercionFailure|)))
              (SETQ |den'| (|objValUnwrap| |den'|))
              (COND
               ((|equalZero| |den'| |target|) (|throwKeyedMsg| 'S2IA0001 NIL))
               (#1#
                (SPADCALL |num'| |den'|
                 (|getFunctionFromDomain| '/ |target|
                  (LIST |target| |target|))))))))))))

; Qf2domain(u,source is [.,D],target) ==
;   -- tests whether it is an element of the underlying domain
;   useUnder := (ut := underDomainOf target) and canCoerce(source,ut)
;   u = '_$fromCoerceable_$ => useUnder
;   not (containsPolynomial(D) and containsPolynomial(target)) and
;     useUnder => coercionFailure()    -- let other mechanism handle it
;   [num, :den] := u
;   (num' := coerceInt(objNewWrap(num,D),target)) or coercionFailure()
;   num' := objValUnwrap(num')
;   equalOne(den,D) => num'
;   (target is [.,[=$QuotientField,T]]) or
;     (target is [.,.,[=$QuotientField,T]]) =>
;       (den' := coerceInt(objNewWrap(den,D),T)) or coercionFailure()
;       den' := [domainOne(T),:objValUnwrap(den')]
;       timesfunc:= getFunctionFromDomain('_*,target,
;         [[$QuotientField,T],target])
;       SPADCALL(den',num',timesfunc)
;   coercionFailure()

(DEFUN |Qf2domain| (|u| |source| |target|)
  (PROG (D |ut| |useUnder| |num| |den| |num'| |ISTMP#1| |ISTMP#2| |ISTMP#3| T$
         |ISTMP#4| |den'| |timesfunc|)
    (RETURN
     (PROGN
      (SETQ D (CADR |source|))
      (SETQ |useUnder|
              (AND (SETQ |ut| (|underDomainOf| |target|))
                   (|canCoerce| |source| |ut|)))
      (COND ((EQ |u| '|$fromCoerceable$|) |useUnder|)
            ((AND
              (NULL
               (AND (|containsPolynomial| D) (|containsPolynomial| |target|)))
              |useUnder|)
             (|coercionFailure|))
            (#1='T
             (PROGN
              (SETQ |num| (CAR |u|))
              (SETQ |den| (CDR |u|))
              (OR (SETQ |num'| (|coerceInt| (|objNewWrap| |num| D) |target|))
                  (|coercionFailure|))
              (SETQ |num'| (|objValUnwrap| |num'|))
              (COND ((|equalOne| |den| D) |num'|)
                    ((OR
                      (AND (CONSP |target|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |target|))
                            (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                                 (PROGN
                                  (SETQ |ISTMP#2| (CAR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQUAL (CAR |ISTMP#2|) |$QuotientField|)
                                       (PROGN
                                        (SETQ |ISTMP#3| (CDR |ISTMP#2|))
                                        (AND (CONSP |ISTMP#3|)
                                             (EQ (CDR |ISTMP#3|) NIL)
                                             (PROGN
                                              (SETQ T$ (CAR |ISTMP#3|))
                                              #1#))))))))
                      (AND (CONSP |target|)
                           (PROGN
                            (SETQ |ISTMP#1| (CDR |target|))
                            (AND (CONSP |ISTMP#1|)
                                 (PROGN
                                  (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                                  (AND (CONSP |ISTMP#2|)
                                       (EQ (CDR |ISTMP#2|) NIL)
                                       (PROGN
                                        (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                                        (AND (CONSP |ISTMP#3|)
                                             (EQUAL (CAR |ISTMP#3|)
                                                    |$QuotientField|)
                                             (PROGN
                                              (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                              (AND (CONSP |ISTMP#4|)
                                                   (EQ (CDR |ISTMP#4|) NIL)
                                                   (PROGN
                                                    (SETQ T$ (CAR |ISTMP#4|))
                                                    #1#)))))))))))
                     (PROGN
                      (OR (SETQ |den'| (|coerceInt| (|objNewWrap| |den| D) T$))
                          (|coercionFailure|))
                      (SETQ |den'|
                              (CONS (|domainOne| T$) (|objValUnwrap| |den'|)))
                      (SETQ |timesfunc|
                              (|getFunctionFromDomain| '* |target|
                               (LIST (LIST |$QuotientField| T$) |target|)))
                      (SPADCALL |den'| |num'| |timesfunc|)))
                    (#1# (|coercionFailure|))))))))))

; Qf2EF(u,[.,S],target) ==
;   u = '_$fromCoerceable_$ => canCoerce(S,target)
;   [num,:den] := u
;   (num' := coerceInt(objNewWrap(num,S),target)) or
;     coercionFailure()
;   (den' := coerceInt(objNewWrap(den,S),target)) or
;     coercionFailure()
;   divfun := getFunctionFromDomain("/",target,[target,target])
;   SPADCALL(objValUnwrap(num'),objValUnwrap(den'),divfun)

(DEFUN |Qf2EF| (|u| |bfVar#127| |target|)
  (PROG (S |num| |den| |num'| |den'| |divfun|)
    (RETURN
     (PROGN
      (SETQ S (CADR |bfVar#127|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S |target|))
            ('T
             (PROGN
              (SETQ |num| (CAR |u|))
              (SETQ |den| (CDR |u|))
              (OR (SETQ |num'| (|coerceInt| (|objNewWrap| |num| S) |target|))
                  (|coercionFailure|))
              (OR (SETQ |den'| (|coerceInt| (|objNewWrap| |den| S) |target|))
                  (|coercionFailure|))
              (SETQ |divfun|
                      (|getFunctionFromDomain| '/ |target|
                       (LIST |target| |target|)))
              (SPADCALL (|objValUnwrap| |num'|) (|objValUnwrap| |den'|)
               |divfun|))))))))

; Qf2Qf(u0,[.,S],target is [.,T]) ==
;   u0 = '_$fromCoerceable_$ =>
;     S = ['Polynomial, [$QuotientField, $Integer]] and
;       T = '(Polynomial (Integer)) => true
;     canCoerce(S,T)
;   [a,:b] := u0
;   S = ['Polynomial, [$QuotientField, $Integer]] and
;     T = '(Polynomial (Integer)) =>
;       (a' := coerceInt(objNewWrap(a,S),target)) =>
;         (b' := coerceInt(objNewWrap(b,S),target)) =>
;           divfunc:= getFunctionFromDomain('_/,target,[target,target])
;           SPADCALL(objValUnwrap(a'),objValUnwrap(b'),divfunc)
;         coercionFailure()
;       coercionFailure()
;   (a' := coerceInt(objNewWrap(a,S),T)) =>
;     (b' := coerceInt(objNewWrap(b,S),T)) =>
;       [objValUnwrap(a'),:objValUnwrap(b')]
;     coercionFailure()
;   coercionFailure()

(DEFUN |Qf2Qf| (|u0| |bfVar#128| |target|)
  (PROG (T$ S |a| |b| |a'| |b'| |divfunc|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ S (CADR |bfVar#128|))
      (COND
       ((EQ |u0| '|$fromCoerceable$|)
        (COND
         ((AND
           (EQUAL S (LIST '|Polynomial| (LIST |$QuotientField| |$Integer|)))
           (EQUAL T$ '(|Polynomial| (|Integer|))))
          T)
         (#1='T (|canCoerce| S T$))))
       (#1#
        (PROGN
         (SETQ |a| (CAR |u0|))
         (SETQ |b| (CDR |u0|))
         (COND
          ((AND
            (EQUAL S (LIST '|Polynomial| (LIST |$QuotientField| |$Integer|)))
            (EQUAL T$ '(|Polynomial| (|Integer|))))
           (COND
            ((SETQ |a'| (|coerceInt| (|objNewWrap| |a| S) |target|))
             (COND
              ((SETQ |b'| (|coerceInt| (|objNewWrap| |b| S) |target|))
               (PROGN
                (SETQ |divfunc|
                        (|getFunctionFromDomain| '/ |target|
                         (LIST |target| |target|)))
                (SPADCALL (|objValUnwrap| |a'|) (|objValUnwrap| |b'|)
                 |divfunc|)))
              (#1# (|coercionFailure|))))
            (#1# (|coercionFailure|))))
          ((SETQ |a'| (|coerceInt| (|objNewWrap| |a| S) T$))
           (COND
            ((SETQ |b'| (|coerceInt| (|objNewWrap| |b| S) T$))
             (CONS (|objValUnwrap| |a'|) (|objValUnwrap| |b'|)))
            (#1# (|coercionFailure|))))
          (#1# (|coercionFailure|))))))))))

; Rm2L(x,[.,.,.,R],target) == M2L(x,['Matrix,R],target)

(DEFUN |Rm2L| (|x| |bfVar#129| |target|)
  (PROG (R)
    (RETURN
     (PROGN
      (SETQ R (CADDDR |bfVar#129|))
      (M2L |x| (LIST '|Matrix| R) |target|)))))

; Rm2M(x,[.,.,.,R],target is [.,S]) == M2M(x,[nil,R],target)

(DEFUN |Rm2M| (|x| |bfVar#130| |target|)
  (PROG (S R)
    (RETURN
     (PROGN
      (SETQ S (CADR |target|))
      (SETQ R (CADDDR |bfVar#130|))
      (M2M |x| (LIST NIL R) |target|)))))

; Rm2Sm(x,[.,n,m,S],[.,p,R]) ==
;   x = '_$fromCoerceable_$ => n=m and m=p and canCoerce(S,R)
;   n=m and m=p =>
;     M2M(x,[nil,S],[nil,R])
;   coercionFailure()

(DEFUN |Rm2Sm| (|x| |bfVar#131| |bfVar#132|)
  (PROG (|p| R |n| |m| S)
    (RETURN
     (PROGN
      (SETQ |p| (CADR . #1=(|bfVar#132|)))
      (SETQ R (CADDR . #1#))
      (SETQ |n| (CADR . #2=(|bfVar#131|)))
      (SETQ |m| (CADDR . #2#))
      (SETQ S (CADDDR . #2#))
      (COND
       ((EQ |x| '|$fromCoerceable$|)
        (AND (EQUAL |n| |m|) (EQUAL |m| |p|) (|canCoerce| S R)))
       ((AND (EQUAL |n| |m|) (EQUAL |m| |p|))
        (M2M |x| (LIST NIL S) (LIST NIL R)))
       ('T (|coercionFailure|)))))))

; Rm2V(x,[.,.,.,R],target) == M2V(x,['Matrix,R],target)

(DEFUN |Rm2V| (|x| |bfVar#133| |target|)
  (PROG (R)
    (RETURN
     (PROGN
      (SETQ R (CADDDR |bfVar#133|))
      (M2V |x| (LIST '|Matrix| R) |target|)))))

; SUP2Up_aux(u,source is [.,S],target is [.,x,T]) ==
;     -- must be careful in case any of the coeffs come back 0
;     u' := NIL
;     zero := getConstantFromDomain('(Zero),T)
;     for [e,:c] in u repeat
;         c' := objValUnwrap (coerceInt(objNewWrap(c,S),T) or
;             coercionFailure())
;         c' = zero => 'iterate
;         u' := [[e,:c'],:u']
;     nreverse u'

(DEFUN |SUP2Up_aux| (|u| |source| |target|)
  (PROG (|x| T$ S |u'| |zero| |e| |c| |c'|)
    (RETURN
     (PROGN
      (SETQ |x| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ S (CADR |source|))
      (SETQ |u'| NIL)
      (SETQ |zero| (|getConstantFromDomain| '(|Zero|) T$))
      ((LAMBDA (|bfVar#135| |bfVar#134|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#135|)
                (PROGN (SETQ |bfVar#134| (CAR |bfVar#135|)) NIL))
            (RETURN NIL))
           (#2='T
            (AND (CONSP |bfVar#134|)
                 (PROGN
                  (SETQ |e| (CAR |bfVar#134|))
                  (SETQ |c| (CDR |bfVar#134|))
                  #2#)
                 (PROGN
                  (SETQ |c'|
                          (|objValUnwrap|
                           (OR (|coerceInt| (|objNewWrap| |c| S) T$)
                               (|coercionFailure|))))
                  (COND ((EQUAL |c'| |zero|) '|iterate|)
                        (#2# (SETQ |u'| (CONS (CONS |e| |c'|) |u'|))))))))
          (SETQ |bfVar#135| (CDR |bfVar#135|))))
       |u| NIL)
      (NREVERSE |u'|)))))

; SUP2Up(u,source is [.,S],target is [.,x,T]) ==
;   u = '_$fromCoerceable_$ => canCoerce(source,T) or canCoerce(S,T)
;   null u => u
;   S = T => u
;   -- try to go underneath first
;   null (u' := coerceInt(objNewWrap(u,source),T)) =>
;       SUP2Up_aux(u, source, target)
;   [[0,:objValUnwrap u']]

(DEFUN |SUP2Up| (|u| |source| |target|)
  (PROG (|x| T$ S |u'|)
    (RETURN
     (PROGN
      (SETQ |x| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ S (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (|canCoerce| |source| T$) (|canCoerce| S T$)))
       ((NULL |u|) |u|) ((EQUAL S T$) |u|)
       ((NULL (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) T$)))
        (|SUP2Up_aux| |u| |source| |target|))
       ('T (LIST (CONS 0 (|objValUnwrap| |u'|)))))))))

; Sm2L(x,[.,.,R],target) == M2L(x,['Matrix,R],target)

(DEFUN |Sm2L| (|x| |bfVar#136| |target|)
  (PROG (R)
    (RETURN
     (PROGN
      (SETQ R (CADDR |bfVar#136|))
      (M2L |x| (LIST '|Matrix| R) |target|)))))

; Sm2M(x,[.,n,R],target is [.,S]) == M2M(x,[nil,R],target)

(DEFUN |Sm2M| (|x| |bfVar#137| |target|)
  (PROG (S |n| R)
    (RETURN
     (PROGN
      (SETQ S (CADR |target|))
      (SETQ |n| (CADR . #1=(|bfVar#137|)))
      (SETQ R (CADDR . #1#))
      (M2M |x| (LIST NIL R) |target|)))))

; Sm2PolyType(u,source is [sm,n,S], target is [pol,vl,T]) ==
;   -- only really handles cases like:
;   --      SM[2] P I -> P[x,y] SM[2] P I
;   -- works for UP, MP, DMP and NDMP
;   u = '_$fromCoerceable_$ => canCoerce(source,T)
;   -- first want to check case S is Polynomial
;   S is ['Polynomial,S'] =>
;     -- check to see if variable occurs in any of the terms
;     if ATOM vl
;       then vl' := [vl]
;       else vl' := vl
;     novars := true
;     for i in 0..(n-1) while novars repeat
;       for j in 0..(n-1) while novars repeat
;         varsUsed := varsInPoly(AREF(u, i, j))
;         or/[member(x,varsUsed) for x in vl'] => novars := nil
;     novars => coercionFailure()
;     source' := [sm,n,[pol,vl,S]]
;     null (u' := coerceInt(objNewWrap(u,source),source')) =>
;       coercionFailure()
;     null (u' := coerceInt(u',target)) =>
;       coercionFailure()
;     objValUnwrap(u')
;   -- let other cases be handled by standard machinery
;   coercionFailure()

(DEFUN |Sm2PolyType| (|u| |source| |target|)
  (PROG (|pol| |vl| T$ |sm| |n| S |ISTMP#1| |S'| |vl'| |novars| |varsUsed|
         |source'| |u'|)
    (RETURN
     (PROGN
      (SETQ |pol| (CAR |target|))
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |sm| (CAR |source|))
      (SETQ |n| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| T$))
            ((AND (CONSP S) (EQ (CAR S) '|Polynomial|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR S))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ |S'| (CAR |ISTMP#1|)) #3='T))))
             (PROGN
              (COND ((ATOM |vl|) (SETQ |vl'| (LIST |vl|)))
                    (#3# (SETQ |vl'| |vl|)))
              (SETQ |novars| T)
              ((LAMBDA (|bfVar#138| |i|)
                 (LOOP
                  (COND ((OR (> |i| |bfVar#138|) (NOT |novars|)) (RETURN NIL))
                        (#3#
                         ((LAMBDA (|bfVar#139| |j|)
                            (LOOP
                             (COND
                              ((OR (> |j| |bfVar#139|) (NOT |novars|))
                               (RETURN NIL))
                              (#3#
                               (PROGN
                                (SETQ |varsUsed|
                                        (|varsInPoly| (AREF |u| |i| |j|)))
                                (COND
                                 (((LAMBDA (|bfVar#141| |bfVar#140| |x|)
                                     (LOOP
                                      (COND
                                       ((OR (ATOM |bfVar#140|)
                                            (PROGN
                                             (SETQ |x| (CAR |bfVar#140|))
                                             NIL))
                                        (RETURN |bfVar#141|))
                                       (#3#
                                        (PROGN
                                         (SETQ |bfVar#141|
                                                 (|member| |x| |varsUsed|))
                                         (COND
                                          (|bfVar#141|
                                           (RETURN |bfVar#141|))))))
                                      (SETQ |bfVar#140| (CDR |bfVar#140|))))
                                   NIL |vl'| NIL)
                                  (SETQ |novars| NIL))))))
                             (SETQ |j| (+ |j| 1))))
                          (- |n| 1) 0)))
                  (SETQ |i| (+ |i| 1))))
               (- |n| 1) 0)
              (COND (|novars| (|coercionFailure|))
                    (#3#
                     (PROGN
                      (SETQ |source'| (LIST |sm| |n| (LIST |pol| |vl| S)))
                      (COND
                       ((NULL
                         (SETQ |u'|
                                 (|coerceInt| (|objNewWrap| |u| |source|)
                                  |source'|)))
                        (|coercionFailure|))
                       ((NULL (SETQ |u'| (|coerceInt| |u'| |target|)))
                        (|coercionFailure|))
                       (#3# (|objValUnwrap| |u'|))))))))
            (#3# (|coercionFailure|)))))))

; Sm2Rm(x,[.,n,R],[.,p,q,S]) ==
;   x = '_$fromCoerceable_$ => p=q and p=n and canCoerce(R,S)
;   p=q and p=n =>
;     M2M(x,[nil,R],[nil,S])
;   coercionFailure()

(DEFUN |Sm2Rm| (|x| |bfVar#142| |bfVar#143|)
  (PROG (|p| |q| S |n| R)
    (RETURN
     (PROGN
      (SETQ |p| (CADR . #1=(|bfVar#143|)))
      (SETQ |q| (CADDR . #1#))
      (SETQ S (CADDDR . #1#))
      (SETQ |n| (CADR . #2=(|bfVar#142|)))
      (SETQ R (CADDR . #2#))
      (COND
       ((EQ |x| '|$fromCoerceable$|)
        (AND (EQUAL |p| |q|) (EQUAL |p| |n|) (|canCoerce| R S)))
       ((AND (EQUAL |p| |q|) (EQUAL |p| |n|))
        (M2M |x| (LIST NIL R) (LIST NIL S)))
       ('T (|coercionFailure|)))))))

; Sm2V(x,[.,.,R],target) == M2V(x,['Matrix,R],target)

(DEFUN |Sm2V| (|x| |bfVar#144| |target|)
  (PROG (R)
    (RETURN
     (PROGN
      (SETQ R (CADDR |bfVar#144|))
      (M2V |x| (LIST '|Matrix| R) |target|)))))

; Sy2OV(u,source,target is [.,vl]) ==
;   u = '_$fromCoerceable_$ => nil
;   res := position1(u,vl)
;   res = 0 => coercionFailure()
;   res

(DEFUN |Sy2OV| (|u| |source| |target|)
  (PROG (|vl| |res|)
    (RETURN
     (PROGN
      (SETQ |vl| (CADR |target|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL)
            (#1='T
             (PROGN
              (SETQ |res| (|position1| |u| |vl|))
              (COND ((EQL |res| 0) (|coercionFailure|)) (#1# |res|)))))))))

; Sy2Dmp(u,source,target is [dmp,vl,S]) ==
;   u = '_$fromCoerceable_$ => canCoerce(source,S)
;   len:= #vl
;   -1~=(n:= position(u,vl)) =>
;     u:= wrap LIST [LIST2VEC [(n=i => 1; 0) for i in 0..len-1],:1]
;     objValUnwrap(coerceInt(objNew(u,[dmp,vl,$Integer]),target))
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [[Zeros len,:objValUnwrap u]]

(DEFUN |Sy2Dmp| (|u| |source| |target|)
  (PROG (|dmp| |vl| S |len| |n|)
    (RETURN
     (PROGN
      (SETQ |dmp| (CAR |target|))
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| S))
            (#2='T
             (PROGN
              (SETQ |len| (LENGTH |vl|))
              (COND
               ((NOT (EQUAL (- 1) (SETQ |n| (|position| |u| |vl|))))
                (PROGN
                 (SETQ |u|
                         (|wrap|
                          (LIST
                           (CONS
                            (LIST2VEC
                             ((LAMBDA (|bfVar#146| |bfVar#145| |i|)
                                (LOOP
                                 (COND
                                  ((> |i| |bfVar#145|)
                                   (RETURN (NREVERSE |bfVar#146|)))
                                  (#2#
                                   (SETQ |bfVar#146|
                                           (CONS
                                            (COND ((EQUAL |n| |i|) 1) (#2# 0))
                                            |bfVar#146|))))
                                 (SETQ |i| (+ |i| 1))))
                              NIL (- |len| 1) 0))
                            1))))
                 (|objValUnwrap|
                  (|coerceInt| (|objNew| |u| (LIST |dmp| |vl| |$Integer|))
                   |target|))))
               (#2#
                (PROGN
                 (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
                     (|coercionFailure|))
                 (LIST (CONS (|Zeros| |len|) (|objValUnwrap| |u|)))))))))))))

; Sy2Mp(u,source,target is [mp,vl,S]) ==
;   u = '_$fromCoerceable_$ => canCoerce(source,S)
;   (n:= position1(u,vl)) ~= 0 =>
;     [1,n,[1,0,:domainOne(S)]]
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [0,:objValUnwrap(u)]

(DEFUN |Sy2Mp| (|u| |source| |target|)
  (PROG (|mp| |vl| S |n|)
    (RETURN
     (PROGN
      (SETQ |mp| (CAR |target|))
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| S))
            ((NOT (EQL (SETQ |n| (|position1| |u| |vl|)) 0))
             (LIST 1 |n| (CONS 1 (CONS 0 (|domainOne| S)))))
            ('T
             (PROGN
              (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
                  (|coercionFailure|))
              (CONS 0 (|objValUnwrap| |u|)))))))))

; Sy2NDmp(u,source,target is [ndmp,vl,S]) ==
;   u = '_$fromCoerceable_$ => canCoerce(source,S)
;   len:= #vl
;   -1~=(n:= position(u,vl)) =>
;     u:= wrap LIST [LIST2VEC [(n=i => 1; 0) for i in 0..len-1],:1]
;     objValUnwrap(coerceInt(objNew(u,[ndmp,vl,$Integer]),target))
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [[Zeros len,:objValUnwrap(u)]]

(DEFUN |Sy2NDmp| (|u| |source| |target|)
  (PROG (|ndmp| |vl| S |len| |n|)
    (RETURN
     (PROGN
      (SETQ |ndmp| (CAR |target|))
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| S))
            (#2='T
             (PROGN
              (SETQ |len| (LENGTH |vl|))
              (COND
               ((NOT (EQUAL (- 1) (SETQ |n| (|position| |u| |vl|))))
                (PROGN
                 (SETQ |u|
                         (|wrap|
                          (LIST
                           (CONS
                            (LIST2VEC
                             ((LAMBDA (|bfVar#148| |bfVar#147| |i|)
                                (LOOP
                                 (COND
                                  ((> |i| |bfVar#147|)
                                   (RETURN (NREVERSE |bfVar#148|)))
                                  (#2#
                                   (SETQ |bfVar#148|
                                           (CONS
                                            (COND ((EQUAL |n| |i|) 1) (#2# 0))
                                            |bfVar#148|))))
                                 (SETQ |i| (+ |i| 1))))
                              NIL (- |len| 1) 0))
                            1))))
                 (|objValUnwrap|
                  (|coerceInt| (|objNew| |u| (LIST |ndmp| |vl| |$Integer|))
                   |target|))))
               (#2#
                (PROGN
                 (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
                     (|coercionFailure|))
                 (LIST (CONS (|Zeros| |len|) (|objValUnwrap| |u|)))))))))))))

; Sy2P(u,source,target is [poly,S]) ==
;   u = '_$fromCoerceable_$ => true
;   -- first try to get it into an underdomain
;   if (S ~= $Integer) then
;     u' := coerceInt(objNewWrap(u,source),S)
;     if u' then return [0,:objValUnwrap(u')]
;   -- if that failed, return it as a polynomial variable
;   [1,u,[1,0,:domainOne(S)]]

(DEFUN |Sy2P| (|u| |source| |target|)
  (PROG (|poly| S |u'|)
    (RETURN
     (PROGN
      (SETQ |poly| (CAR |target|))
      (SETQ S (CADR |target|))
      (COND ((EQ |u| '|$fromCoerceable$|) T)
            ('T
             (PROGN
              (COND
               ((NOT (EQUAL S |$Integer|))
                (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) S))
                (COND (|u'| (RETURN (CONS 0 (|objValUnwrap| |u'|)))))))
              (LIST 1 |u| (CONS 1 (CONS 0 (|domainOne| S)))))))))))

; Sy2Up(u,source,target is [up,x,S]) ==
;   u = '_$fromCoerceable_$ => canCoerce(source,S)
;   u=x => [[1,:domainOne(S)]]
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [[0,:objValUnwrap u]]

(DEFUN |Sy2Up| (|u| |source| |target|)
  (PROG (|up| |x| S)
    (RETURN
     (PROGN
      (SETQ |up| (CAR |target|))
      (SETQ |x| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| S))
            ((EQUAL |u| |x|) (LIST (CONS 1 (|domainOne| S))))
            ('T
             (PROGN
              (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
                  (|coercionFailure|))
              (LIST (CONS 0 (|objValUnwrap| |u|))))))))))

; Sy2Var(u,source,target is [.,x]) ==
;   u = '_$fromCoerceable_$ => NIL
;   u=x => u
;   coercionFailure()

(DEFUN |Sy2Var| (|u| |source| |target|)
  (PROG (|x|)
    (RETURN
     (PROGN
      (SETQ |x| (CADR |target|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL) ((EQUAL |u| |x|) |u|)
            ('T (|coercionFailure|)))))))

; Up2Dmp(u,source is ['UnivariatePolynomial,var,S],
;  target is ['DistributedMultivariatePolynomial,vl,T]) ==
;   -- var must be a member of vl, or u is a constant
;   u = '_$fromCoerceable_$ => member(var,vl) and canCoerce(S,target)
;   null u => domainZero(target)
;   u is [[e,:c]] and e=0 =>
;     z:= coerceInt(objNewWrap(c,S),target) => objValUnwrap(z)
;     coercionFailure()
;   member(var,vl) =>
;     x:= domainZero(target)
;     one:= domainOne(T)
;     plusfunc:= getFunctionFromDomain('_+,target,[target,target])
;     multfunc:= getFunctionFromDomain('_*,target,[target,target])
;     n:= #vl ; p:= POSN1(var,vl)
;     l1:= not (p=0) and [0 for m in 1..p]
;     l2:= not (p=n-1) and [0 for m in p..n-2]
;     for [e,:c] in u until not z repeat
;       z:= coerceInt(objNewWrap(c,S),target) =>
;         y:= SPADCALL(objValUnwrap(z),
;           [[LIST2VEC [:l1,e,:l2],:one]],multfunc)
;         x:= SPADCALL(x,y,plusfunc)
;     z => x
;     coercionFailure()
;   coercionFailure()

(DEFUN |Up2Dmp| (|u| |source| |target|)
  (PROG (|vl| T$ |var| S |ISTMP#1| |e| |c| |z| |x| |one| |plusfunc| |multfunc|
         |n| |p| |l1| |l2| |y|)
    (RETURN
     (PROGN
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |var| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (AND (|member| |var| |vl|) (|canCoerce| S |target|)))
       ((NULL |u|) (|domainZero| |target|))
       ((AND (CONSP |u|) (EQ (CDR |u|) NIL)
             (PROGN
              (SETQ |ISTMP#1| (CAR |u|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |e| (CAR |ISTMP#1|))
                    (SETQ |c| (CDR |ISTMP#1|))
                    #3='T)))
             (EQL |e| 0))
        (COND
         ((SETQ |z| (|coerceInt| (|objNewWrap| |c| S) |target|))
          (|objValUnwrap| |z|))
         (#3# (|coercionFailure|))))
       ((|member| |var| |vl|)
        (PROGN
         (SETQ |x| (|domainZero| |target|))
         (SETQ |one| (|domainOne| T$))
         (SETQ |plusfunc|
                 (|getFunctionFromDomain| '+ |target|
                  (LIST |target| |target|)))
         (SETQ |multfunc|
                 (|getFunctionFromDomain| '* |target|
                  (LIST |target| |target|)))
         (SETQ |n| (LENGTH |vl|))
         (SETQ |p| (POSN1 |var| |vl|))
         (SETQ |l1|
                 (AND (NULL (EQL |p| 0))
                      ((LAMBDA (|bfVar#149| |m|)
                         (LOOP
                          (COND ((> |m| |p|) (RETURN (NREVERSE |bfVar#149|)))
                                (#3# (SETQ |bfVar#149| (CONS 0 |bfVar#149|))))
                          (SETQ |m| (+ |m| 1))))
                       NIL 1)))
         (SETQ |l2|
                 (AND (NULL (EQUAL |p| (- |n| 1)))
                      ((LAMBDA (|bfVar#151| |bfVar#150| |m|)
                         (LOOP
                          (COND
                           ((> |m| |bfVar#150|)
                            (RETURN (NREVERSE |bfVar#151|)))
                           (#3# (SETQ |bfVar#151| (CONS 0 |bfVar#151|))))
                          (SETQ |m| (+ |m| 1))))
                       NIL (- |n| 2) |p|)))
         ((LAMBDA (|bfVar#153| |bfVar#152| |bfVar#154|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#153|)
                   (PROGN (SETQ |bfVar#152| (CAR |bfVar#153|)) NIL)
                   |bfVar#154|)
               (RETURN NIL))
              (#3#
               (AND (CONSP |bfVar#152|)
                    (PROGN
                     (SETQ |e| (CAR |bfVar#152|))
                     (SETQ |c| (CDR |bfVar#152|))
                     #3#)
                    (COND
                     ((SETQ |z| (|coerceInt| (|objNewWrap| |c| S) |target|))
                      (IDENTITY
                       (PROGN
                        (SETQ |y|
                                (SPADCALL (|objValUnwrap| |z|)
                                 (LIST
                                  (CONS
                                   (LIST2VEC (APPEND |l1| (CONS |e| |l2|)))
                                   |one|))
                                 |multfunc|))
                        (SETQ |x| (SPADCALL |x| |y| |plusfunc|)))))))))
             (SETQ |bfVar#153| (CDR |bfVar#153|))
             (SETQ |bfVar#154| (NULL |z|))))
          |u| NIL NIL)
         (COND (|z| |x|) (#3# (|coercionFailure|)))))
       (#3# (|coercionFailure|)))))))

; Up2Expr(u,source is [up,var,S], target is [Expr,T]) ==
;     u = '_$fromCoerceable_$ => canCoerce(S, target)
;
;     null u => domainZero(target)
;
;     u is [[e,:c]] and e=0 =>
;         (z := coerceInt(objNewWrap(c, S), target)) => objValUnwrap(z)
;         coercionFailure()
;
;     sym := objValUnwrap coerceInt(objNewWrap(var, $Symbol), target)
;
;     plus := getFunctionFromDomain("+",  target, [target, target])
;     mult := getFunctionFromDomain("*",  target, [target, target])
;     expn := getFunctionFromDomain("^", target, [target, $Integer])
;
;     -- coerce via Horner's rule
;
;     [e1, :c1] := first u
;     if not (S = target) then
;         not (c1 := coerceInt(objNewWrap(c1, S), target)) => coercionFailure()
;         c1 := objValUnwrap(c1)
;
;     for [e2, :c2] in rest u repeat
;         coef :=
;             e1 - e2 = 1 => sym
;             SPADCALL(sym, e1-e2, expn)
;         if not (S = target) then
;             not (c2 := coerceInt(objNewWrap(c2, S), target)) =>
;                 coercionFailure()
;             c2 := objValUnwrap(c2)
;         coef := SPADCALL(SPADCALL(c1, coef, mult), c2, plus)
;         e1 := e2
;         c1 := coef
;
;     e1 = 0 => c1
;     e1 = 1 => SPADCALL(sym, c1, mult)
;     SPADCALL(SPADCALL(sym, e1, expn), c1, mult)

(DEFUN |Up2Expr| (|u| |source| |target|)
  (PROG (|Expr| T$ |up| |var| S |ISTMP#1| |e| |c| |z| |sym| |plus| |mult|
         |expn| |LETTMP#1| |e1| |c1| |e2| |c2| |coef|)
    (RETURN
     (PROGN
      (SETQ |Expr| (CAR |target|))
      (SETQ T$ (CADR |target|))
      (SETQ |up| (CAR |source|))
      (SETQ |var| (CADR . #1=(|source|)))
      (SETQ S (CADDR . #1#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S |target|))
            ((NULL |u|) (|domainZero| |target|))
            ((AND (CONSP |u|) (EQ (CDR |u|) NIL)
                  (PROGN
                   (SETQ |ISTMP#1| (CAR |u|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |e| (CAR |ISTMP#1|))
                         (SETQ |c| (CDR |ISTMP#1|))
                         #2='T)))
                  (EQL |e| 0))
             (COND
              ((SETQ |z| (|coerceInt| (|objNewWrap| |c| S) |target|))
               (|objValUnwrap| |z|))
              (#2# (|coercionFailure|))))
            (#2#
             (PROGN
              (SETQ |sym|
                      (|objValUnwrap|
                       (|coerceInt| (|objNewWrap| |var| |$Symbol|) |target|)))
              (SETQ |plus|
                      (|getFunctionFromDomain| '+ |target|
                       (LIST |target| |target|)))
              (SETQ |mult|
                      (|getFunctionFromDomain| '* |target|
                       (LIST |target| |target|)))
              (SETQ |expn|
                      (|getFunctionFromDomain| '^ |target|
                       (LIST |target| |$Integer|)))
              (SETQ |LETTMP#1| (CAR |u|))
              (SETQ |e1| (CAR |LETTMP#1|))
              (SETQ |c1| (CDR |LETTMP#1|))
              (COND
               ((NULL (EQUAL S |target|))
                (COND
                 ((NULL
                   (SETQ |c1| (|coerceInt| (|objNewWrap| |c1| S) |target|)))
                  (|coercionFailure|))
                 (#2# (SETQ |c1| (|objValUnwrap| |c1|))))))
              ((LAMBDA (|bfVar#156| |bfVar#155|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#156|)
                        (PROGN (SETQ |bfVar#155| (CAR |bfVar#156|)) NIL))
                    (RETURN NIL))
                   (#2#
                    (AND (CONSP |bfVar#155|)
                         (PROGN
                          (SETQ |e2| (CAR |bfVar#155|))
                          (SETQ |c2| (CDR |bfVar#155|))
                          #2#)
                         (PROGN
                          (SETQ |coef|
                                  (COND ((EQL (- |e1| |e2|) 1) |sym|)
                                        (#2#
                                         (SPADCALL |sym| (- |e1| |e2|)
                                          |expn|))))
                          (COND
                           ((NULL (EQUAL S |target|))
                            (COND
                             ((NULL
                               (SETQ |c2|
                                       (|coerceInt| (|objNewWrap| |c2| S)
                                        |target|)))
                              (|coercionFailure|))
                             (#2# (SETQ |c2| (|objValUnwrap| |c2|))))))
                          (SETQ |coef|
                                  (SPADCALL (SPADCALL |c1| |coef| |mult|) |c2|
                                   |plus|))
                          (SETQ |e1| |e2|)
                          (SETQ |c1| |coef|)))))
                  (SETQ |bfVar#156| (CDR |bfVar#156|))))
               (CDR |u|) NIL)
              (COND ((EQL |e1| 0) |c1|)
                    ((EQL |e1| 1) (SPADCALL |sym| |c1| |mult|))
                    (#2#
                     (SPADCALL (SPADCALL |sym| |e1| |expn|) |c1|
                      |mult|))))))))))

; Up2FR(u,S is [.,x,R],target is [.,T]) ==
;   u = '_$fromCoerceable_$ =>
;     S ~= T => nil
;     R in '((Integer) (Fraction (Integer))) => true
;     nil
;   S ~= T => coercionFailure()
;   package :=
;     R = $Integer => ['UnivariateFactorize,S]
;     R = $RationalNumber => package := ['RationalFactorize,S]
;     coercionFailure()
;   factor := getFunctionFromDomain('factor,package,[S])
;   SPADCALL(u,factor)

(DEFUN |Up2FR| (|u| S |target|)
  (PROG (T$ |x| R |package| |factor|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ |x| (CADR . #1=(S)))
      (SETQ R (CADDR . #1#))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND ((NOT (EQUAL S T$)) NIL)
              ((|member| R '((|Integer|) (|Fraction| (|Integer|)))) T)
              (#2='T NIL)))
       ((NOT (EQUAL S T$)) (|coercionFailure|))
       (#2#
        (PROGN
         (SETQ |package|
                 (COND ((EQUAL R |$Integer|) (LIST '|UnivariateFactorize| S))
                       ((EQUAL R |$RationalNumber|)
                        (SETQ |package| (LIST '|RationalFactorize| S)))
                       (#2# (|coercionFailure|))))
         (SETQ |factor| (|getFunctionFromDomain| '|factor| |package| (LIST S)))
         (SPADCALL |u| |factor|))))))))

; Up2Mp(u,source is [.,x,S], target is [.,vl,T]) ==
;   u = '_$fromCoerceable_$ =>
;     member(x,vl) => canCoerce(S,T)
;     canCoerce(source,T)
;
;   null u => domainZero(target)
;
;   null(rest(u)) and (first(u) is [e,:c]) and e=0 =>
;     x:= coerceInt(objNewWrap(c,S),target) => objValUnwrap(x)
;     coercionFailure()
;
;   null member(x,vl) =>
;     (x := coerceInt(objNewWrap(u,source),T)) or coercionFailure()
;     [0,:objValUnwrap(x)]
;
;   plus  := getFunctionFromDomain('_+,target,[target,target])
;   monom := getFunctionFromDomain('monomial,target,
;     [target,['OrderedVariableList,vl],$NonNegativeInteger])
;   sum := domainZero(target)
;   pos := position1(x,vl)
;
;   for [e,:c] in u repeat
;     (p := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     mon := SPADCALL(objValUnwrap(p),pos,e,monom)
;     sum := SPADCALL(sum,mon,plus)
;   sum

(DEFUN |Up2Mp| (|u| |source| |target|)
  (PROG (|vl| T$ |x| S |ISTMP#1| |e| |c| |plus| |monom| |sum| |pos| |p| |mon|)
    (RETURN
     (PROGN
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |x| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND ((|member| |x| |vl|) (|canCoerce| S T$))
              (#3='T (|canCoerce| |source| T$))))
       ((NULL |u|) (|domainZero| |target|))
       ((AND (NULL (CDR |u|))
             (PROGN
              (SETQ |ISTMP#1| (CAR |u|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |e| (CAR |ISTMP#1|))
                    (SETQ |c| (CDR |ISTMP#1|))
                    #3#)))
             (EQL |e| 0))
        (COND
         ((SETQ |x| (|coerceInt| (|objNewWrap| |c| S) |target|))
          (|objValUnwrap| |x|))
         (#3# (|coercionFailure|))))
       ((NULL (|member| |x| |vl|))
        (PROGN
         (OR (SETQ |x| (|coerceInt| (|objNewWrap| |u| |source|) T$))
             (|coercionFailure|))
         (CONS 0 (|objValUnwrap| |x|))))
       (#3#
        (PROGN
         (SETQ |plus|
                 (|getFunctionFromDomain| '+ |target|
                  (LIST |target| |target|)))
         (SETQ |monom|
                 (|getFunctionFromDomain| '|monomial| |target|
                  (LIST |target| (LIST '|OrderedVariableList| |vl|)
                        |$NonNegativeInteger|)))
         (SETQ |sum| (|domainZero| |target|))
         (SETQ |pos| (|position1| |x| |vl|))
         ((LAMBDA (|bfVar#158| |bfVar#157|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#158|)
                   (PROGN (SETQ |bfVar#157| (CAR |bfVar#158|)) NIL))
               (RETURN NIL))
              (#3#
               (AND (CONSP |bfVar#157|)
                    (PROGN
                     (SETQ |e| (CAR |bfVar#157|))
                     (SETQ |c| (CDR |bfVar#157|))
                     #3#)
                    (PROGN
                     (OR (SETQ |p| (|coerceInt| (|objNewWrap| |c| S) |target|))
                         (|coercionFailure|))
                     (SETQ |mon|
                             (SPADCALL (|objValUnwrap| |p|) |pos| |e| |monom|))
                     (SETQ |sum| (SPADCALL |sum| |mon| |plus|))))))
             (SETQ |bfVar#158| (CDR |bfVar#158|))))
          |u| NIL)
         |sum|)))))))

; Up2P(u,source is [.,var,S],target is [.,T]) ==
;   u = '_$fromCoerceable_$ => canCoerce(S,target)
;   null u => domainZero(target)
;   u is [[e,:c]] and e=0 =>
;     x:= coerceInt(objNewWrap(c,S),target) => objValUnwrap(x)
;     coercionFailure()
;   S = T =>
;       res := []
;       for [e,:c] in u repeat
;           res := cons([e, 0, :c], res)
;       [1, var, :NREVERSE res]
;   pol:= domainZero(target)
;   one:= domainOne(T)
;   plusfunc := getFunctionFromDomain("+",target,[target,target])
;   multfunc := getFunctionFromDomain("*",target,[target,target])
;   for [e,:c] in u until not x repeat
;     x:= coerceInt(objNewWrap(c,S),target) =>
;       term:= SPADCALL([1,var,[e,0,:one]],objValUnwrap(x),multfunc)
;       pol:= SPADCALL(pol,term,plusfunc)
;     coercionFailure()
;   x => pol
;   coercionFailure()

(DEFUN |Up2P| (|u| |source| |target|)
  (PROG (T$ |var| S |ISTMP#1| |e| |c| |x| |res| |pol| |one| |plusfunc|
         |multfunc| |term|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ |var| (CADR . #1=(|source|)))
      (SETQ S (CADDR . #1#))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S |target|))
            ((NULL |u|) (|domainZero| |target|))
            ((AND (CONSP |u|) (EQ (CDR |u|) NIL)
                  (PROGN
                   (SETQ |ISTMP#1| (CAR |u|))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN
                         (SETQ |e| (CAR |ISTMP#1|))
                         (SETQ |c| (CDR |ISTMP#1|))
                         #2='T)))
                  (EQL |e| 0))
             (COND
              ((SETQ |x| (|coerceInt| (|objNewWrap| |c| S) |target|))
               (|objValUnwrap| |x|))
              (#2# (|coercionFailure|))))
            ((EQUAL S T$)
             (PROGN
              (SETQ |res| NIL)
              ((LAMBDA (|bfVar#160| |bfVar#159|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#160|)
                        (PROGN (SETQ |bfVar#159| (CAR |bfVar#160|)) NIL))
                    (RETURN NIL))
                   (#2#
                    (AND (CONSP |bfVar#159|)
                         (PROGN
                          (SETQ |e| (CAR |bfVar#159|))
                          (SETQ |c| (CDR |bfVar#159|))
                          #2#)
                         (SETQ |res| (CONS (CONS |e| (CONS 0 |c|)) |res|)))))
                  (SETQ |bfVar#160| (CDR |bfVar#160|))))
               |u| NIL)
              (CONS 1 (CONS |var| (NREVERSE |res|)))))
            (#2#
             (PROGN
              (SETQ |pol| (|domainZero| |target|))
              (SETQ |one| (|domainOne| T$))
              (SETQ |plusfunc|
                      (|getFunctionFromDomain| '+ |target|
                       (LIST |target| |target|)))
              (SETQ |multfunc|
                      (|getFunctionFromDomain| '* |target|
                       (LIST |target| |target|)))
              ((LAMBDA (|bfVar#162| |bfVar#161| |bfVar#163|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#162|)
                        (PROGN (SETQ |bfVar#161| (CAR |bfVar#162|)) NIL)
                        |bfVar#163|)
                    (RETURN NIL))
                   (#2#
                    (AND (CONSP |bfVar#161|)
                         (PROGN
                          (SETQ |e| (CAR |bfVar#161|))
                          (SETQ |c| (CDR |bfVar#161|))
                          #2#)
                         (COND
                          ((SETQ |x|
                                   (|coerceInt| (|objNewWrap| |c| S) |target|))
                           (PROGN
                            (SETQ |term|
                                    (SPADCALL
                                     (LIST 1 |var| (CONS |e| (CONS 0 |one|)))
                                     (|objValUnwrap| |x|) |multfunc|))
                            (SETQ |pol| (SPADCALL |pol| |term| |plusfunc|))))
                          (#2# (|coercionFailure|))))))
                  (SETQ |bfVar#162| (CDR |bfVar#162|))
                  (SETQ |bfVar#163| (NULL |x|))))
               |u| NIL NIL)
              (COND (|x| |pol|) (#2# (|coercionFailure|))))))))))

; Up2SUP(u,source is [.,x,S],target is [.,T]) ==
;   u = '_$fromCoerceable_$ => canCoerce(source,T) or canCoerce(S,T)
;   null u => u
;   S = T => u
;   -- try to go underneath first
;   null (u' := coerceInt(objNewWrap(u,source),T)) =>
;     u' := NIL
;     zero := getConstantFromDomain('(Zero),T)
;     for [e,:c] in u repeat
;       c' := objValUnwrap (coerceInt(objNewWrap(c,S),T) or
;         coercionFailure())
;       c' = zero => 'iterate
;       u' := [[e,:c'],:u']
;     nreverse u'
;   [[0,:objValUnwrap u']]

(DEFUN |Up2SUP| (|u| |source| |target|)
  (PROG (T$ |x| S |u'| |zero| |e| |c| |c'|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR |target|))
      (SETQ |x| (CADR . #1=(|source|)))
      (SETQ S (CADDR . #1#))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (|canCoerce| |source| T$) (|canCoerce| S T$)))
       ((NULL |u|) |u|) ((EQUAL S T$) |u|)
       ((NULL (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) T$)))
        (PROGN
         (SETQ |u'| NIL)
         (SETQ |zero| (|getConstantFromDomain| '(|Zero|) T$))
         ((LAMBDA (|bfVar#165| |bfVar#164|)
            (LOOP
             (COND
              ((OR (ATOM |bfVar#165|)
                   (PROGN (SETQ |bfVar#164| (CAR |bfVar#165|)) NIL))
               (RETURN NIL))
              (#2='T
               (AND (CONSP |bfVar#164|)
                    (PROGN
                     (SETQ |e| (CAR |bfVar#164|))
                     (SETQ |c| (CDR |bfVar#164|))
                     #2#)
                    (PROGN
                     (SETQ |c'|
                             (|objValUnwrap|
                              (OR (|coerceInt| (|objNewWrap| |c| S) T$)
                                  (|coercionFailure|))))
                     (COND ((EQUAL |c'| |zero|) '|iterate|)
                           (#2# (SETQ |u'| (CONS (CONS |e| |c'|) |u'|))))))))
             (SETQ |bfVar#165| (CDR |bfVar#165|))))
          |u| NIL)
         (NREVERSE |u'|)))
       (#2# (LIST (CONS 0 (|objValUnwrap| |u'|)))))))))

; Up2Up(u,source is [.,v1,S], target is [.,v2,T]) ==
;   -- if v1 = v2 then this is handled by coerceIntByMap
;   -- this only handles case where poly is a constant
;   u = '_$fromCoerceable_$ =>
;     v1=v2 => canCoerce(S,T)
;     canCoerce(source,T)
;   null u => u
;   u is [[e,:c]] and e=0 =>
;     x:= coerceInt(objNewWrap(c,S),target) => objValUnwrap(x)
;     coercionFailure()
;   coercionFailure()

(DEFUN |Up2Up| (|u| |source| |target|)
  (PROG (|v2| T$ |v1| S |ISTMP#1| |e| |c| |x|)
    (RETURN
     (PROGN
      (SETQ |v2| (CADR . #1=(|target|)))
      (SETQ T$ (CADDR . #1#))
      (SETQ |v1| (CADR . #2=(|source|)))
      (SETQ S (CADDR . #2#))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (COND ((EQUAL |v1| |v2|) (|canCoerce| S T$))
              (#3='T (|canCoerce| |source| T$))))
       ((NULL |u|) |u|)
       ((AND (CONSP |u|) (EQ (CDR |u|) NIL)
             (PROGN
              (SETQ |ISTMP#1| (CAR |u|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |e| (CAR |ISTMP#1|))
                    (SETQ |c| (CDR |ISTMP#1|))
                    #3#)))
             (EQL |e| 0))
        (COND
         ((SETQ |x| (|coerceInt| (|objNewWrap| |c| S) |target|))
          (|objValUnwrap| |x|))
         (#3# (|coercionFailure|))))
       (#3# (|coercionFailure|)))))))

; insertAlist(a,b,l) ==
;   null l => [[a,:b]]
;   a = l.0.0 => (rplac(CDAR l, b); l)
;   _?ORDER(l.0.0,a) => [[a,:b],:l]
;   (fn(a,b,l);l) where fn(a,b,l) ==
;     null rest l => rplac(rest l, [[a, :b]])
;     a = l.1.0 => rplac(rest(l.1), b)
;     _?ORDER(l.1.0, a) => rplac(rest l, [[a, :b], :rest l])
;     fn(a, b, rest l)

(DEFUN |insertAlist| (|a| |b| |l|)
  (PROG ()
    (RETURN
     (COND ((NULL |l|) (LIST (CONS |a| |b|)))
           ((EQUAL |a| (ELT (ELT |l| 0) 0))
            (PROGN (|rplac| (CDAR |l|) |b|) |l|))
           ((?ORDER (ELT (ELT |l| 0) 0) |a|) (CONS (CONS |a| |b|) |l|))
           ('T (PROGN (|insertAlist,fn| |a| |b| |l|) |l|))))))
(DEFUN |insertAlist,fn| (|a| |b| |l|)
  (PROG ()
    (RETURN
     (COND ((NULL (CDR |l|)) (|rplac| (CDR |l|) (LIST (CONS |a| |b|))))
           ((EQUAL |a| (ELT (ELT |l| 1) 0)) (|rplac| (CDR (ELT |l| 1)) |b|))
           ((?ORDER (ELT (ELT |l| 1) 0) |a|)
            (|rplac| (CDR |l|) (CONS (CONS |a| |b|) (CDR |l|))))
           ('T (|insertAlist,fn| |a| |b| (CDR |l|)))))))

; Un2E(x,source,target) ==
;   ['Union,:branches] := source
;   x = '_$fromCoerceable_$ =>
;     and/[canCoerce(t, target) for t in branches | not STRINGP t]
;   coerceUn2E(x,source)

(DEFUN |Un2E| (|x| |source| |target|)
  (PROG (|branches|)
    (RETURN
     (PROGN
      (SETQ |branches| (CDR |source|))
      (COND
       ((EQ |x| '|$fromCoerceable$|)
        ((LAMBDA (|bfVar#167| |bfVar#166| |t|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#166|) (PROGN (SETQ |t| (CAR |bfVar#166|)) NIL))
              (RETURN |bfVar#167|))
             (#1='T
              (AND (NULL (STRINGP |t|))
                   (PROGN
                    (SETQ |bfVar#167| (|canCoerce| |t| |target|))
                    (COND ((NOT |bfVar#167|) (RETURN NIL)))))))
            (SETQ |bfVar#166| (CDR |bfVar#166|))))
         T |branches| NIL))
       (#1# (|coerceUn2E| |x| |source|)))))))

; Var2OV(u,source,target is [.,vl]) ==
;   sym := CADR source
;   u = '_$fromCoerceable_$ => member(sym,vl)
;   member(sym,vl) => position1(sym,vl)
;   coercionFailure()

(DEFUN |Var2OV| (|u| |source| |target|)
  (PROG (|vl| |sym|)
    (RETURN
     (PROGN
      (SETQ |vl| (CADR |target|))
      (SETQ |sym| (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|member| |sym| |vl|))
            ((|member| |sym| |vl|) (|position1| |sym| |vl|))
            ('T (|coercionFailure|)))))))

; Var2Dmp(u,source,target is [dmp,vl,S]) ==
;   sym := CADR source
;   u = '_$fromCoerceable_$ => member(sym,vl) or canCoerce(source,S)
;
;   len := #vl
;   -1 ~= (n:= position(sym,vl)) =>
;     LIST [LIST2VEC [(n=i => 1; 0) for i in 0..len-1],
;       :getConstantFromDomain('(One),S)]
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [[Zeros len,:objValUnwrap u]]

(DEFUN |Var2Dmp| (|u| |source| |target|)
  (PROG (|dmp| |vl| S |sym| |len| |n|)
    (RETURN
     (PROGN
      (SETQ |dmp| (CAR |target|))
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (SETQ |sym| (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (|member| |sym| |vl|) (|canCoerce| |source| S)))
       (#2='T
        (PROGN
         (SETQ |len| (LENGTH |vl|))
         (COND
          ((NOT (EQUAL (- 1) (SETQ |n| (|position| |sym| |vl|))))
           (LIST
            (CONS
             (LIST2VEC
              ((LAMBDA (|bfVar#169| |bfVar#168| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#168|) (RETURN (NREVERSE |bfVar#169|)))
                        (#2#
                         (SETQ |bfVar#169|
                                 (CONS (COND ((EQUAL |n| |i|) 1) (#2# 0))
                                       |bfVar#169|))))
                  (SETQ |i| (+ |i| 1))))
               NIL (- |len| 1) 0))
             (|getConstantFromDomain| '(|One|) S))))
          (#2#
           (PROGN
            (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
                (|coercionFailure|))
            (LIST (CONS (|Zeros| |len|) (|objValUnwrap| |u|)))))))))))))

; Var2Gdmp(u,source,target is [dmp,vl,S]) ==
;   sym := CADR source
;   u = '_$fromCoerceable_$ => member(sym,vl) or canCoerce(source,S)
;
;   len := #vl
;   -1 ~= (n:= position(sym,vl)) =>
;     LIST [LIST2VEC [(n=i => 1; 0) for i in 0..len-1],
;       :getConstantFromDomain('(One),S)]
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [[Zeros len,:objValUnwrap u]]

(DEFUN |Var2Gdmp| (|u| |source| |target|)
  (PROG (|dmp| |vl| S |sym| |len| |n|)
    (RETURN
     (PROGN
      (SETQ |dmp| (CAR |target|))
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (SETQ |sym| (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (|member| |sym| |vl|) (|canCoerce| |source| S)))
       (#2='T
        (PROGN
         (SETQ |len| (LENGTH |vl|))
         (COND
          ((NOT (EQUAL (- 1) (SETQ |n| (|position| |sym| |vl|))))
           (LIST
            (CONS
             (LIST2VEC
              ((LAMBDA (|bfVar#171| |bfVar#170| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#170|) (RETURN (NREVERSE |bfVar#171|)))
                        (#2#
                         (SETQ |bfVar#171|
                                 (CONS (COND ((EQUAL |n| |i|) 1) (#2# 0))
                                       |bfVar#171|))))
                  (SETQ |i| (+ |i| 1))))
               NIL (- |len| 1) 0))
             (|getConstantFromDomain| '(|One|) S))))
          (#2#
           (PROGN
            (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
                (|coercionFailure|))
            (LIST (CONS (|Zeros| |len|) (|objValUnwrap| |u|)))))))))))))

; Var2Mp(u,source,target is [mp,vl,S]) ==
;   sym := CADR source
;   u = '_$fromCoerceable_$ => member(sym,vl) or canCoerce(source,S)
;   (n:= position1(u,vl)) ~= 0 =>
;     [1,n,[1,0,:getConstantFromDomain('(One),S)]]
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [0,:objValUnwrap u]

(DEFUN |Var2Mp| (|u| |source| |target|)
  (PROG (|mp| |vl| S |sym| |n|)
    (RETURN
     (PROGN
      (SETQ |mp| (CAR |target|))
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (SETQ |sym| (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (|member| |sym| |vl|) (|canCoerce| |source| S)))
       ((NOT (EQL (SETQ |n| (|position1| |u| |vl|)) 0))
        (LIST 1 |n| (CONS 1 (CONS 0 (|getConstantFromDomain| '(|One|) S)))))
       ('T
        (PROGN
         (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
             (|coercionFailure|))
         (CONS 0 (|objValUnwrap| |u|)))))))))

; Var2NDmp(u,source,target is [ndmp,vl,S]) ==
;   sym := CADR source
;   u = '_$fromCoerceable_$ => member(sym,vl) or canCoerce(source,S)
;
;   len:= #vl
;   -1~=(n:= position(u,vl)) =>
;     LIST [LIST2VEC [(n=i => 1; 0) for i in 0..len-1],
;       :getConstantFromDomain('(One),S)]
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [[Zeros len,:objValUnwrap(u)]]

(DEFUN |Var2NDmp| (|u| |source| |target|)
  (PROG (|ndmp| |vl| S |sym| |len| |n|)
    (RETURN
     (PROGN
      (SETQ |ndmp| (CAR |target|))
      (SETQ |vl| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (SETQ |sym| (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (|member| |sym| |vl|) (|canCoerce| |source| S)))
       (#2='T
        (PROGN
         (SETQ |len| (LENGTH |vl|))
         (COND
          ((NOT (EQUAL (- 1) (SETQ |n| (|position| |u| |vl|))))
           (LIST
            (CONS
             (LIST2VEC
              ((LAMBDA (|bfVar#173| |bfVar#172| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#172|) (RETURN (NREVERSE |bfVar#173|)))
                        (#2#
                         (SETQ |bfVar#173|
                                 (CONS (COND ((EQUAL |n| |i|) 1) (#2# 0))
                                       |bfVar#173|))))
                  (SETQ |i| (+ |i| 1))))
               NIL (- |len| 1) 0))
             (|getConstantFromDomain| '(|One|) S))))
          (#2#
           (PROGN
            (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
                (|coercionFailure|))
            (LIST (CONS (|Zeros| |len|) (|objValUnwrap| |u|)))))))))))))

; Var2P(u,source,target is [poly,S]) ==
;   sym := CADR source
;   u = '_$fromCoerceable_$ => true
;
;   -- first try to get it into an underdomain
;   if (S ~= $Integer) then
;     u' := coerceInt(objNewWrap(u,source),S)
;     if u' then return [0,:objValUnwrap(u')]
;   -- if that failed, return it as a polynomial variable
;   [1,sym,[1,0,:getConstantFromDomain('(One),S)]]

(DEFUN |Var2P| (|u| |source| |target|)
  (PROG (|poly| S |sym| |u'|)
    (RETURN
     (PROGN
      (SETQ |poly| (CAR |target|))
      (SETQ S (CADR |target|))
      (SETQ |sym| (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) T)
            ('T
             (PROGN
              (COND
               ((NOT (EQUAL S |$Integer|))
                (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) S))
                (COND (|u'| (RETURN (CONS 0 (|objValUnwrap| |u'|)))))))
              (LIST 1 |sym|
                    (CONS 1
                          (CONS 0 (|getConstantFromDomain| '(|One|) S)))))))))))

; Var2QF(u,source,target is [qf,S]) ==
;   u = '_$fromCoerceable_$ => canCoerce(source,S)
;
;   S = $Integer => coercionFailure()
;   sym := CADR source
;   (u' := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [objValUnwrap u',:getConstantFromDomain('(One),S)]

(DEFUN |Var2QF| (|u| |source| |target|)
  (PROG (|qf| S |sym| |u'|)
    (RETURN
     (PROGN
      (SETQ |qf| (CAR |target|))
      (SETQ S (CADR |target|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| |source| S))
            ((EQUAL S |$Integer|) (|coercionFailure|))
            ('T
             (PROGN
              (SETQ |sym| (CADR |source|))
              (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |u| |source|) S))
                  (|coercionFailure|))
              (CONS (|objValUnwrap| |u'|)
                    (|getConstantFromDomain| '(|One|) S)))))))))

; Var2Up(u,source,target is [up,x,S]) ==
;   sym := CADR source
;   u = '_$fromCoerceable_$ => (sym = x) or canCoerce(source,S)
;
;   x=sym => [[1,:getConstantFromDomain('(One),S)]]
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [[0,:objValUnwrap u]]

(DEFUN |Var2Up| (|u| |source| |target|)
  (PROG (|up| |x| S |sym|)
    (RETURN
     (PROGN
      (SETQ |up| (CAR |target|))
      (SETQ |x| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (SETQ |sym| (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (EQUAL |sym| |x|) (|canCoerce| |source| S)))
       ((EQUAL |x| |sym|) (LIST (CONS 1 (|getConstantFromDomain| '(|One|) S))))
       ('T
        (PROGN
         (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
             (|coercionFailure|))
         (LIST (CONS 0 (|objValUnwrap| |u|))))))))))

; Var2SUP(u,source,target is [sup,S]) ==
;   sym := CADR source
;   u = '_$fromCoerceable_$ => (sym = "?") or canCoerce(source,S)
;
;   sym = "?" => [[1,:getConstantFromDomain('(One),S)]]
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   [[0,:objValUnwrap u]]

(DEFUN |Var2SUP| (|u| |source| |target|)
  (PROG (|sup| S |sym|)
    (RETURN
     (PROGN
      (SETQ |sup| (CAR |target|))
      (SETQ S (CADR |target|))
      (SETQ |sym| (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (EQ |sym| '?) (|canCoerce| |source| S)))
       ((EQ |sym| '?) (LIST (CONS 1 (|getConstantFromDomain| '(|One|) S))))
       ('T
        (PROGN
         (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
             (|coercionFailure|))
         (LIST (CONS 0 (|objValUnwrap| |u|))))))))))

; Var2UpS(u,source,target is [ups,x,S]) ==
;   sym := CADR source
;   u = '_$fromCoerceable_$ => (sym = x) or canCoerce(source,S)
;
;   mid := ['UnivariatePolynomial,x,S]
;   x = sym =>
;     u := Var2Up(u,source,mid)
;     (u := coerceInt(objNewWrap(u,mid),target)) or coercionFailure()
;     objValUnwrap u
;   (u := coerceInt(objNewWrap(u,source),S)) or coercionFailure()
;   (u := coerceInt(u,target)) or coercionFailure()
;   objValUnwrap u

(DEFUN |Var2UpS| (|u| |source| |target|)
  (PROG (|ups| |x| S |sym| |mid|)
    (RETURN
     (PROGN
      (SETQ |ups| (CAR |target|))
      (SETQ |x| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (SETQ |sym| (CADR |source|))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (EQUAL |sym| |x|) (|canCoerce| |source| S)))
       (#2='T
        (PROGN
         (SETQ |mid| (LIST '|UnivariatePolynomial| |x| S))
         (COND
          ((EQUAL |x| |sym|)
           (PROGN
            (SETQ |u| (|Var2Up| |u| |source| |mid|))
            (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |mid|) |target|))
                (|coercionFailure|))
            (|objValUnwrap| |u|)))
          (#2#
           (PROGN
            (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |source|) S))
                (|coercionFailure|))
            (OR (SETQ |u| (|coerceInt| |u| |target|)) (|coercionFailure|))
            (|objValUnwrap| |u|)))))))))))

; Var2OtherPS(u,source,target is [.,x,S]) ==
;   sym := CADR source
;   mid := ['UnivariatePowerSeries,x,S]
;   u = '_$fromCoerceable_$ =>
;     (sym = x) or (canCoerce(source,mid) and canCoerce(mid,target))
;   u := Var2UpS(u,source,mid)
;   (u := coerceInt(objNewWrap(u,mid),target)) or coercionFailure()
;   objValUnwrap u

(DEFUN |Var2OtherPS| (|u| |source| |target|)
  (PROG (|x| S |sym| |mid|)
    (RETURN
     (PROGN
      (SETQ |x| (CADR . #1=(|target|)))
      (SETQ S (CADDR . #1#))
      (SETQ |sym| (CADR |source|))
      (SETQ |mid| (LIST '|UnivariatePowerSeries| |x| S))
      (COND
       ((EQ |u| '|$fromCoerceable$|)
        (OR (EQUAL |sym| |x|)
            (AND (|canCoerce| |source| |mid|) (|canCoerce| |mid| |target|))))
       ('T
        (PROGN
         (SETQ |u| (|Var2UpS| |u| |source| |mid|))
         (OR (SETQ |u| (|coerceInt| (|objNewWrap| |u| |mid|) |target|))
             (|coercionFailure|))
         (|objValUnwrap| |u|))))))))

; V2M(u,[.,D],[.,R]) ==
;   u = '_$fromCoerceable_$ => nil
;   -- first see if we are coercing a vector of vectors
;   D is ['Vector,E] and
;     isRectangularVector(u, n := MAXINDEX u, m := MAXINDEX u.0) =>
;       res := MAKE_MATRIX(n + 1, m + 1)
;       for i in 0..n repeat
;           x := u.i
;           for j in 0..m repeat
;               y' := objValUnwrap(coerceInt(objNewWrap(x.j, E), R))
;               QSETAREF2O(res, i, j, y', 0, 0)
;       res
;   -- if not, try making it into a 1 by n matrix
;   coercionFailure()

(DEFUN V2M (|u| |bfVar#174| |bfVar#175|)
  (PROG (R D |ISTMP#1| E |n| |m| |res| |x| |y'|)
    (RETURN
     (PROGN
      (SETQ R (CADR |bfVar#175|))
      (SETQ D (CADR |bfVar#174|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL)
            ((AND (CONSP D) (EQ (CAR D) '|Vector|)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR D))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ E (CAR |ISTMP#1|)) #1='T)))
                  (|isRectangularVector| |u| (SETQ |n| (MAXINDEX |u|))
                   (SETQ |m| (MAXINDEX (ELT |u| 0)))))
             (PROGN
              (SETQ |res| (MAKE_MATRIX (+ |n| 1) (+ |m| 1)))
              ((LAMBDA (|i|)
                 (LOOP
                  (COND ((> |i| |n|) (RETURN NIL))
                        (#1#
                         (PROGN
                          (SETQ |x| (ELT |u| |i|))
                          ((LAMBDA (|j|)
                             (LOOP
                              (COND ((> |j| |m|) (RETURN NIL))
                                    (#1#
                                     (PROGN
                                      (SETQ |y'|
                                              (|objValUnwrap|
                                               (|coerceInt|
                                                (|objNewWrap| (ELT |x| |j|) E)
                                                R)))
                                      (QSETAREF2O |res| |i| |j| |y'| 0 0))))
                              (SETQ |j| (+ |j| 1))))
                           0))))
                  (SETQ |i| (+ |i| 1))))
               0)
              |res|))
            (#1# (|coercionFailure|)))))))

; V2Rm(u, source is [., D], [., n, m, R]) ==
;   u = '_$fromCoerceable_$ => nil
;   D is [.,E,:.] and isRectangularVector(u,n-1,m-1) =>
;       V2M(u, source, ["Matrix", R])
;   coercionFailure()

(DEFUN |V2Rm| (|u| |source| |bfVar#176|)
  (PROG (|n| |m| R D |ISTMP#1| E)
    (RETURN
     (PROGN
      (SETQ |n| (CADR . #1=(|bfVar#176|)))
      (SETQ |m| (CADDR . #1#))
      (SETQ R (CADDDR . #1#))
      (SETQ D (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL)
            ((AND (CONSP D)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR D))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN (SETQ E (CAR |ISTMP#1|)) #2='T)))
                  (|isRectangularVector| |u| (- |n| 1) (- |m| 1)))
             (V2M |u| |source| (LIST '|Matrix| R)))
            (#2# (|coercionFailure|)))))))

; V2Sm(u, source is [., D], [., n, R]) ==
;   u = '_$fromCoerceable_$ => nil
;   D is [.,E,:.] and isRectangularVector(u,n-1,n-1) =>
;       V2M(u, source, ["Matrix", R])
;   coercionFailure()

(DEFUN |V2Sm| (|u| |source| |bfVar#177|)
  (PROG (|n| R D |ISTMP#1| E)
    (RETURN
     (PROGN
      (SETQ |n| (CADR . #1=(|bfVar#177|)))
      (SETQ R (CADDR . #1#))
      (SETQ D (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) NIL)
            ((AND (CONSP D)
                  (PROGN
                   (SETQ |ISTMP#1| (CDR D))
                   (AND (CONSP |ISTMP#1|)
                        (PROGN (SETQ E (CAR |ISTMP#1|)) #2='T)))
                  (|isRectangularVector| |u| (- |n| 1) (- |n| 1)))
             (V2M |u| |source| (LIST '|Matrix| R)))
            (#2# (|coercionFailure|)))))))

; isRectangularVector(x,p,q) ==
;   MAXINDEX x = p =>
;     and/[q=MAXINDEX x.i for i in 0..p]

(DEFUN |isRectangularVector| (|x| |p| |q|)
  (PROG ()
    (RETURN
     (COND
      ((EQUAL (MAXINDEX |x|) |p|)
       (IDENTITY
        ((LAMBDA (|bfVar#178| |i|)
           (LOOP
            (COND ((> |i| |p|) (RETURN |bfVar#178|))
                  ('T
                   (PROGN
                    (SETQ |bfVar#178| (EQUAL |q| (MAXINDEX (ELT |x| |i|))))
                    (COND ((NOT |bfVar#178|) (RETURN NIL))))))
            (SETQ |i| (+ |i| 1))))
         T 0)))))))

; P2Uts(u, source, target) ==
;   P2Us(u,source, target, 'taylor)

(DEFUN |P2Uts| (|u| |source| |target|)
  (PROG () (RETURN (|P2Us| |u| |source| |target| '|taylor|))))

; P2Uls(u, source, target) ==
;   P2Us(u,source, target, 'laurent)

(DEFUN |P2Uls| (|u| |source| |target|)
  (PROG () (RETURN (|P2Us| |u| |source| |target| '|laurent|))))

; P2Upxs(u, source, target) ==
;   P2Us(u,source, target, 'puiseux)

(DEFUN |P2Upxs| (|u| |source| |target|)
  (PROG () (RETURN (|P2Us| |u| |source| |target| '|puiseux|))))

; P2Us(u, source is [.,S], target is [.,T,var,cen], type) ==
;   u = '_$fromCoerceable_$ =>
;     -- might be able to say yes
;     canCoerce(S,T)
;   T isnt ['Expression, :.] => coercionFailure()
;   if S ~= '(Float) then S := $Integer
;   obj := objNewWrap(u, source)
;   E := ['Expression, S]
;   newU := coerceInt(obj, E)
;   null newU => coercionFailure()
;   EQtype := ['Equation, E]
;   eqfun := getFunctionFromDomain('_=, EQtype, [E,E])
;   varE := coerceInt(objNewWrap(var, '(Symbol)), E)
;   null varE => coercionFailure()
;   cenE := coerceInt(objNewWrap(cen, T), E)
;   null cenE => coercionFailure()
;   eq := SPADCALL(objValUnwrap(varE), objValUnwrap(cenE), eqfun)
;   package := ['ExpressionToUnivariatePowerSeries, S, E]
;   func := getFunctionFromDomain(type, package, [E, EQtype])
;   newObj := SPADCALL(objValUnwrap(newU), eq, func)
;   newType := first newObj
;   newVal  := rest newObj
;   newType = target => newVal
;   finalObj := coerceInt(objNewWrap(newVal, newType), target)
;   null finalObj => coercionFailure()
;   objValUnwrap finalObj

(DEFUN |P2Us| (|u| |source| |target| |type|)
  (PROG (T$ |var| |cen| S |obj| E |newU| |EQtype| |eqfun| |varE| |cenE| |eq|
         |package| |func| |newObj| |newType| |newVal| |finalObj|)
    (RETURN
     (PROGN
      (SETQ T$ (CADR . #1=(|target|)))
      (SETQ |var| (CADDR . #1#))
      (SETQ |cen| (CADDDR . #1#))
      (SETQ S (CADR |source|))
      (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S T$))
            ((NOT (AND (CONSP T$) (EQ (CAR T$) '|Expression|)))
             (|coercionFailure|))
            (#2='T
             (PROGN
              (COND ((NOT (EQUAL S '(|Float|))) (SETQ S |$Integer|)))
              (SETQ |obj| (|objNewWrap| |u| |source|))
              (SETQ E (LIST '|Expression| S))
              (SETQ |newU| (|coerceInt| |obj| E))
              (COND ((NULL |newU|) (|coercionFailure|))
                    (#2#
                     (PROGN
                      (SETQ |EQtype| (LIST '|Equation| E))
                      (SETQ |eqfun|
                              (|getFunctionFromDomain| '= |EQtype| (LIST E E)))
                      (SETQ |varE|
                              (|coerceInt| (|objNewWrap| |var| '(|Symbol|)) E))
                      (COND ((NULL |varE|) (|coercionFailure|))
                            (#2#
                             (PROGN
                              (SETQ |cenE|
                                      (|coerceInt| (|objNewWrap| |cen| T$) E))
                              (COND ((NULL |cenE|) (|coercionFailure|))
                                    (#2#
                                     (PROGN
                                      (SETQ |eq|
                                              (SPADCALL (|objValUnwrap| |varE|)
                                               (|objValUnwrap| |cenE|)
                                               |eqfun|))
                                      (SETQ |package|
                                              (LIST
                                               '|ExpressionToUnivariatePowerSeries|
                                               S E))
                                      (SETQ |func|
                                              (|getFunctionFromDomain| |type|
                                               |package| (LIST E |EQtype|)))
                                      (SETQ |newObj|
                                              (SPADCALL (|objValUnwrap| |newU|)
                                               |eq| |func|))
                                      (SETQ |newType| (CAR |newObj|))
                                      (SETQ |newVal| (CDR |newObj|))
                                      (COND
                                       ((EQUAL |newType| |target|) |newVal|)
                                       (#2#
                                        (PROGN
                                         (SETQ |finalObj|
                                                 (|coerceInt|
                                                  (|objNewWrap| |newVal|
                                                   |newType|)
                                                  |target|))
                                         (COND
                                          ((NULL |finalObj|)
                                           (|coercionFailure|))
                                          (#2#
                                           (|objValUnwrap|
                                            |finalObj|))))))))))))))))))))))

; commuteComplex(u,source,S,target,T) ==
;   u = '_$fromCoerceable_$ =>
;     canCoerce(S,target) and canCoerce(T,target)
;   [real,:imag] := u
;   (real := coerceInt(objNewWrap(real,S),target)) or coercionFailure()
;   (imag := coerceInt(objNewWrap(imag,S),target)) or coercionFailure()
;   T' := underDomainOf T
;   i := [domainZero(T'),
;        :domainOne(T')]
;   (i := coerceInt(objNewWrap(i,T),target)) or coercionFailure()
;   f := getFunctionFromDomain("*",target,[target,target])
;   i := SPADCALL(objValUnwrap i, objValUnwrap imag, f)
;   f := getFunctionFromDomain("+",target,[target,target])
;   SPADCALL(objValUnwrap real,i,f)

(DEFUN |commuteComplex| (|u| |source| S |target| T$)
  (PROG (|real| |imag| |T'| |i| |f|)
    (RETURN
     (COND
      ((EQ |u| '|$fromCoerceable$|)
       (AND (|canCoerce| S |target|) (|canCoerce| T$ |target|)))
      ('T
       (PROGN
        (SETQ |real| (CAR |u|))
        (SETQ |imag| (CDR |u|))
        (OR (SETQ |real| (|coerceInt| (|objNewWrap| |real| S) |target|))
            (|coercionFailure|))
        (OR (SETQ |imag| (|coerceInt| (|objNewWrap| |imag| S) |target|))
            (|coercionFailure|))
        (SETQ |T'| (|underDomainOf| T$))
        (SETQ |i| (CONS (|domainZero| |T'|) (|domainOne| |T'|)))
        (OR (SETQ |i| (|coerceInt| (|objNewWrap| |i| T$) |target|))
            (|coercionFailure|))
        (SETQ |f|
                (|getFunctionFromDomain| '* |target| (LIST |target| |target|)))
        (SETQ |i| (SPADCALL (|objValUnwrap| |i|) (|objValUnwrap| |imag|) |f|))
        (SETQ |f|
                (|getFunctionFromDomain| '+ |target| (LIST |target| |target|)))
        (SPADCALL (|objValUnwrap| |real|) |i| |f|)))))))

; commuteQuaternion(u,source,S,target,T) ==
;   u = '_$fromCoerceable_$ =>
;     canCoerce(S,target) and canCoerce(T,target)
;   c := [objValUnwrap(coerceInt(objNewWrap(x,S),target)
;     or coercionFailure()) for x in VEC2LIST u]
;   q := '(Quaternion (Integer))
;   e := [[1,0,0,0],[0,1,0,0],[0,0,1,0],[0,0,0,1]]
;   e := [(coerceInt(objNewWrap(LIST2VEC x,q),T)
;     or coercionFailure()) for x in e]
;   e :=[objValUnwrap(coerceInt(x,target) or coercionFailure()) for x in e]
;   u' := domainZero(target)
;   mult := getFunctionFromDomain("*",target,[target,target])
;   plus := getFunctionFromDomain("+",target,[target,target])
;   for x in c for y in e repeat
;     u' := SPADCALL(u',SPADCALL(x,y,mult),plus)
;   u'

(DEFUN |commuteQuaternion| (|u| |source| S |target| T$)
  (PROG (|c| |q| |e| |u'| |mult| |plus|)
    (RETURN
     (COND
      ((EQ |u| '|$fromCoerceable$|)
       (AND (|canCoerce| S |target|) (|canCoerce| T$ |target|)))
      (#1='T
       (PROGN
        (SETQ |c|
                ((LAMBDA (|bfVar#180| |bfVar#179| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#179|)
                          (PROGN (SETQ |x| (CAR |bfVar#179|)) NIL))
                      (RETURN (NREVERSE |bfVar#180|)))
                     (#1#
                      (SETQ |bfVar#180|
                              (CONS
                               (|objValUnwrap|
                                (OR (|coerceInt| (|objNewWrap| |x| S) |target|)
                                    (|coercionFailure|)))
                               |bfVar#180|))))
                    (SETQ |bfVar#179| (CDR |bfVar#179|))))
                 NIL (VEC2LIST |u|) NIL))
        (SETQ |q| '(|Quaternion| (|Integer|)))
        (SETQ |e|
                (LIST (LIST 1 0 0 0) (LIST 0 1 0 0) (LIST 0 0 1 0)
                      (LIST 0 0 0 1)))
        (SETQ |e|
                ((LAMBDA (|bfVar#182| |bfVar#181| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#181|)
                          (PROGN (SETQ |x| (CAR |bfVar#181|)) NIL))
                      (RETURN (NREVERSE |bfVar#182|)))
                     (#1#
                      (SETQ |bfVar#182|
                              (CONS
                               (OR
                                (|coerceInt| (|objNewWrap| (LIST2VEC |x|) |q|)
                                 T$)
                                (|coercionFailure|))
                               |bfVar#182|))))
                    (SETQ |bfVar#181| (CDR |bfVar#181|))))
                 NIL |e| NIL))
        (SETQ |e|
                ((LAMBDA (|bfVar#184| |bfVar#183| |x|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#183|)
                          (PROGN (SETQ |x| (CAR |bfVar#183|)) NIL))
                      (RETURN (NREVERSE |bfVar#184|)))
                     (#1#
                      (SETQ |bfVar#184|
                              (CONS
                               (|objValUnwrap|
                                (OR (|coerceInt| |x| |target|)
                                    (|coercionFailure|)))
                               |bfVar#184|))))
                    (SETQ |bfVar#183| (CDR |bfVar#183|))))
                 NIL |e| NIL))
        (SETQ |u'| (|domainZero| |target|))
        (SETQ |mult|
                (|getFunctionFromDomain| '* |target| (LIST |target| |target|)))
        (SETQ |plus|
                (|getFunctionFromDomain| '+ |target| (LIST |target| |target|)))
        ((LAMBDA (|bfVar#185| |x| |bfVar#186| |y|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#185|) (PROGN (SETQ |x| (CAR |bfVar#185|)) NIL)
                  (ATOM |bfVar#186|) (PROGN (SETQ |y| (CAR |bfVar#186|)) NIL))
              (RETURN NIL))
             (#1#
              (SETQ |u'| (SPADCALL |u'| (SPADCALL |x| |y| |mult|) |plus|))))
            (SETQ |bfVar#185| (CDR |bfVar#185|))
            (SETQ |bfVar#186| (CDR |bfVar#186|))))
         |c| NIL |e| NIL)
        |u'|))))))

; commuteFraction(u,source,S,target,T) ==
;   u = '_$fromCoerceable_$ =>
;     ofCategory(target,'(Field)) => canCoerce(S,target)
;     canCoerce(S,T) and canCoerce(T,target)
;   [n,:d] := u
;   ofCategory(target,'(Field)) =>
;     -- see if denominator can go over to target
;     (d' := coerceInt(objNewWrap(d,S),target)) or coercionFailure()
;     -- if so, try to invert it
;     inv := getFunctionFromDomain('inv,target,[target])
;     d' := SPADCALL(objValUnwrap d',inv)
;     -- now coerce to target
;     (n' := coerceInt(objNewWrap(n,S),target)) or coercionFailure()
;     multfunc := getFunctionFromDomain("*",target,[target,target])
;     SPADCALL(d',objValUnwrap n',multfunc)
;   -- see if denominator can go over to QF part of target
;   (d' := coerceInt(objNewWrap(d,S),T)) or coercionFailure()
;   -- if so, try to invert it
;   inv := getFunctionFromDomain('inv,T,[T])
;   d' := SPADCALL(objValUnwrap d',inv)
;   -- now coerce to target
;   (d' := coerceInt(objNewWrap(d',T),target)) or coercionFailure()
;   (n' := coerceInt(objNewWrap(n,S),target)) or coercionFailure()
;   multfunc := getFunctionFromDomain("*",target,[target,target])
;   SPADCALL(objValUnwrap d',objValUnwrap n',multfunc)

(DEFUN |commuteFraction| (|u| |source| S |target| T$)
  (PROG (|n| |d| |d'| |inv| |n'| |multfunc|)
    (RETURN
     (COND
      ((EQ |u| '|$fromCoerceable$|)
       (COND ((|ofCategory| |target| '(|Field|)) (|canCoerce| S |target|))
             (#1='T (AND (|canCoerce| S T$) (|canCoerce| T$ |target|)))))
      (#1#
       (PROGN
        (SETQ |n| (CAR |u|))
        (SETQ |d| (CDR |u|))
        (COND
         ((|ofCategory| |target| '(|Field|))
          (PROGN
           (OR (SETQ |d'| (|coerceInt| (|objNewWrap| |d| S) |target|))
               (|coercionFailure|))
           (SETQ |inv|
                   (|getFunctionFromDomain| '|inv| |target| (LIST |target|)))
           (SETQ |d'| (SPADCALL (|objValUnwrap| |d'|) |inv|))
           (OR (SETQ |n'| (|coerceInt| (|objNewWrap| |n| S) |target|))
               (|coercionFailure|))
           (SETQ |multfunc|
                   (|getFunctionFromDomain| '* |target|
                    (LIST |target| |target|)))
           (SPADCALL |d'| (|objValUnwrap| |n'|) |multfunc|)))
         (#1#
          (PROGN
           (OR (SETQ |d'| (|coerceInt| (|objNewWrap| |d| S) T$))
               (|coercionFailure|))
           (SETQ |inv| (|getFunctionFromDomain| '|inv| T$ (LIST T$)))
           (SETQ |d'| (SPADCALL (|objValUnwrap| |d'|) |inv|))
           (OR (SETQ |d'| (|coerceInt| (|objNewWrap| |d'| T$) |target|))
               (|coercionFailure|))
           (OR (SETQ |n'| (|coerceInt| (|objNewWrap| |n| S) |target|))
               (|coercionFailure|))
           (SETQ |multfunc|
                   (|getFunctionFromDomain| '* |target|
                    (LIST |target| |target|)))
           (SPADCALL (|objValUnwrap| |d'|) (|objValUnwrap| |n'|)
            |multfunc|))))))))))

; commuteSquareMatrix(u,source,S,target,T) ==
;   u = '_$fromCoerceable_$ =>
;     canCoerce(S,target) and canCoerce(T,target)
;   -- commuting matrices of matrices should be a no-op
;   S is ['SquareMatrix,:.] =>
;      source=target => u
;      coercionFailure()
;   u' := domainZero(target)
;   plusfunc := getFunctionFromDomain("+",target,[target,target])
;   multfunc := getFunctionFromDomain("*",target,[target,target])
;   zero := domainZero(S)
;   [sm,n,:.] := source
;   S' := [sm,n,$Integer]
;   for i in 0..(n-1) repeat
;     for j in 0..(n-1) repeat
;       (e := QAREF2O(u, i, j, 0, 0)) = zero => 'iterate
;       (e' := coerceInt(objNewWrap(e,S),target)) or coercionFailure()
;       (Eij := coerceInt(objNewWrap(makeEijSquareMatrix(i,j,n),S'),T)) or
;         coercionFailure()
;       (Eij := coerceInt(Eij,target)) or coercionFailure()
;       e' := SPADCALL(objValUnwrap(e'),objValUnwrap(Eij),multfunc)
;       u' := SPADCALL(e',u',plusfunc)
;   u'

(DEFUN |commuteSquareMatrix| (|u| |source| S |target| T$)
  (PROG (|u'| |plusfunc| |multfunc| |zero| |sm| |n| |S'| |e| |e'| |Eij|)
    (RETURN
     (COND
      ((EQ |u| '|$fromCoerceable$|)
       (AND (|canCoerce| S |target|) (|canCoerce| T$ |target|)))
      ((AND (CONSP S) (EQ (CAR S) '|SquareMatrix|))
       (COND ((EQUAL |source| |target|) |u|) (#1='T (|coercionFailure|))))
      (#1#
       (PROGN
        (SETQ |u'| (|domainZero| |target|))
        (SETQ |plusfunc|
                (|getFunctionFromDomain| '+ |target| (LIST |target| |target|)))
        (SETQ |multfunc|
                (|getFunctionFromDomain| '* |target| (LIST |target| |target|)))
        (SETQ |zero| (|domainZero| S))
        (SETQ |sm| (CAR |source|))
        (SETQ |n| (CADR |source|))
        (SETQ |S'| (LIST |sm| |n| |$Integer|))
        ((LAMBDA (|bfVar#187| |i|)
           (LOOP
            (COND ((> |i| |bfVar#187|) (RETURN NIL))
                  (#1#
                   ((LAMBDA (|bfVar#188| |j|)
                      (LOOP
                       (COND ((> |j| |bfVar#188|) (RETURN NIL))
                             (#1#
                              (COND
                               ((EQUAL (SETQ |e| (QAREF2O |u| |i| |j| 0 0))
                                       |zero|)
                                '|iterate|)
                               (#1#
                                (PROGN
                                 (OR
                                  (SETQ |e'|
                                          (|coerceInt| (|objNewWrap| |e| S)
                                           |target|))
                                  (|coercionFailure|))
                                 (OR
                                  (SETQ |Eij|
                                          (|coerceInt|
                                           (|objNewWrap|
                                            (|makeEijSquareMatrix| |i| |j| |n|)
                                            |S'|)
                                           T$))
                                  (|coercionFailure|))
                                 (OR (SETQ |Eij| (|coerceInt| |Eij| |target|))
                                     (|coercionFailure|))
                                 (SETQ |e'|
                                         (SPADCALL (|objValUnwrap| |e'|)
                                          (|objValUnwrap| |Eij|) |multfunc|))
                                 (SETQ |u'|
                                         (SPADCALL |e'| |u'| |plusfunc|)))))))
                       (SETQ |j| (+ |j| 1))))
                    (- |n| 1) 0)))
            (SETQ |i| (+ |i| 1))))
         (- |n| 1) 0)
        |u'|))))))

; makeEijSquareMatrix(i, j, dim) ==
;     res := MAKE_MATRIX1(dim, dim, 0)
;     QSETAREF2O(res, i, j, 1, 0, 0)
;     res

(DEFUN |makeEijSquareMatrix| (|i| |j| |dim|)
  (PROG (|res|)
    (RETURN
     (PROGN
      (SETQ |res| (MAKE_MATRIX1 |dim| |dim| 0))
      (QSETAREF2O |res| |i| |j| 1 0 0)
      |res|))))

; commuteUnivariatePolynomial(u,source,S,target,T) ==
;   commuteSparseUnivariatePolynomial(u,source,S,target,T)

(DEFUN |commuteUnivariatePolynomial| (|u| |source| S |target| T$)
  (PROG ()
    (RETURN (|commuteSparseUnivariatePolynomial| |u| |source| S |target| T$))))

; commuteSparseUnivariatePolynomial(u,source,S,target,T) ==
;   u = '_$fromCoerceable_$ =>
;     canCoerce(S,target) and canCoerce(T,target)
;
;   u' := domainZero(target)
;   null u => u'
;
;   T'  := underDomainOf T
;   one := domainOne(T')
;   monom := getFunctionFromDomain('monomial,T,[T',$NonNegativeInteger])
;   plus  := getFunctionFromDomain("+",target,[target,target])
;   times := getFunctionFromDomain("*",target,[target,target])
;
;   for [e,:c] in u repeat
;     (c := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     m := SPADCALL(one,e,monom)
;     (m := coerceInt(objNewWrap(m,T),target)) or coercionFailure()
;     c := objValUnwrap c
;     m := objValUnwrap m
;     u' := SPADCALL(u',SPADCALL(c,m,times),plus)
;   u'

(DEFUN |commuteSparseUnivariatePolynomial| (|u| |source| S |target| T$)
  (PROG (|u'| |T'| |one| |monom| |plus| |times| |e| |c| |m|)
    (RETURN
     (COND
      ((EQ |u| '|$fromCoerceable$|)
       (AND (|canCoerce| S |target|) (|canCoerce| T$ |target|)))
      (#1='T
       (PROGN
        (SETQ |u'| (|domainZero| |target|))
        (COND ((NULL |u|) |u'|)
              (#1#
               (PROGN
                (SETQ |T'| (|underDomainOf| T$))
                (SETQ |one| (|domainOne| |T'|))
                (SETQ |monom|
                        (|getFunctionFromDomain| '|monomial| T$
                         (LIST |T'| |$NonNegativeInteger|)))
                (SETQ |plus|
                        (|getFunctionFromDomain| '+ |target|
                         (LIST |target| |target|)))
                (SETQ |times|
                        (|getFunctionFromDomain| '* |target|
                         (LIST |target| |target|)))
                ((LAMBDA (|bfVar#190| |bfVar#189|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#190|)
                          (PROGN (SETQ |bfVar#189| (CAR |bfVar#190|)) NIL))
                      (RETURN NIL))
                     (#1#
                      (AND (CONSP |bfVar#189|)
                           (PROGN
                            (SETQ |e| (CAR |bfVar#189|))
                            (SETQ |c| (CDR |bfVar#189|))
                            #1#)
                           (PROGN
                            (OR
                             (SETQ |c|
                                     (|coerceInt| (|objNewWrap| |c| S)
                                      |target|))
                             (|coercionFailure|))
                            (SETQ |m| (SPADCALL |one| |e| |monom|))
                            (OR
                             (SETQ |m|
                                     (|coerceInt| (|objNewWrap| |m| T$)
                                      |target|))
                             (|coercionFailure|))
                            (SETQ |c| (|objValUnwrap| |c|))
                            (SETQ |m| (|objValUnwrap| |m|))
                            (SETQ |u'|
                                    (SPADCALL |u'| (SPADCALL |c| |m| |times|)
                                     |plus|))))))
                    (SETQ |bfVar#190| (CDR |bfVar#190|))))
                 |u| NIL)
                |u'|)))))))))

; commutePolynomial(u,source,S,target,T) ==
;   commuteMPolyCat(u,source,S,target,T)

(DEFUN |commutePolynomial| (|u| |source| S |target| T$)
  (PROG () (RETURN (|commuteMPolyCat| |u| |source| S |target| T$))))

; commuteMultivariatePolynomial(u,source,S,target,T) ==
;   commuteMPolyCat(u,source,S,target,T)

(DEFUN |commuteMultivariatePolynomial| (|u| |source| S |target| T$)
  (PROG () (RETURN (|commuteMPolyCat| |u| |source| S |target| T$))))

; commuteDistributedMultivariatePolynomial(u,source,S,target,T) ==
;   commuteMPolyCat(u,source,S,target,T)

(DEFUN |commuteDistributedMultivariatePolynomial| (|u| |source| S |target| T$)
  (PROG () (RETURN (|commuteMPolyCat| |u| |source| S |target| T$))))

; commuteNewDistributedMultivariatePolynomial(u,source,S,target,T) ==
;   commuteMPolyCat(u,source,S,target,T)

(DEFUN |commuteNewDistributedMultivariatePolynomial|
       (|u| |source| S |target| T$)
  (PROG () (RETURN (|commuteMPolyCat| |u| |source| S |target| T$))))

; commuteMPolyCat(u,source,S,target,T) ==
;   u = '_$fromCoerceable_$ => canCoerce(S,target)
;   -- check constant case
;   isconstfun := getFunctionFromDomain("ground?",source,[source])
;   SPADCALL(u,isconstfun) =>
;     constfun := getFunctionFromDomain("ground",source,[source])
;     c := SPADCALL(u,constfun)
;     (u' := coerceInt(objNewWrap(c,S),target)) or coercionFailure()
;     objValUnwrap(u')
;
;   lmfun := getFunctionFromDomain('leadingMonomial,source,[source])
;   lm := SPADCALL(u,lmfun)    -- has type source, is leading monom
;
;   lcfun := getFunctionFromDomain('leadingCoefficient,source,[source])
;   lc := SPADCALL(lm,lcfun)    -- has type S, is leading coef
;   (lc' := coerceInt(objNewWrap(lc,S),target)) or coercionFailure()
;
;   pmfun := getFunctionFromDomain('primitiveMonomials,source,[source])
;   lm := first SPADCALL(lm,pmfun) -- now we have removed the leading coef
;   (lm' := coerceInt(objNewWrap(lm,source),T)) or coercionFailure()
;   (lm' := coerceInt(lm',target)) or coercionFailure()
;
;   rdfun := getFunctionFromDomain('reductum,source,[source])
;   rd := SPADCALL(u,rdfun)    -- has type source, is reductum
;   (rd' := coerceInt(objNewWrap(rd,source),target)) or coercionFailure()
;
;   lc' := objValUnwrap lc'
;   lm' := objValUnwrap lm'
;   rd' := objValUnwrap rd'
;
;   plusfun := getFunctionFromDomain("+",target,[target,target])
;   multfun := getFunctionFromDomain("*",target,[target,target])
;   SPADCALL(SPADCALL(lc',lm',multfun),rd',plusfun)

(DEFUN |commuteMPolyCat| (|u| |source| S |target| T$)
  (PROG (|isconstfun| |constfun| |c| |u'| |lmfun| |lm| |lcfun| |lc| |lc'|
         |pmfun| |lm'| |rdfun| |rd| |rd'| |plusfun| |multfun|)
    (RETURN
     (COND ((EQ |u| '|$fromCoerceable$|) (|canCoerce| S |target|))
           (#1='T
            (PROGN
             (SETQ |isconstfun|
                     (|getFunctionFromDomain| '|ground?| |source|
                      (LIST |source|)))
             (COND
              ((SPADCALL |u| |isconstfun|)
               (PROGN
                (SETQ |constfun|
                        (|getFunctionFromDomain| '|ground| |source|
                         (LIST |source|)))
                (SETQ |c| (SPADCALL |u| |constfun|))
                (OR (SETQ |u'| (|coerceInt| (|objNewWrap| |c| S) |target|))
                    (|coercionFailure|))
                (|objValUnwrap| |u'|)))
              (#1#
               (PROGN
                (SETQ |lmfun|
                        (|getFunctionFromDomain| '|leadingMonomial| |source|
                         (LIST |source|)))
                (SETQ |lm| (SPADCALL |u| |lmfun|))
                (SETQ |lcfun|
                        (|getFunctionFromDomain| '|leadingCoefficient| |source|
                         (LIST |source|)))
                (SETQ |lc| (SPADCALL |lm| |lcfun|))
                (OR (SETQ |lc'| (|coerceInt| (|objNewWrap| |lc| S) |target|))
                    (|coercionFailure|))
                (SETQ |pmfun|
                        (|getFunctionFromDomain| '|primitiveMonomials| |source|
                         (LIST |source|)))
                (SETQ |lm| (CAR (SPADCALL |lm| |pmfun|)))
                (OR (SETQ |lm'| (|coerceInt| (|objNewWrap| |lm| |source|) T$))
                    (|coercionFailure|))
                (OR (SETQ |lm'| (|coerceInt| |lm'| |target|))
                    (|coercionFailure|))
                (SETQ |rdfun|
                        (|getFunctionFromDomain| '|reductum| |source|
                         (LIST |source|)))
                (SETQ |rd| (SPADCALL |u| |rdfun|))
                (OR
                 (SETQ |rd'|
                         (|coerceInt| (|objNewWrap| |rd| |source|) |target|))
                 (|coercionFailure|))
                (SETQ |lc'| (|objValUnwrap| |lc'|))
                (SETQ |lm'| (|objValUnwrap| |lm'|))
                (SETQ |rd'| (|objValUnwrap| |rd'|))
                (SETQ |plusfun|
                        (|getFunctionFromDomain| '+ |target|
                         (LIST |target| |target|)))
                (SETQ |multfun|
                        (|getFunctionFromDomain| '* |target|
                         (LIST |target| |target|)))
                (SPADCALL (SPADCALL |lc'| |lm'| |multfun|) |rd'|
                 |plusfun|))))))))))

; DEFPARAMETER($CoerceTable, '(                                          _
;   (Complex . ( _
;     (Expression                       indeterm   Complex2Expr) _
;     (Factored                         indeterm   Complex2FR) _
;     (Integer                          partial    Complex2underDomain) _
;     (PrimeField                       partial    Complex2underDomain) _
;     ))_
;   (DirectProduct . (                                                  _
;     (DirectProduct                        partial    DP2DP)           _
;    ))                                                                 _
;   (DistributedMultivariatePolynomial . (                              _
;     (DistributedMultivariatePolynomial    indeterm   Dmp2Dmp) _
;     (Expression                           indeterm   Dmp2Expr) _
;     (Factored                             indeterm   Mp2FR) _
;     (HomogeneousDistributedMultivariatePolynomial indeterm   Dmp2NDmp) _
;     (MultivariatePolynomial               indeterm   Dmp2Mp) _
;     (Polynomial                           indeterm   Dmp2P) _
;     (UnivariatePolynomial                 indeterm   Dmp2Up) _
;     ))_
;   (Expression . (
;     (Complex                                         partial    Expr2Complex) _
;     (DistributedMultivariatePolynomial               indeterm   Expr2Dmp) _
;     (HomogeneousDistributedMultivariatePolynomial    indeterm   Expr2Dmp) _
;     (MultivariatePolynomial                          indeterm   Expr2Mp) _
;     (UnivariateLaurentSeries                         indeterm   P2Uls) _
;     (UnivariatePolynomial                            indeterm   Expr2Up) _
;     (UnivariatePuiseuxSeries                         indeterm   P2Upxs) _
;     (UnivariateTaylorSeries                          indeterm   P2Uts) _
;     )) _
;
;   (Kernel . ( _
;     (Kernel                                          indeterm   Ker2Ker) _
;     (Expression                                      indeterm   Ker2Expr) _
;      )) _
;
;   (Factored . ( _
;     (Factored                             indeterm   Factored2Factored) _
;     ))_
;   (Fraction . ( _
;     (DistributedMultivariatePolynomial    partial    Qf2domain) _
;     (Expression                           indeterm   Qf2EF) _
;     (Fraction                             indeterm   Qf2Qf) _
;     (HomogeneousDistributedMultivariatePolynomial partial    Qf2domain) _
;     (Integer                              partial    Qf2domain) _
;     (MultivariatePolynomial               partial    Qf2domain) _
;     (Polynomial                           partial    Qf2domain) _
;     (PrimeField                           indeterm   Qf2PF) _
;     (UnivariateLaurentSeries              indeterm   P2Uls) _
;     (UnivariatePolynomial                 partial    Qf2domain) _
;     (UnivariatePuiseuxSeries              indeterm   P2Upxs) _
;     (UnivariateTaylorSeries               indeterm   P2Uts) _
;     ))_
;   (Integer . ( _
;     (NonNegativeInteger                   partial    I2NNI) _
;     (PositiveInteger                      partial    I2PI) _
;     ))_
;   (List . ( _
;     (DirectProduct                        indeterm   L2DP) _
;     (Matrix                               partial    L2M) _
;     (Record                               partial    L2Record) _
;     (RectangularMatrix                    partial    L2Rm) _
;     (Set                                  indeterm   L2Set) _
;     (SquareMatrix                         partial    L2Sm) _
;     (Stream                               indeterm   Agg2Agg) _
;     (Tuple                                indeterm   L2Tuple) _
;     (Vector                               indeterm   L2V) _
;     ))_
;   (Matrix . ( _
;     (List                                 indeterm   M2L) _
;     (RectangularMatrix                    partial    M2Rm) _
;     (SquareMatrix                         partial    M2Sm) _
;     (Vector                               indeterm   M2L) _
;     ))_
;   (MultivariatePolynomial . ( _
;     (DistributedMultivariatePolynomial    indeterm   Mp2Dmp) _
;     (Expression                           indeterm   Mp2Expr) _
;     (Factored                             indeterm   Mp2FR) _
;     (HomogeneousDistributedMultivariatePolynomial indeterm   domain2NDmp) _
;     (MultivariatePolynomial               indeterm   Mp2Mp) _
;     (Polynomial                           indeterm   Mp2P) _
;     (UnivariatePolynomial                 indeterm   Mp2Up) _
;     ))_
;   (HomogeneousDirectProduct . ( _
;     (HomogeneousDirectProduct             indeterm   DP2DP) _
;    ))_
;   (HomogeneousDistributedMultivariatePolynomial . ( _
;     (Complex                              indeterm   NDmp2domain) _
;     (DistributedMultivariatePolynomial    indeterm   NDmp2domain) _
;     (Expression                           indeterm   Dmp2Expr) _
;     (Factored                             indeterm   Mp2FR) _
;     (Fraction                             indeterm   NDmp2domain) _
;     (HomogeneousDistributedMultivariatePolynomial indeterm   NDmp2NDmp) _
;     (MultivariatePolynomial               indeterm   NDmp2domain) _
;     (Polynomial                           indeterm   NDmp2domain) _
;     (Quaternion                           indeterm   NDmp2domain) _
;     (UnivariatePolynomial                 indeterm   NDmp2domain) _
;     ))_
;   (OrderedVariableList . ( _
;     (DistributedMultivariatePolynomial    indeterm   OV2poly) _
;     (HomogeneousDistributedMultivariatePolynomial indeterm   OV2poly) _
;     (MultivariatePolynomial               indeterm   OV2poly) _
;     (OrderedVariableList                  indeterm   OV2OV) _
;     (Polynomial                           total      OV2P) _
;     (Symbol                               total      OV2Sy) _
;     (UnivariatePolynomial                 indeterm   OV2poly) _
;     ))_
;   (Polynomial . ( _
;     (DistributedMultivariatePolynomial    indeterm   P2Dmp) _
;     (Expression                           indeterm   P2Expr) _
;     (Factored                             indeterm   P2FR) _
;     (HomogeneousDistributedMultivariatePolynomial partial    domain2NDmp) _
;     (MultivariatePolynomial               indeterm   P2Mp) _
;     (UnivariateLaurentSeries              indeterm   P2Uls) _
;     (UnivariatePolynomial                 indeterm   P2Up) _
;     (UnivariatePuiseuxSeries              indeterm   P2Upxs) _
;     (UnivariateTaylorSeries               indeterm   P2Uts) _
;     ))_
;   (Set . ( _
;     (List                                 indeterm   Set2L) _
;     (Vector                               indeterm   Agg2L2Agg) _
;     ))_
;   (RectangularMatrix . ( _
;     (List                                 indeterm   Rm2L) _
;     (Matrix                               indeterm   Rm2M) _
;     (SquareMatrix                         indeterm   Rm2Sm) _
;     (Vector                               indeterm   Rm2V) _
;     ))_
;   (SparseUnivariatePolynomial . ( _
;     (UnivariatePolynomial                       indeterm   SUP2Up) _
;     ))_
;   (SquareMatrix . (
;     -- ones for polys needed for M[2] P I -> P[x,y] M[2] P I, say
;     (DistributedMultivariatePolynomial            partial    Sm2PolyType) _
;     (HomogeneousDistributedMultivariatePolynomial partial    Sm2PolyType) _
;     (List                                         indeterm   Sm2L) _
;     (Matrix                                       indeterm   Sm2M) _
;     (MultivariatePolynomial                       partial    Sm2PolyType) _
;     (RectangularMatrix                            indeterm   Sm2Rm) _
;     (UnivariatePolynomial                         indeterm   Sm2PolyType) _
;     (Vector                                       indeterm   Sm2V) _
;     ) ) _
;   (Symbol . ( _
;     (DistributedMultivariatePolynomial            indeterm   Sy2Dmp) _
;     (HomogeneousDistributedMultivariatePolynomial indeterm   Sy2NDmp) _
;     (MultivariatePolynomial                       indeterm   Sy2Mp) _
;     (OrderedVariableList                          partial    Sy2OV) _
;     (Polynomial                                   total      Sy2P) _
;     (UnivariatePolynomial                         indeterm   Sy2Up) _
;     (Variable                                     indeterm   Sy2Var) _
;     ) ) _
;   (UnivariatePolynomial . ( _
;     (DistributedMultivariatePolynomial            indeterm   Up2Dmp) _
;     (Expression                                   indeterm   Up2Expr) _
;     (Factored                                     indeterm   Up2FR) _
;     (HomogeneousDistributedMultivariatePolynomial indeterm   domain2NDmp) _
;     (MultivariatePolynomial                       indeterm   Up2Mp) _
;     (Polynomial                                   indeterm   Up2P) _
;     (SparseUnivariatePolynomial                   indeterm   Up2SUP) _
;     (UnivariatePolynomial                         indeterm   Up2Up) _
;     ) ) _
;   (Variable . ( _
;     (ContinuedFractionPowerSeries                 indeterm   Var2OtherPS) _
;     (DistributedMultivariatePolynomial            indeterm   Var2Dmp) _
;     (Fraction                                     indeterm   Var2QF) _
;     (GeneralDistributedMultivariatePolynomial     indeterm   Var2Gdmp) _
;     (HomogeneousDistributedMultivariatePolynomial indeterm   Var2NDmp) _
;     (MultivariatePolynomial                       indeterm   Var2Mp) _
;     (OrderedVariableList                          indeterm   Var2OV) _
;     (Polynomial                                   total      Var2P) _
;     (SparseUnivariatePolynomial                   indeterm   Var2SUP) _
;     (Symbol                                       total      Identity) _
;     (UnivariatePolynomial                         indeterm   Var2Up) _
;     (UnivariatePowerSeries                        indeterm   Var2UpS) _
;     ) ) _
;   (Vector . ( _
;     (DirectProduct                        indeterm   V2DP) _
;     (List                                 indeterm   V2L) _
;     (Matrix                               indeterm   V2M) _
;     (RectangularMatrix                    indeterm   V2Rm) _
;     (Set                                  indeterm   Agg2L2Agg) _
;     (SquareMatrix                         indeterm   V2Sm) _
;     (Stream                               indeterm   Agg2Agg) _
;     ) ) _
;   ) )

(DEFPARAMETER |$CoerceTable|
  '((|Complex| (|Expression| |indeterm| |Complex2Expr|)
     (|Factored| |indeterm| |Complex2FR|)
     (|Integer| |partial| |Complex2underDomain|)
     (|PrimeField| |partial| |Complex2underDomain|))
    (|DirectProduct| (|DirectProduct| |partial| DP2DP))
    (|DistributedMultivariatePolynomial|
     (|DistributedMultivariatePolynomial| |indeterm| |Dmp2Dmp|)
     (|Expression| |indeterm| |Dmp2Expr|) (|Factored| |indeterm| |Mp2FR|)
     (|HomogeneousDistributedMultivariatePolynomial| |indeterm| |Dmp2NDmp|)
     (|MultivariatePolynomial| |indeterm| |Dmp2Mp|)
     (|Polynomial| |indeterm| |Dmp2P|)
     (|UnivariatePolynomial| |indeterm| |Dmp2Up|))
    (|Expression| (|Complex| |partial| |Expr2Complex|)
     (|DistributedMultivariatePolynomial| |indeterm| |Expr2Dmp|)
     (|HomogeneousDistributedMultivariatePolynomial| |indeterm| |Expr2Dmp|)
     (|MultivariatePolynomial| |indeterm| |Expr2Mp|)
     (|UnivariateLaurentSeries| |indeterm| |P2Uls|)
     (|UnivariatePolynomial| |indeterm| |Expr2Up|)
     (|UnivariatePuiseuxSeries| |indeterm| |P2Upxs|)
     (|UnivariateTaylorSeries| |indeterm| |P2Uts|))
    (|Kernel| (|Kernel| |indeterm| |Ker2Ker|)
     (|Expression| |indeterm| |Ker2Expr|))
    (|Factored| (|Factored| |indeterm| |Factored2Factored|))
    (|Fraction| (|DistributedMultivariatePolynomial| |partial| |Qf2domain|)
     (|Expression| |indeterm| |Qf2EF|) (|Fraction| |indeterm| |Qf2Qf|)
     (|HomogeneousDistributedMultivariatePolynomial| |partial| |Qf2domain|)
     (|Integer| |partial| |Qf2domain|)
     (|MultivariatePolynomial| |partial| |Qf2domain|)
     (|Polynomial| |partial| |Qf2domain|) (|PrimeField| |indeterm| |Qf2PF|)
     (|UnivariateLaurentSeries| |indeterm| |P2Uls|)
     (|UnivariatePolynomial| |partial| |Qf2domain|)
     (|UnivariatePuiseuxSeries| |indeterm| |P2Upxs|)
     (|UnivariateTaylorSeries| |indeterm| |P2Uts|))
    (|Integer| (|NonNegativeInteger| |partial| I2NNI)
     (|PositiveInteger| |partial| I2PI))
    (|List| (|DirectProduct| |indeterm| L2DP) (|Matrix| |partial| L2M)
     (|Record| |partial| |L2Record|) (|RectangularMatrix| |partial| |L2Rm|)
     (|Set| |indeterm| |L2Set|) (|SquareMatrix| |partial| |L2Sm|)
     (|Stream| |indeterm| |Agg2Agg|) (|Tuple| |indeterm| |L2Tuple|)
     (|Vector| |indeterm| L2V))
    (|Matrix| (|List| |indeterm| M2L) (|RectangularMatrix| |partial| |M2Rm|)
     (|SquareMatrix| |partial| |M2Sm|) (|Vector| |indeterm| M2L))
    (|MultivariatePolynomial|
     (|DistributedMultivariatePolynomial| |indeterm| |Mp2Dmp|)
     (|Expression| |indeterm| |Mp2Expr|) (|Factored| |indeterm| |Mp2FR|)
     (|HomogeneousDistributedMultivariatePolynomial| |indeterm| |domain2NDmp|)
     (|MultivariatePolynomial| |indeterm| |Mp2Mp|)
     (|Polynomial| |indeterm| |Mp2P|)
     (|UnivariatePolynomial| |indeterm| |Mp2Up|))
    (|HomogeneousDirectProduct| (|HomogeneousDirectProduct| |indeterm| DP2DP))
    (|HomogeneousDistributedMultivariatePolynomial|
     (|Complex| |indeterm| |NDmp2domain|)
     (|DistributedMultivariatePolynomial| |indeterm| |NDmp2domain|)
     (|Expression| |indeterm| |Dmp2Expr|) (|Factored| |indeterm| |Mp2FR|)
     (|Fraction| |indeterm| |NDmp2domain|)
     (|HomogeneousDistributedMultivariatePolynomial| |indeterm| |NDmp2NDmp|)
     (|MultivariatePolynomial| |indeterm| |NDmp2domain|)
     (|Polynomial| |indeterm| |NDmp2domain|)
     (|Quaternion| |indeterm| |NDmp2domain|)
     (|UnivariatePolynomial| |indeterm| |NDmp2domain|))
    (|OrderedVariableList|
     (|DistributedMultivariatePolynomial| |indeterm| |OV2poly|)
     (|HomogeneousDistributedMultivariatePolynomial| |indeterm| |OV2poly|)
     (|MultivariatePolynomial| |indeterm| |OV2poly|)
     (|OrderedVariableList| |indeterm| OV2OV) (|Polynomial| |total| OV2P)
     (|Symbol| |total| |OV2Sy|) (|UnivariatePolynomial| |indeterm| |OV2poly|))
    (|Polynomial| (|DistributedMultivariatePolynomial| |indeterm| |P2Dmp|)
     (|Expression| |indeterm| |P2Expr|) (|Factored| |indeterm| P2FR)
     (|HomogeneousDistributedMultivariatePolynomial| |partial| |domain2NDmp|)
     (|MultivariatePolynomial| |indeterm| |P2Mp|)
     (|UnivariateLaurentSeries| |indeterm| |P2Uls|)
     (|UnivariatePolynomial| |indeterm| |P2Up|)
     (|UnivariatePuiseuxSeries| |indeterm| |P2Upxs|)
     (|UnivariateTaylorSeries| |indeterm| |P2Uts|))
    (|Set| (|List| |indeterm| |Set2L|) (|Vector| |indeterm| |Agg2L2Agg|))
    (|RectangularMatrix| (|List| |indeterm| |Rm2L|)
     (|Matrix| |indeterm| |Rm2M|) (|SquareMatrix| |indeterm| |Rm2Sm|)
     (|Vector| |indeterm| |Rm2V|))
    (|SparseUnivariatePolynomial| (|UnivariatePolynomial| |indeterm| |SUP2Up|))
    (|SquareMatrix|
     (|DistributedMultivariatePolynomial| |partial| |Sm2PolyType|)
     (|HomogeneousDistributedMultivariatePolynomial| |partial| |Sm2PolyType|)
     (|List| |indeterm| |Sm2L|) (|Matrix| |indeterm| |Sm2M|)
     (|MultivariatePolynomial| |partial| |Sm2PolyType|)
     (|RectangularMatrix| |indeterm| |Sm2Rm|)
     (|UnivariatePolynomial| |indeterm| |Sm2PolyType|)
     (|Vector| |indeterm| |Sm2V|))
    (|Symbol| (|DistributedMultivariatePolynomial| |indeterm| |Sy2Dmp|)
     (|HomogeneousDistributedMultivariatePolynomial| |indeterm| |Sy2NDmp|)
     (|MultivariatePolynomial| |indeterm| |Sy2Mp|)
     (|OrderedVariableList| |partial| |Sy2OV|) (|Polynomial| |total| |Sy2P|)
     (|UnivariatePolynomial| |indeterm| |Sy2Up|)
     (|Variable| |indeterm| |Sy2Var|))
    (|UnivariatePolynomial|
     (|DistributedMultivariatePolynomial| |indeterm| |Up2Dmp|)
     (|Expression| |indeterm| |Up2Expr|) (|Factored| |indeterm| |Up2FR|)
     (|HomogeneousDistributedMultivariatePolynomial| |indeterm| |domain2NDmp|)
     (|MultivariatePolynomial| |indeterm| |Up2Mp|)
     (|Polynomial| |indeterm| |Up2P|)
     (|SparseUnivariatePolynomial| |indeterm| |Up2SUP|)
     (|UnivariatePolynomial| |indeterm| |Up2Up|))
    (|Variable| (|ContinuedFractionPowerSeries| |indeterm| |Var2OtherPS|)
     (|DistributedMultivariatePolynomial| |indeterm| |Var2Dmp|)
     (|Fraction| |indeterm| |Var2QF|)
     (|GeneralDistributedMultivariatePolynomial| |indeterm| |Var2Gdmp|)
     (|HomogeneousDistributedMultivariatePolynomial| |indeterm| |Var2NDmp|)
     (|MultivariatePolynomial| |indeterm| |Var2Mp|)
     (|OrderedVariableList| |indeterm| |Var2OV|) (|Polynomial| |total| |Var2P|)
     (|SparseUnivariatePolynomial| |indeterm| |Var2SUP|)
     (|Symbol| |total| |Identity|) (|UnivariatePolynomial| |indeterm| |Var2Up|)
     (|UnivariatePowerSeries| |indeterm| |Var2UpS|))
    (|Vector| (|DirectProduct| |indeterm| V2DP) (|List| |indeterm| V2L)
     (|Matrix| |indeterm| V2M) (|RectangularMatrix| |indeterm| |V2Rm|)
     (|Set| |indeterm| |Agg2L2Agg|) (|SquareMatrix| |indeterm| |V2Sm|)
     (|Stream| |indeterm| |Agg2Agg|))))

; DEFPARAMETER($CommuteTable, '(                                           _
;   (Complex . (                                                         _
;     (DistributedMultivariatePolynomial    commute    commuteG2)         _
;     (MultivariatePolynomial               commute    commuteG2)         _
;     (HomogeneousDistributedMultivariatePolynomial commute    commuteG2) _
;     (Polynomial                           commute    commuteG1)         _
;     (Fraction                             commute    commuteG1)         _
;     (SquareMatrix                         commute    commuteG2)         _
;     (UnivariatePolynomial                 commute    commuteG2)         _
;     ))                                                                  _
;   (Polynomial . (                                                       _
;     (Complex                              commute    commuteMultPol)    _
;     (MultivariatePolynomial               commute    commuteMultPol)    _
;     (HomogeneousDistributedMultivariatePolynomial commute    commuteMultPol)_
;     (Polynomial                           commute    commuteMultPol)    _
;     (Quaternion                           commute    commuteMultPol)    _
;     (Fraction                             commute    commuteMultPol)    _
;     (SquareMatrix                         commute    commuteMultPol)    _
;     (UnivariatePolynomial                 commute    commuteMultPol)    _
;     ))                                                                  _
;   (SquareMatrix . (                                                     _
;     (DistributedMultivariatePolynomial    commute    commuteSm2)        _
;     (Complex                              commute    commuteSm1)        _
;     (MultivariatePolynomial               commute    commuteSm2)        _
;     (HomogeneousDistributedMultivariatePolynomial commute    commuteSm2)_
;     (Polynomial                           commute    commuteSm1)        _
;     (Quaternion                           commute    commuteSm1)        _
;     (SparseUnivariatePolynomial           commute    commuteSm1)        _
;     (UnivariatePolynomial                 commute    commuteSm2)        _
;     ))                                                                  _
;   ))

(DEFPARAMETER |$CommuteTable|
  '((|Complex| (|DistributedMultivariatePolynomial| |commute| |commuteG2|)
     (|MultivariatePolynomial| |commute| |commuteG2|)
     (|HomogeneousDistributedMultivariatePolynomial| |commute| |commuteG2|)
     (|Polynomial| |commute| |commuteG1|) (|Fraction| |commute| |commuteG1|)
     (|SquareMatrix| |commute| |commuteG2|)
     (|UnivariatePolynomial| |commute| |commuteG2|))
    (|Polynomial| (|Complex| |commute| |commuteMultPol|)
     (|MultivariatePolynomial| |commute| |commuteMultPol|)
     (|HomogeneousDistributedMultivariatePolynomial| |commute|
      |commuteMultPol|)
     (|Polynomial| |commute| |commuteMultPol|)
     (|Quaternion| |commute| |commuteMultPol|)
     (|Fraction| |commute| |commuteMultPol|)
     (|SquareMatrix| |commute| |commuteMultPol|)
     (|UnivariatePolynomial| |commute| |commuteMultPol|))
    (|SquareMatrix|
     (|DistributedMultivariatePolynomial| |commute| |commuteSm2|)
     (|Complex| |commute| |commuteSm1|)
     (|MultivariatePolynomial| |commute| |commuteSm2|)
     (|HomogeneousDistributedMultivariatePolynomial| |commute| |commuteSm2|)
     (|Polynomial| |commute| |commuteSm1|)
     (|Quaternion| |commute| |commuteSm1|)
     (|SparseUnivariatePolynomial| |commute| |commuteSm1|)
     (|UnivariatePolynomial| |commute| |commuteSm2|))))

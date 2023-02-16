
; )package "BOOT"

(IN-PACKAGE "BOOT")

; compHash(op, argl, body, cacheName, eqEtc) ==
;
;   auxfn := INTERNL1(op, '";")
;   g1:= GENSYM()  --argument or argument list
;   [arg,cacheArgKey,computeValue] :=
;   --    arg: to be used as formal argument of lambda construction;
;   --    cacheArgKey: the form used to look up the value in the cache
;   --    computeValue: the form used to compute the value from arg
;     null argl => [nil,nil,[auxfn]]
;     argl is [.] =>
;       -- we call 'devaluate' only on domains
;       key := maybe_devaluate(g1, first($functor_cosig1))
;       [[g1],['LIST,key],[auxfn,g1]]  --g1 is a parameter
;     -- we call 'devaluate' only on domains
;     all_type := true
;     for c in $functor_cosig1 while all_type repeat
;         all_type := c
;     key :=
;         all_type => ['devaluateList, g1]
;         ["devaluate_sig", g1, ["QUOTE", $functor_cosig1]]
;     [g1, key, ['APPLY,['function,auxfn],g1]]   --g1 is a parameter list
;   if $reportCounts=true then
;     hitCounter := INTERNL1(op, '";hit")
;     callCounter := INTERNL1(op, '";calls")
;     SET(hitCounter,0)
;     SET(callCounter,0)
;     callCountCode := [['SETQ, callCounter, ['inc_SI, callCounter]]]
;     hitCountCode := [['SETQ, hitCounter, ['inc_SI, hitCounter]]]
;   g2:= GENSYM()  --value computed by calling function
;   returnFoundValue:=
;     null argl =>
;     --  if we have a global hastable, functions with no arguments are
;     --  stored in the same format as those with several arguments, e.g.
;     --  to cache the value <val> given by f(), the structure
;     --  ((nil <count> <val>)) is stored in the cache
;         ['CDRwithIncrement,['CDAR,g2]]
;     ['CDRwithIncrement,g2]
;   getCode:=
;     null argl => ['HGET,cacheName,MKQ op]
;     ['lassocShiftWithFunction, cacheArgKey,
;           ['HGET, cacheName, MKQ op], MKQ eqEtc]
;   secondPredPair:= [['SETQ,g2,getCode],:hitCountCode,returnFoundValue]
;   putCode:=
;       null argl =>
;           ['CDDAR, ['HPUT, cacheName, MKQ op,
;                    ['LIST, ['CONS, nil, ['CONS, 1, computeValue]]]]]
;       computeValue
;   putCode :=
;      ['UNWIND_-PROTECT,['PROG1,putCode,['SETQ,g2,'T]],
;                   ['COND, [['NOT, g2], ['HREM, cacheName, MKQ op]]]]
;   thirdPredPair:= ['(QUOTE T),putCode]
;   codeBody:= ['PROG,[g2],
;                :callCountCode,['RETURN,['COND,secondPredPair,thirdPredPair]]]
;   lamex:= ['LAMBDA, arg, codeBody]
;   mainFunction:= [op,lamex]
;   computeFunction:= [auxfn,['LAMBDA,argl,:body]]
;
;   -- compile generated function stub
;   compileInteractive mainFunction
;
;   -- compile main body: this has already been compTran'ed
;   if $reportCompilation then
;     sayBrightlyI bright '"Generated LISP code for function:"
;     pp computeFunction
;   compileQuietly computeFunction
;   op

(DEFUN |compHash| (|op| |argl| |body| |cacheName| |eqEtc|)
  (PROG (|auxfn| |g1| |key| |all_type| |LETTMP#1| |arg| |cacheArgKey|
         |computeValue| |hitCounter| |callCounter| |callCountCode|
         |hitCountCode| |g2| |returnFoundValue| |getCode| |secondPredPair|
         |putCode| |thirdPredPair| |codeBody| |lamex| |mainFunction|
         |computeFunction|)
    (RETURN
     (PROGN
      (SETQ |auxfn| (INTERNL1 |op| ";"))
      (SETQ |g1| (GENSYM))
      (SETQ |LETTMP#1|
              (COND ((NULL |argl|) (LIST NIL NIL (LIST |auxfn|)))
                    ((AND (CONSP |argl|) (EQ (CDR |argl|) NIL))
                     (PROGN
                      (SETQ |key|
                              (|maybe_devaluate| |g1| (CAR |$functor_cosig1|)))
                      (LIST (LIST |g1|) (LIST 'LIST |key|)
                            (LIST |auxfn| |g1|))))
                    (#1='T
                     (PROGN
                      (SETQ |all_type| T)
                      ((LAMBDA (|bfVar#1| |c|)
                         (LOOP
                          (COND
                           ((OR (ATOM |bfVar#1|)
                                (PROGN (SETQ |c| (CAR |bfVar#1|)) NIL)
                                (NOT |all_type|))
                            (RETURN NIL))
                           (#1# (SETQ |all_type| |c|)))
                          (SETQ |bfVar#1| (CDR |bfVar#1|))))
                       |$functor_cosig1| NIL)
                      (SETQ |key|
                              (COND (|all_type| (LIST '|devaluateList| |g1|))
                                    (#1#
                                     (LIST '|devaluate_sig| |g1|
                                           (LIST 'QUOTE |$functor_cosig1|)))))
                      (LIST |g1| |key|
                            (LIST 'APPLY (LIST '|function| |auxfn|) |g1|))))))
      (SETQ |arg| (CAR |LETTMP#1|))
      (SETQ |cacheArgKey| (CADR . #2=(|LETTMP#1|)))
      (SETQ |computeValue| (CADDR . #2#))
      (COND
       ((EQUAL |$reportCounts| T) (SETQ |hitCounter| (INTERNL1 |op| ";hit"))
        (SETQ |callCounter| (INTERNL1 |op| ";calls")) (SET |hitCounter| 0)
        (SET |callCounter| 0)
        (SETQ |callCountCode|
                (LIST
                 (LIST 'SETQ |callCounter| (LIST '|inc_SI| |callCounter|))))
        (SETQ |hitCountCode|
                (LIST
                 (LIST 'SETQ |hitCounter| (LIST '|inc_SI| |hitCounter|))))))
      (SETQ |g2| (GENSYM))
      (SETQ |returnFoundValue|
              (COND
               ((NULL |argl|) (LIST '|CDRwithIncrement| (LIST 'CDAR |g2|)))
               (#1# (LIST '|CDRwithIncrement| |g2|))))
      (SETQ |getCode|
              (COND ((NULL |argl|) (LIST 'HGET |cacheName| (MKQ |op|)))
                    (#1#
                     (LIST '|lassocShiftWithFunction| |cacheArgKey|
                           (LIST 'HGET |cacheName| (MKQ |op|))
                           (MKQ |eqEtc|)))))
      (SETQ |secondPredPair|
              (CONS (LIST 'SETQ |g2| |getCode|)
                    (APPEND |hitCountCode| (CONS |returnFoundValue| NIL))))
      (SETQ |putCode|
              (COND
               ((NULL |argl|)
                (LIST 'CDDAR
                      (LIST 'HPUT |cacheName| (MKQ |op|)
                            (LIST 'LIST
                                  (LIST 'CONS NIL
                                        (LIST 'CONS 1 |computeValue|))))))
               (#1# |computeValue|)))
      (SETQ |putCode|
              (LIST 'UNWIND-PROTECT
                    (LIST 'PROG1 |putCode| (LIST 'SETQ |g2| 'T))
                    (LIST 'COND
                          (LIST (LIST 'NOT |g2|)
                                (LIST 'HREM |cacheName| (MKQ |op|))))))
      (SETQ |thirdPredPair| (LIST ''T |putCode|))
      (SETQ |codeBody|
              (CONS 'PROG
                    (CONS (LIST |g2|)
                          (APPEND |callCountCode|
                                  (CONS
                                   (LIST 'RETURN
                                         (LIST 'COND |secondPredPair|
                                               |thirdPredPair|))
                                   NIL)))))
      (SETQ |lamex| (LIST 'LAMBDA |arg| |codeBody|))
      (SETQ |mainFunction| (LIST |op| |lamex|))
      (SETQ |computeFunction|
              (LIST |auxfn| (CONS 'LAMBDA (CONS |argl| |body|))))
      (|compileInteractive| |mainFunction|)
      (COND
       (|$reportCompilation|
        (|sayBrightlyI| (|bright| "Generated LISP code for function:"))
        (|pp| |computeFunction|)))
      (|compileQuietly| |computeFunction|)
      |op|))))

; devaluate_sig(tl, cl) == [(c => devaluate(t); t) for t in tl for c in cl]

(DEFUN |devaluate_sig| (|tl| |cl|)
  (PROG ()
    (RETURN
     ((LAMBDA (|bfVar#4| |bfVar#2| |t| |bfVar#3| |c|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#2|) (PROGN (SETQ |t| (CAR |bfVar#2|)) NIL)
               (ATOM |bfVar#3|) (PROGN (SETQ |c| (CAR |bfVar#3|)) NIL))
           (RETURN (NREVERSE |bfVar#4|)))
          (#1='T
           (SETQ |bfVar#4|
                   (CONS (COND (|c| (|devaluate| |t|)) (#1# |t|)) |bfVar#4|))))
         (SETQ |bfVar#2| (CDR |bfVar#2|))
         (SETQ |bfVar#3| (CDR |bfVar#3|))))
      NIL |tl| NIL |cl| NIL))))

; CDRwithIncrement x ==
;   RPLACA(x, inc_SI first x)
;   CDR x

(DEFUN |CDRwithIncrement| (|x|)
  (PROG () (RETURN (PROGN (RPLACA |x| (|inc_SI| (CAR |x|))) (CDR |x|)))))

; clearClams() ==
;   for [fn,kind,:.] in $clamList | kind = 'hash or INTEGERP kind repeat
;     clearClam fn

(DEFUN |clearClams| ()
  (PROG (|kind| |ISTMP#1| |fn|)
    (RETURN
     ((LAMBDA (|bfVar#6| |bfVar#5|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#6|) (PROGN (SETQ |bfVar#5| (CAR |bfVar#6|)) NIL))
           (RETURN NIL))
          (#1='T
           (AND (CONSP |bfVar#5|)
                (PROGN
                 (SETQ |fn| (CAR |bfVar#5|))
                 (SETQ |ISTMP#1| (CDR |bfVar#5|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN (SETQ |kind| (CAR |ISTMP#1|)) #1#)))
                (OR (EQ |kind| '|hash|) (INTEGERP |kind|))
                (|clearClam| |fn|))))
         (SETQ |bfVar#6| (CDR |bfVar#6|))))
      |$clamList| NIL))))

; clearClam fn ==
;   infovec := GET(fn, 'cacheInfo) or keyedSystemError("S2GE0003", [fn])
;   -- eval infovec.cacheReset
;   ir := infovec.cacheReset
;   ir is ["SETQ", var , ['MAKE_HASHTABLE, ["QUOTE", mode]]] =>
;      SETF(SYMBOL_-VALUE(var), MAKE_HASHTABLE(mode))
;   ir is ["SETQ", var , ["initCache", val]] =>
;      SETF(SYMBOL_-VALUE(var), initCache(val))
;   BREAK()

(DEFUN |clearClam| (|fn|)
  (PROG (|infovec| |ir| |ISTMP#1| |var| |ISTMP#2| |ISTMP#3| |ISTMP#4| |ISTMP#5|
         |ISTMP#6| |mode| |val|)
    (RETURN
     (PROGN
      (SETQ |infovec|
              (OR (GET |fn| '|cacheInfo|)
                  (|keyedSystemError| 'S2GE0003 (LIST |fn|))))
      (SETQ |ir| (CADDDR |infovec|))
      (COND
       ((AND (CONSP |ir|) (EQ (CAR |ir|) 'SETQ)
             (PROGN
              (SETQ |ISTMP#1| (CDR |ir|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |var| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN
                          (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|)
                               (EQ (CAR |ISTMP#3|) 'MAKE_HASHTABLE)
                               (PROGN
                                (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                     (PROGN
                                      (SETQ |ISTMP#5| (CAR |ISTMP#4|))
                                      (AND (CONSP |ISTMP#5|)
                                           (EQ (CAR |ISTMP#5|) 'QUOTE)
                                           (PROGN
                                            (SETQ |ISTMP#6| (CDR |ISTMP#5|))
                                            (AND (CONSP |ISTMP#6|)
                                                 (EQ (CDR |ISTMP#6|) NIL)
                                                 (PROGN
                                                  (SETQ |mode| (CAR |ISTMP#6|))
                                                  #1='T))))))))))))))
        (SETF (SYMBOL-VALUE |var|) (MAKE_HASHTABLE |mode|)))
       ((AND (CONSP |ir|) (EQ (CAR |ir|) 'SETQ)
             (PROGN
              (SETQ |ISTMP#1| (CDR |ir|))
              (AND (CONSP |ISTMP#1|)
                   (PROGN
                    (SETQ |var| (CAR |ISTMP#1|))
                    (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                    (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                         (PROGN
                          (SETQ |ISTMP#3| (CAR |ISTMP#2|))
                          (AND (CONSP |ISTMP#3|)
                               (EQ (CAR |ISTMP#3|) '|initCache|)
                               (PROGN
                                (SETQ |ISTMP#4| (CDR |ISTMP#3|))
                                (AND (CONSP |ISTMP#4|) (EQ (CDR |ISTMP#4|) NIL)
                                     (PROGN
                                      (SETQ |val| (CAR |ISTMP#4|))
                                      #1#))))))))))
        (SETF (SYMBOL-VALUE |var|) (|initCache| |val|)))
       (#1# (BREAK)))))))

; reportAndClearClams() ==
;   cacheStats()
;   clearClams()

(DEFUN |reportAndClearClams| ()
  (PROG () (RETURN (PROGN (|cacheStats|) (|clearClams|)))))

; clear_sorted_caches() ==
;     scl := HGET($ConstructorCache, "SortedCache")
;     for [., ., :dom] in scl repeat
;        cc := compiledLookupCheck("clearCache", [$Void], dom)
;        SPADCALL(cc)

(DEFUN |clear_sorted_caches| ()
  (PROG (|cc| |dom| |ISTMP#1| |scl|)
    (RETURN
     (PROGN
      (SETQ |scl| (HGET |$ConstructorCache| '|SortedCache|))
      ((LAMBDA (|bfVar#8| |bfVar#7|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#8|) (PROGN (SETQ |bfVar#7| (CAR |bfVar#8|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#7|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |bfVar#7|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |dom| (CDR |ISTMP#1|)) #1#)))
                 (PROGN
                  (SETQ |cc|
                          (|compiledLookupCheck| '|clearCache| (LIST |$Void|)
                           |dom|))
                  (SPADCALL |cc|)))))
          (SETQ |bfVar#8| (CDR |bfVar#8|))))
       |scl| NIL)))))

; clearConstructorCaches() ==
;   clear_sorted_caches()
;   clearCategoryCaches()
;   CLRHASH $ConstructorCache

(DEFUN |clearConstructorCaches| ()
  (PROG ()
    (RETURN
     (PROGN
      (|clear_sorted_caches|)
      (|clearCategoryCaches|)
      (CLRHASH |$ConstructorCache|)))))

; clearConstructorCache(cname) ==
;   (kind := GETDATABASE(cname,'CONSTRUCTORKIND)) =>
;     kind = 'category => clearCategoryCache cname
;     HREM($ConstructorCache,cname)

(DEFUN |clearConstructorCache| (|cname|)
  (PROG (|kind|)
    (RETURN
     (COND
      ((SETQ |kind| (GETDATABASE |cname| 'CONSTRUCTORKIND))
       (IDENTITY
        (COND ((EQ |kind| '|category|) (|clearCategoryCache| |cname|))
              ('T (HREM |$ConstructorCache| |cname|)))))))))

; clearConstructorAndLisplibCaches() ==
;   clearClams()
;   clearConstructorCaches()

(DEFUN |clearConstructorAndLisplibCaches| ()
  (PROG () (RETURN (PROGN (|clearClams|) (|clearConstructorCaches|)))))

; clearCategoryCaches() ==
;   for name in allConstructors() repeat
;     if GETDATABASE(name,'CONSTRUCTORKIND) = 'category then
;       if BOUNDP(cacheName := INTERNL1(PNAME(name), '";AL"))
;             then SET(cacheName,nil)
;     if BOUNDP(cacheName := INTERNL1(PNAME(name), '";CAT"))
;           then SET(cacheName,nil)

(DEFUN |clearCategoryCaches| ()
  (PROG (|cacheName|)
    (RETURN
     ((LAMBDA (|bfVar#9| |name|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#9|) (PROGN (SETQ |name| (CAR |bfVar#9|)) NIL))
           (RETURN NIL))
          ('T
           (PROGN
            (COND
             ((EQ (GETDATABASE |name| 'CONSTRUCTORKIND) '|category|)
              (COND
               ((BOUNDP (SETQ |cacheName| (INTERNL1 (PNAME |name|) ";AL")))
                (SET |cacheName| NIL)))))
            (COND
             ((BOUNDP (SETQ |cacheName| (INTERNL1 (PNAME |name|) ";CAT")))
              (SET |cacheName| NIL))))))
         (SETQ |bfVar#9| (CDR |bfVar#9|))))
      (|allConstructors|) NIL))))

; clearCategoryCache catName ==
;   cacheName := INTERNL1(PNAME(catName), '";AL")
;   SET(cacheName,nil)

(DEFUN |clearCategoryCache| (|catName|)
  (PROG (|cacheName|)
    (RETURN
     (PROGN
      (SETQ |cacheName| (INTERNL1 (PNAME |catName|) ";AL"))
      (SET |cacheName| NIL)))))

; displayHashtable x ==
;   l:= NREVERSE SORTBY('CAR,[[opOf HGET(x,key),key] for key in HKEYS x])
;   for [a,b] in l repeat
;     sayBrightlyNT ['%b,a,'%d]
;     pp b

(DEFUN |displayHashtable| (|x|)
  (PROG (|l| |a| |ISTMP#1| |b|)
    (RETURN
     (PROGN
      (SETQ |l|
              (NREVERSE
               (SORTBY 'CAR
                ((LAMBDA (|bfVar#11| |bfVar#10| |key|)
                   (LOOP
                    (COND
                     ((OR (ATOM |bfVar#10|)
                          (PROGN (SETQ |key| (CAR |bfVar#10|)) NIL))
                      (RETURN (NREVERSE |bfVar#11|)))
                     (#1='T
                      (SETQ |bfVar#11|
                              (CONS (LIST (|opOf| (HGET |x| |key|)) |key|)
                                    |bfVar#11|))))
                    (SETQ |bfVar#10| (CDR |bfVar#10|))))
                 NIL (HKEYS |x|) NIL))))
      ((LAMBDA (|bfVar#13| |bfVar#12|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#13|)
                (PROGN (SETQ |bfVar#12| (CAR |bfVar#13|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#12|)
                 (PROGN
                  (SETQ |a| (CAR |bfVar#12|))
                  (SETQ |ISTMP#1| (CDR |bfVar#12|))
                  (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                       (PROGN (SETQ |b| (CAR |ISTMP#1|)) #1#)))
                 (PROGN (|sayBrightlyNT| (LIST '|%b| |a| '|%d|)) (|pp| |b|)))))
          (SETQ |bfVar#13| (CDR |bfVar#13|))))
       |l| NIL)))))

; cacheStats() ==
;   for [fn,kind,:u] in $clamList repeat
;     not MEMQ('count,u) =>
;       sayBrightly ["%b",fn,"%d","does not keep reference counts"]
;     INTEGERP kind => reportCircularCacheStats(fn,kind)
;     kind = 'hash => reportHashCacheStats fn
;     sayBrightly ["Unknown cache type for","%b",fn,"%d"]

(DEFUN |cacheStats| ()
  (PROG (|u| |kind| |ISTMP#1| |fn|)
    (RETURN
     ((LAMBDA (|bfVar#15| |bfVar#14|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#15|)
               (PROGN (SETQ |bfVar#14| (CAR |bfVar#15|)) NIL))
           (RETURN NIL))
          (#1='T
           (AND (CONSP |bfVar#14|)
                (PROGN
                 (SETQ |fn| (CAR |bfVar#14|))
                 (SETQ |ISTMP#1| (CDR |bfVar#14|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN
                       (SETQ |kind| (CAR |ISTMP#1|))
                       (SETQ |u| (CDR |ISTMP#1|))
                       #1#)))
                (COND
                 ((NULL (MEMQ '|count| |u|))
                  (|sayBrightly|
                   (LIST '|%b| |fn| '|%d| '|does not keep reference counts|)))
                 ((INTEGERP |kind|) (|reportCircularCacheStats| |fn| |kind|))
                 ((EQ |kind| '|hash|) (|reportHashCacheStats| |fn|))
                 (#1#
                  (|sayBrightly|
                   (LIST '|Unknown cache type for| '|%b| |fn| '|%d|)))))))
         (SETQ |bfVar#15| (CDR |bfVar#15|))))
      |$clamList| NIL))))

; reportCircularCacheStats(fn,n) ==
;   infovec := GET(fn, 'cacheInfo)
;   circList:= eval infovec.cacheName
;   numberUsed :=
;     +/[1 for i in 1..n for x in circList while x isnt [='_$failed,:.]]
;   sayBrightly ["%b",fn,"%d","has","%b",numberUsed,"%d","/ ",n," values cached"]
;   displayCacheFrequency mkCircularCountAlist(circList,n)
;   TERPRI()

(DEFUN |reportCircularCacheStats| (|fn| |n|)
  (PROG (|infovec| |circList| |numberUsed|)
    (RETURN
     (PROGN
      (SETQ |infovec| (GET |fn| '|cacheInfo|))
      (SETQ |circList| (|eval| (CADR |infovec|)))
      (SETQ |numberUsed|
              ((LAMBDA (|bfVar#17| |i| |bfVar#16| |x|)
                 (LOOP
                  (COND
                   ((OR (> |i| |n|) (ATOM |bfVar#16|)
                        (PROGN (SETQ |x| (CAR |bfVar#16|)) NIL)
                        (AND (CONSP |x|) (EQUAL (CAR |x|) '|$failed|)))
                    (RETURN |bfVar#17|))
                   ('T (SETQ |bfVar#17| (+ |bfVar#17| 1))))
                  (SETQ |i| (+ |i| 1))
                  (SETQ |bfVar#16| (CDR |bfVar#16|))))
               0 1 |circList| NIL))
      (|sayBrightly|
       (LIST '|%b| |fn| '|%d| '|has| '|%b| |numberUsed| '|%d| '|/ | |n|
             '| values cached|))
      (|displayCacheFrequency| (|mkCircularCountAlist| |circList| |n|))
      (TERPRI)))))

; displayCacheFrequency al ==
;   al := NREVERSE SORTBY('CAR,al)
;   sayBrightlyNT "    #hits/#occurrences: "
;   for [a,:b] in al repeat sayBrightlyNT [a,"/",b,"  "]
;   TERPRI()

(DEFUN |displayCacheFrequency| (|al|)
  (PROG (|a| |b|)
    (RETURN
     (PROGN
      (SETQ |al| (NREVERSE (SORTBY 'CAR |al|)))
      (|sayBrightlyNT| '|    #hits/#occurrences: |)
      ((LAMBDA (|bfVar#19| |bfVar#18|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#19|)
                (PROGN (SETQ |bfVar#18| (CAR |bfVar#19|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#18|)
                 (PROGN
                  (SETQ |a| (CAR |bfVar#18|))
                  (SETQ |b| (CDR |bfVar#18|))
                  #1#)
                 (|sayBrightlyNT| (LIST |a| '/ |b| '|  |)))))
          (SETQ |bfVar#19| (CDR |bfVar#19|))))
       |al| NIL)
      (TERPRI)))))

; mkCircularCountAlist(cl,len) ==
;   for [x,count,:.] in cl for i in 1..len while x ~= '_$failed repeat
;     u:= assoc(count,al) => RPLACD(u,1 + CDR u)
;     if INTEGERP $reportFavoritesIfNumber and count >= $reportFavoritesIfNumber then
;       sayBrightlyNT ["   ",count,"  "]
;       pp x
;     al:= [[count,:1],:al]
;   al

(DEFUN |mkCircularCountAlist| (|cl| |len|)
  (PROG (|x| |ISTMP#1| |count| |u| |al|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#21| |bfVar#20| |i|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#21|)
                (PROGN (SETQ |bfVar#20| (CAR |bfVar#21|)) NIL) (> |i| |len|)
                (EQ |x| '|$failed|))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#20|)
                 (PROGN
                  (SETQ |x| (CAR |bfVar#20|))
                  (SETQ |ISTMP#1| (CDR |bfVar#20|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |count| (CAR |ISTMP#1|)) #1#)))
                 (COND
                  ((SETQ |u| (|assoc| |count| |al|))
                   (RPLACD |u| (+ 1 (CDR |u|))))
                  (#1#
                   (PROGN
                    (COND
                     ((AND (INTEGERP |$reportFavoritesIfNumber|)
                           (NOT (< |count| |$reportFavoritesIfNumber|)))
                      (|sayBrightlyNT| (LIST '|   | |count| '|  |))
                      (|pp| |x|)))
                    (SETQ |al| (CONS (CONS |count| 1) |al|))))))))
          (SETQ |bfVar#21| (CDR |bfVar#21|))
          (SETQ |i| (+ |i| 1))))
       |cl| NIL 1)
      |al|))))

; reportHashCacheStats fn ==
;   infovec := GET(fn, 'cacheInfo)
;   hashTable:= eval infovec.cacheName
;   hashValues:= [HGET(hashTable,key) for key in HKEYS hashTable]
;   sayBrightly [:bright fn,'"has",:bright(# hashValues),'"values cached."]
;   displayCacheFrequency mkHashCountAlist hashValues
;   TERPRI()

(DEFUN |reportHashCacheStats| (|fn|)
  (PROG (|infovec| |hashTable| |hashValues|)
    (RETURN
     (PROGN
      (SETQ |infovec| (GET |fn| '|cacheInfo|))
      (SETQ |hashTable| (|eval| (CADR |infovec|)))
      (SETQ |hashValues|
              ((LAMBDA (|bfVar#23| |bfVar#22| |key|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#22|)
                        (PROGN (SETQ |key| (CAR |bfVar#22|)) NIL))
                    (RETURN (NREVERSE |bfVar#23|)))
                   ('T
                    (SETQ |bfVar#23|
                            (CONS (HGET |hashTable| |key|) |bfVar#23|))))
                  (SETQ |bfVar#22| (CDR |bfVar#22|))))
               NIL (HKEYS |hashTable|) NIL))
      (|sayBrightly|
       (APPEND (|bright| |fn|)
               (CONS "has"
                     (APPEND (|bright| (LENGTH |hashValues|))
                             (CONS "values cached." NIL)))))
      (|displayCacheFrequency| (|mkHashCountAlist| |hashValues|))
      (TERPRI)))))

; mkHashCountAlist vl ==
;   for [count,:.] in vl repeat
;     u:= assoc(count,al) => RPLACD(u,1 + CDR u)
;     al:= [[count,:1],:al]
;   al

(DEFUN |mkHashCountAlist| (|vl|)
  (PROG (|count| |u| |al|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#25| |bfVar#24|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#25|)
                (PROGN (SETQ |bfVar#24| (CAR |bfVar#25|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#24|) (PROGN (SETQ |count| (CAR |bfVar#24|)) #1#)
                 (COND
                  ((SETQ |u| (|assoc| |count| |al|))
                   (RPLACD |u| (+ 1 (CDR |u|))))
                  (#1# (SETQ |al| (CONS (CONS |count| 1) |al|)))))))
          (SETQ |bfVar#25| (CDR |bfVar#25|))))
       |vl| NIL)
      |al|))))

; clearHashReferenceCounts() == BREAK()

(DEFUN |clearHashReferenceCounts| () (PROG () (RETURN (BREAK))))

; remHashEntriesWith0Count $hashTable == BREAK()

(DEFUN |remHashEntriesWith0Count| (|$hashTable|)
  (DECLARE (SPECIAL |$hashTable|))
  (PROG () (RETURN (BREAK))))

; initCache n ==
;   tail:= '(0 . $failed)
;   l:= [[$failed,:tail] for i in 1..n]
;   RPLACD(LASTNODE l,l)

(DEFUN |initCache| (|n|)
  (PROG (|tail| |l|)
    (RETURN
     (PROGN
      (SETQ |tail| '(0 . |$failed|))
      (SETQ |l|
              ((LAMBDA (|bfVar#26| |i|)
                 (LOOP
                  (COND ((> |i| |n|) (RETURN (NREVERSE |bfVar#26|)))
                        ('T
                         (SETQ |bfVar#26|
                                 (CONS (CONS |$failed| |tail|) |bfVar#26|))))
                  (SETQ |i| (+ |i| 1))))
               NIL 1))
      (RPLACD (LASTNODE |l|) |l|)))))

; assocCache(x,cacheName,fn) ==
;   --fn=equality function; do not SHIFT or COUNT
;   al:= eval cacheName
;   forwardPointer:= al
;   val:= nil
;   until EQ(forwardPointer,al) repeat
;     FUNCALL(fn, CAAR forwardPointer, x) =>
;         return (val := first forwardPointer)
;     backPointer:= forwardPointer
;     forwardPointer := rest forwardPointer
;   val => val
;   SET(cacheName,backPointer)
;   nil

(DEFUN |assocCache| (|x| |cacheName| |fn|)
  (PROG (|al| |forwardPointer| |val| |backPointer|)
    (RETURN
     (PROGN
      (SETQ |al| (|eval| |cacheName|))
      (SETQ |forwardPointer| |al|)
      (SETQ |val| NIL)
      ((LAMBDA (|bfVar#27|)
         (LOOP
          (COND (|bfVar#27| (RETURN NIL))
                (#1='T
                 (COND
                  ((FUNCALL |fn| (CAAR |forwardPointer|) |x|)
                   (RETURN (SETQ |val| (CAR |forwardPointer|))))
                  (#1#
                   (PROGN
                    (SETQ |backPointer| |forwardPointer|)
                    (SETQ |forwardPointer| (CDR |forwardPointer|)))))))
          (SETQ |bfVar#27| (EQ |forwardPointer| |al|))))
       NIL)
      (COND (|val| |val|) (#1# (PROGN (SET |cacheName| |backPointer|) NIL)))))))

; assocCacheShift(x,cacheName,fn) ==  --like ASSOC except that al is circular
;   --fn=equality function; SHIFT but do not COUNT
;   al:= eval cacheName
;   forwardPointer:= al
;   val:= nil
;   until EQ(forwardPointer,al) repeat
;     FUNCALL(fn, first(y := first forwardPointer), x) =>
;       if not EQ(forwardPointer,al) then   --shift referenced entry to front
;         RPLACA(forwardPointer, first al)
;         RPLACA(al,y)
;       return (val:= y)
;     backPointer := forwardPointer      -- first is slot replaced on failure
;     forwardPointer := rest forwardPointer
;   val => val
;   SET(cacheName,backPointer)
;   nil

(DEFUN |assocCacheShift| (|x| |cacheName| |fn|)
  (PROG (|al| |forwardPointer| |val| |y| |backPointer|)
    (RETURN
     (PROGN
      (SETQ |al| (|eval| |cacheName|))
      (SETQ |forwardPointer| |al|)
      (SETQ |val| NIL)
      ((LAMBDA (|bfVar#28|)
         (LOOP
          (COND (|bfVar#28| (RETURN NIL))
                (#1='T
                 (COND
                  ((FUNCALL |fn| (CAR (SETQ |y| (CAR |forwardPointer|))) |x|)
                   (PROGN
                    (COND
                     ((NULL (EQ |forwardPointer| |al|))
                      (RPLACA |forwardPointer| (CAR |al|)) (RPLACA |al| |y|)))
                    (RETURN (SETQ |val| |y|))))
                  (#1#
                   (PROGN
                    (SETQ |backPointer| |forwardPointer|)
                    (SETQ |forwardPointer| (CDR |forwardPointer|)))))))
          (SETQ |bfVar#28| (EQ |forwardPointer| |al|))))
       NIL)
      (COND (|val| |val|) (#1# (PROGN (SET |cacheName| |backPointer|) NIL)))))))

; assocCacheShiftCount(x,al,fn) ==
;   -- if x is found, entry containing x becomes first element of list; if
;   -- x is not found, entry with smallest use count is shifted to front so
;   -- as to be replaced
;   --fn=equality function; COUNT and SHIFT
;   forwardPointer:= al
;   val:= nil
;   minCount:= 10000 --preset minCount but not newFrontPointer here
;   until EQ(forwardPointer,al) repeat
;     FUNCALL(fn, first(y := first forwardPointer), x) =>
;       newFrontPointer := forwardPointer
;       rplac(CADR y, inc_SI CADR y)         --increment use count
;       return (val:= y)
;     if less_SI(c := CADR y, minCount) then --initial c is 1 so is true 1st time
;       minCount := c
;       newFrontPointer := forwardPointer   -- first is slot replaced on failure
;     forwardPointer:= rest forwardPointer
;   if not EQ(newFrontPointer,al) then       --shift referenced entry to front
;     temp := first newFrontPointer             --or entry with smallest count
;     RPLACA(newFrontPointer, first al)
;     RPLACA(al,temp)
;   val

(DEFUN |assocCacheShiftCount| (|x| |al| |fn|)
  (PROG (|forwardPointer| |val| |minCount| |y| |newFrontPointer| |c| |temp|)
    (RETURN
     (PROGN
      (SETQ |forwardPointer| |al|)
      (SETQ |val| NIL)
      (SETQ |minCount| 10000)
      ((LAMBDA (|bfVar#29|)
         (LOOP
          (COND (|bfVar#29| (RETURN NIL))
                (#1='T
                 (COND
                  ((FUNCALL |fn| (CAR (SETQ |y| (CAR |forwardPointer|))) |x|)
                   (PROGN
                    (SETQ |newFrontPointer| |forwardPointer|)
                    (|rplac| (CADR |y|) (|inc_SI| (CADR |y|)))
                    (RETURN (SETQ |val| |y|))))
                  (#1#
                   (PROGN
                    (COND
                     ((|less_SI| (SETQ |c| (CADR |y|)) |minCount|)
                      (SETQ |minCount| |c|)
                      (SETQ |newFrontPointer| |forwardPointer|)))
                    (SETQ |forwardPointer| (CDR |forwardPointer|)))))))
          (SETQ |bfVar#29| (EQ |forwardPointer| |al|))))
       NIL)
      (COND
       ((NULL (EQ |newFrontPointer| |al|))
        (SETQ |temp| (CAR |newFrontPointer|))
        (RPLACA |newFrontPointer| (CAR |al|)) (RPLACA |al| |temp|)))
      |val|))))

; clamStats() ==
;   for [op,kind,:.] in $clamList repeat
;     cacheVec := GET(op, 'cacheInfo) or systemErrorHere "clamStats"
;     prefix:=
;       $reportCounts~= true => nil
;       hitCounter := INTERNL1(op, '";hit")
;       callCounter := INTERNL1(op, '";calls")
;       res:= ["%b",eval hitCounter,"/",eval callCounter,"%d","calls to "]
;       SET(hitCounter,0)
;       SET(callCounter,0)
;       res
;     postString:=
;       cacheValue:= eval cacheVec.cacheName
;       kind = 'hash => [" (","%b",HASH_-TABLE_-COUNT cacheValue,"%d","entries)"]
;       empties:= numberOfEmptySlots eval cacheVec.cacheName
;       empties = 0 => nil
;       [" (","%b",kind-empties,"/",kind,"%d","slots used)"]
;     sayBrightly
;       [:prefix,op,:postString]

(DEFUN |clamStats| ()
  (PROG (|postString| |empties| |cacheValue| |prefix| |res| |callCounter|
         |hitCounter| |cacheVec| |kind| |ISTMP#1| |op|)
    (RETURN
     ((LAMBDA (|bfVar#31| |bfVar#30|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#31|)
               (PROGN (SETQ |bfVar#30| (CAR |bfVar#31|)) NIL))
           (RETURN NIL))
          (#1='T
           (AND (CONSP |bfVar#30|)
                (PROGN
                 (SETQ |op| (CAR |bfVar#30|))
                 (SETQ |ISTMP#1| (CDR |bfVar#30|))
                 (AND (CONSP |ISTMP#1|)
                      (PROGN (SETQ |kind| (CAR |ISTMP#1|)) #1#)))
                (PROGN
                 (SETQ |cacheVec|
                         (OR (GET |op| '|cacheInfo|)
                             (|systemErrorHere| '|clamStats|)))
                 (SETQ |prefix|
                         (COND ((NOT (EQUAL |$reportCounts| T)) NIL)
                               (#1#
                                (PROGN
                                 (SETQ |hitCounter| (INTERNL1 |op| ";hit"))
                                 (SETQ |callCounter| (INTERNL1 |op| ";calls"))
                                 (SETQ |res|
                                         (LIST '|%b| (|eval| |hitCounter|) '/
                                               (|eval| |callCounter|) '|%d|
                                               '|calls to |))
                                 (SET |hitCounter| 0)
                                 (SET |callCounter| 0)
                                 |res|))))
                 (SETQ |postString|
                         (PROGN
                          (SETQ |cacheValue| (|eval| (CADR |cacheVec|)))
                          (COND
                           ((EQ |kind| '|hash|)
                            (LIST '| (| '|%b| (HASH-TABLE-COUNT |cacheValue|)
                                  '|%d| '|entries)|))
                           (#1#
                            (PROGN
                             (SETQ |empties|
                                     (|numberOfEmptySlots|
                                      (|eval| (CADR |cacheVec|))))
                             (COND ((EQL |empties| 0) NIL)
                                   (#1#
                                    (LIST '| (| '|%b| (- |kind| |empties|) '/
                                          |kind| '|%d| '|slots used)|))))))))
                 (|sayBrightly| (APPEND |prefix| (CONS |op| |postString|)))))))
         (SETQ |bfVar#31| (CDR |bfVar#31|))))
      |$clamList| NIL))))

; numberOfEmptySlots cache==
;   count:= (CAAR cache ='$failed => 1; 0)
;   for x in tails rest cache while not(EQ(x, cache)) repeat
;     if CAAR x='$failed then count:= count+1
;   count

(DEFUN |numberOfEmptySlots| (|cache|)
  (PROG (|count|)
    (RETURN
     (PROGN
      (SETQ |count| (COND ((EQ (CAAR |cache|) '|$failed|) 1) (#1='T 0)))
      ((LAMBDA (|x|)
         (LOOP
          (COND ((OR (ATOM |x|) (EQ |x| |cache|)) (RETURN NIL))
                (#1#
                 (COND
                  ((EQ (CAAR |x|) '|$failed|) (SETQ |count| (+ |count| 1))))))
          (SETQ |x| (CDR |x|))))
       (CDR |cache|))
      |count|))))

; addToConstructorCache(op,args,value) ==
;   ['haddProp,'$ConstructorCache,MKQ op,args,['CONS,1,value]]

(DEFUN |addToConstructorCache| (|op| |args| |value|)
  (PROG ()
    (RETURN
     (LIST '|haddProp| '|$ConstructorCache| (MKQ |op|) |args|
           (LIST 'CONS 1 |value|)))))

; haddProp(ht,op,prop,val) ==
;   --called inside functors (except for union and record types ??)
;   --presently, ht always = $ConstructorCache
;   statRecordInstantiationEvent()
;   if $reportInstantiations = true or $reportEachInstantiation = true then
;     startTimingProcess 'debug
;     recordInstantiation(op,prop,false)
;     stopTimingProcess 'debug
;   u:= HGET(ht,op) =>     --hope that one exists most of the time
;     assoc(prop,u) => val     --value is already there--must = val; exit now
;     RPLACD(u, [first u, :rest u])
;     RPLACA(u,[prop,:val])
;     $op: local := op
;     listTruncate(u,20)        --save at most 20 instantiations
;     val
;   HPUT(ht,op,[[prop,:val]])
;   val

(DEFUN |haddProp| (|ht| |op| |prop| |val|)
  (PROG (|$op| |u|)
    (DECLARE (SPECIAL |$op|))
    (RETURN
     (PROGN
      (|statRecordInstantiationEvent|)
      (COND
       ((OR (EQUAL |$reportInstantiations| T)
            (EQUAL |$reportEachInstantiation| T))
        (|startTimingProcess| '|debug|) (|recordInstantiation| |op| |prop| NIL)
        (|stopTimingProcess| '|debug|)))
      (COND
       ((SETQ |u| (HGET |ht| |op|))
        (COND ((|assoc| |prop| |u|) |val|)
              (#1='T
               (PROGN
                (RPLACD |u| (CONS (CAR |u|) (CDR |u|)))
                (RPLACA |u| (CONS |prop| |val|))
                (SETQ |$op| |op|)
                (|listTruncate| |u| 20)
                |val|))))
       (#1# (PROGN (HPUT |ht| |op| (LIST (CONS |prop| |val|))) |val|)))))))

; recordInstantiation(op,prop,dropIfTrue) ==
;   startTimingProcess 'debug
;   recordInstantiation1(op,prop,dropIfTrue)
;   stopTimingProcess 'debug

(DEFUN |recordInstantiation| (|op| |prop| |dropIfTrue|)
  (PROG ()
    (RETURN
     (PROGN
      (|startTimingProcess| '|debug|)
      (|recordInstantiation1| |op| |prop| |dropIfTrue|)
      (|stopTimingProcess| '|debug|)))))

; recordInstantiation1(op,prop,dropIfTrue) ==
;   op in '(RepeatedSquaring) => nil--ignore defaults for now
;   if $reportEachInstantiation = true then
;     trailer:= (dropIfTrue => '"  dropped"; '"  instantiated")
;     if $insideCoerceInteractive= true then
;       $instantCoerceCount:= 1+$instantCoerceCount
;     if $insideCanCoerceFrom is [m1,m2] and null dropIfTrue then
;       $instantCanCoerceCount:= 1+$instantCanCoerceCount
;       xtra:=
;         ['" for ",outputDomainConstructor m1,'"-->",outputDomainConstructor m2]
;     if $insideEvalMmCondIfTrue = true and null dropIfTrue then
;       $instantMmCondCount:= $instantMmCondCount + 1
;     typeTimePrin ["CONCAT",outputDomainConstructor [op,:prop],trailer,:xtra]
;   null $reportInstantiations => nil
;   u:= HGET($instantRecord,op) =>     --hope that one exists most of the time
;     v := LASSOC(prop,u) =>
;       dropIfTrue => (rplac(CDR v, 1 + CDR v); v)
;       rplac(first v, 1 + first v)
;       v
;     RPLACD(u, [first u, :rest u])
;     val :=
;       dropIfTrue => [0,:1]
;       [1,:0]
;     RPLACA(u,[prop,:val])
;   val :=
;     dropIfTrue => [0,:1]
;     [1,:0]
;   HPUT($instantRecord,op,[[prop,:val]])

(DEFUN |recordInstantiation1| (|op| |prop| |dropIfTrue|)
  (PROG (|trailer| |m1| |ISTMP#1| |m2| |xtra| |u| |v| |val|)
    (RETURN
     (COND ((|member| |op| '(|RepeatedSquaring|)) NIL)
           (#1='T
            (PROGN
             (COND
              ((EQUAL |$reportEachInstantiation| T)
               (SETQ |trailer|
                       (COND (|dropIfTrue| "  dropped")
                             (#1# "  instantiated")))
               (COND
                ((EQUAL |$insideCoerceInteractive| T)
                 (SETQ |$instantCoerceCount| (+ 1 |$instantCoerceCount|))))
               (COND
                ((AND (CONSP |$insideCanCoerceFrom|)
                      (PROGN
                       (SETQ |m1| (CAR |$insideCanCoerceFrom|))
                       (SETQ |ISTMP#1| (CDR |$insideCanCoerceFrom|))
                       (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                            (PROGN (SETQ |m2| (CAR |ISTMP#1|)) #1#)))
                      (NULL |dropIfTrue|))
                 (SETQ |$instantCanCoerceCount| (+ 1 |$instantCanCoerceCount|))
                 (SETQ |xtra|
                         (LIST " for " (|outputDomainConstructor| |m1|) "-->"
                               (|outputDomainConstructor| |m2|)))))
               (COND
                ((AND (EQUAL |$insideEvalMmCondIfTrue| T) (NULL |dropIfTrue|))
                 (SETQ |$instantMmCondCount| (+ |$instantMmCondCount| 1))))
               (|typeTimePrin|
                (CONS 'CONCAT
                      (CONS (|outputDomainConstructor| (CONS |op| |prop|))
                            (CONS |trailer| |xtra|))))))
             (COND ((NULL |$reportInstantiations|) NIL)
                   ((SETQ |u| (HGET |$instantRecord| |op|))
                    (COND
                     ((SETQ |v| (LASSOC |prop| |u|))
                      (COND
                       (|dropIfTrue|
                        (PROGN (|rplac| (CDR |v|) (+ 1 (CDR |v|))) |v|))
                       (#1# (PROGN (|rplac| (CAR |v|) (+ 1 (CAR |v|))) |v|))))
                     (#1#
                      (PROGN
                       (RPLACD |u| (CONS (CAR |u|) (CDR |u|)))
                       (SETQ |val|
                               (COND (|dropIfTrue| (CONS 0 1))
                                     (#1# (CONS 1 0))))
                       (RPLACA |u| (CONS |prop| |val|))))))
                   (#1#
                    (PROGN
                     (SETQ |val|
                             (COND (|dropIfTrue| (CONS 0 1)) (#1# (CONS 1 0))))
                     (HPUT |$instantRecord| |op|
                           (LIST (CONS |prop| |val|))))))))))))

; reportInstantiations() ==
;   --assumed to be a hashtable with reference counts
;     conList:=
;       [:[[n,m,[key,:argList]] for [argList,n,:m] in HGET($instantRecord,key)]
;         for key in HKEYS $instantRecord]
;     sayBrightly ['"# instantiated/# dropped/domain name",
;       "%l",'"------------------------------------"]
;     nTotal:= mTotal:= rTotal := nForms:= 0
;     for [n,m,form] in NREVERSE SORTBY('CADDR,conList) repeat
;       nTotal:= nTotal+n; mTotal:= mTotal+m
;       if n > 1 then rTotal:= rTotal + n-1
;       nForms:= nForms + 1
;       typeTimePrin ['CONCATB,n,m,outputDomainConstructor form]
;     sayBrightly ["%b",'"Totals:","%d",nTotal,'" instantiated","%l",
;       '"         ",$instantCoerceCount,'" inside coerceInteractive","%l",
;        '"         ",$instantCanCoerceCount,'" inside canCoerceFrom","%l",
;         '"         ",$instantMmCondCount,'" inside evalMmCond","%l",
;          '"         ",rTotal,'" reinstantiated","%l",
;           '"         ",mTotal,'" dropped","%l",
;            '"         ",nForms,'" distinct domains instantiated/dropped"]

(DEFUN |reportInstantiations| ()
  (PROG (|form| |ISTMP#2| |nTotal| |mTotal| |rTotal| |nForms| |conList| |m| |n|
         |ISTMP#1| |argList|)
    (RETURN
     (PROGN
      (SETQ |conList|
              ((LAMBDA (|bfVar#36| |bfVar#35| |key|)
                 (LOOP
                  (COND
                   ((OR (ATOM |bfVar#35|)
                        (PROGN (SETQ |key| (CAR |bfVar#35|)) NIL))
                    (RETURN (NREVERSE |bfVar#36|)))
                   (#1='T
                    (SETQ |bfVar#36|
                            (APPEND
                             (REVERSE
                              ((LAMBDA (|bfVar#34| |bfVar#33| |bfVar#32|)
                                 (LOOP
                                  (COND
                                   ((OR (ATOM |bfVar#33|)
                                        (PROGN
                                         (SETQ |bfVar#32| (CAR |bfVar#33|))
                                         NIL))
                                    (RETURN (NREVERSE |bfVar#34|)))
                                   (#1#
                                    (AND (CONSP |bfVar#32|)
                                         (PROGN
                                          (SETQ |argList| (CAR |bfVar#32|))
                                          (SETQ |ISTMP#1| (CDR |bfVar#32|))
                                          (AND (CONSP |ISTMP#1|)
                                               (PROGN
                                                (SETQ |n| (CAR |ISTMP#1|))
                                                (SETQ |m| (CDR |ISTMP#1|))
                                                #1#)))
                                         (SETQ |bfVar#34|
                                                 (CONS
                                                  (LIST |n| |m|
                                                        (CONS |key| |argList|))
                                                  |bfVar#34|)))))
                                  (SETQ |bfVar#33| (CDR |bfVar#33|))))
                               NIL (HGET |$instantRecord| |key|) NIL))
                             |bfVar#36|))))
                  (SETQ |bfVar#35| (CDR |bfVar#35|))))
               NIL (HKEYS |$instantRecord|) NIL))
      (|sayBrightly|
       (LIST "# instantiated/# dropped/domain name" '|%l|
             "------------------------------------"))
      (SETQ |nTotal| (SETQ |mTotal| (SETQ |rTotal| (SETQ |nForms| 0))))
      ((LAMBDA (|bfVar#38| |bfVar#37|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#38|)
                (PROGN (SETQ |bfVar#37| (CAR |bfVar#38|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#37|)
                 (PROGN
                  (SETQ |n| (CAR |bfVar#37|))
                  (SETQ |ISTMP#1| (CDR |bfVar#37|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |m| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |form| (CAR |ISTMP#2|)) #1#)))))
                 (PROGN
                  (SETQ |nTotal| (+ |nTotal| |n|))
                  (SETQ |mTotal| (+ |mTotal| |m|))
                  (COND ((< 1 |n|) (SETQ |rTotal| (- (+ |rTotal| |n|) 1))))
                  (SETQ |nForms| (+ |nForms| 1))
                  (|typeTimePrin|
                   (LIST 'CONCATB |n| |m|
                         (|outputDomainConstructor| |form|)))))))
          (SETQ |bfVar#38| (CDR |bfVar#38|))))
       (NREVERSE (SORTBY 'CADDR |conList|)) NIL)
      (|sayBrightly|
       (LIST '|%b| "Totals:" '|%d| |nTotal| " instantiated" '|%l| "         "
             |$instantCoerceCount| " inside coerceInteractive" '|%l|
             "         " |$instantCanCoerceCount| " inside canCoerceFrom" '|%l|
             "         " |$instantMmCondCount| " inside evalMmCond" '|%l|
             "         " |rTotal| " reinstantiated" '|%l| "         " |mTotal|
             " dropped" '|%l| "         " |nForms|
             " distinct domains instantiated/dropped"))))))

; listTruncate(l,n) ==
;   u:= l
;   n := dec_SI n
;   while n ~= 0 and null atom u repeat
;       n := dec_SI n
;       u := QCDR u
;   if null atom u then
;     if null atom rest u and $reportInstantiations = true then
;       recordInstantiation($op,CAADR u,true)
;     RPLACD(u,nil)
;   l

(DEFUN |listTruncate| (|l| |n|)
  (PROG (|u|)
    (RETURN
     (PROGN
      (SETQ |u| |l|)
      (SETQ |n| (|dec_SI| |n|))
      ((LAMBDA ()
         (LOOP
          (COND ((NOT (AND (NOT (EQL |n| 0)) (NULL (ATOM |u|)))) (RETURN NIL))
                ('T
                 (PROGN (SETQ |n| (|dec_SI| |n|)) (SETQ |u| (QCDR |u|))))))))
      (COND
       ((NULL (ATOM |u|))
        (COND
         ((AND (NULL (ATOM (CDR |u|))) (EQUAL |$reportInstantiations| T))
          (|recordInstantiation| |$op| (CAADR |u|) T)))
        (RPLACD |u| NIL)))
      |l|))))

; lassocShift(x,l) ==
;   y:= l
;   while not atom y repeat
;     EQUAL(x, first QCAR y) => return (result := QCAR y)
;     y:= QCDR y
;   result =>
;     if not(EQ(y, l)) then
;       QRPLACA(y, first l)
;       QRPLACA(l,result)
;     QCDR result
;   nil

(DEFUN |lassocShift| (|x| |l|)
  (PROG (|y| |result|)
    (RETURN
     (PROGN
      (SETQ |y| |l|)
      ((LAMBDA ()
         (LOOP
          (COND ((ATOM |y|) (RETURN NIL))
                (#1='T
                 (COND
                  ((EQUAL |x| (CAR (QCAR |y|)))
                   (RETURN (SETQ |result| (QCAR |y|))))
                  (#1# (SETQ |y| (QCDR |y|)))))))))
      (COND
       (|result|
        (PROGN
         (COND
          ((NULL (EQ |y| |l|)) (QRPLACA |y| (CAR |l|)) (QRPLACA |l| |result|)))
         (QCDR |result|)))
       (#1# NIL))))))

; lassocShiftWithFunction(x,l,fn) ==
;   y:= l
;   while not atom y repeat
;     FUNCALL(fn, x, first QCAR y) => return (result := QCAR y)
;     y:= QCDR y
;   result =>
;     if not(EQ(y, l)) then
;       QRPLACA(y, first l)
;       QRPLACA(l,result)
;     QCDR result
;   nil

(DEFUN |lassocShiftWithFunction| (|x| |l| |fn|)
  (PROG (|y| |result|)
    (RETURN
     (PROGN
      (SETQ |y| |l|)
      ((LAMBDA ()
         (LOOP
          (COND ((ATOM |y|) (RETURN NIL))
                (#1='T
                 (COND
                  ((FUNCALL |fn| |x| (CAR (QCAR |y|)))
                   (RETURN (SETQ |result| (QCAR |y|))))
                  (#1# (SETQ |y| (QCDR |y|)))))))))
      (COND
       (|result|
        (PROGN
         (COND
          ((NULL (EQ |y| |l|)) (QRPLACA |y| (CAR |l|)) (QRPLACA |l| |result|)))
         (QCDR |result|)))
       (#1# NIL))))))

; globalHashtableStats(x,sortFn) ==
;   --assumed to be a hashtable with reference counts
;   keys:= HKEYS x
;   for key in keys repeat
;     u:= HGET(x,key)
;     for [argList,n,:.] in u repeat
;       not INTEGERP n =>   keyedSystemError("S2GE0013",[x])
;       argList1:= [constructor2ConstructorForm x for x in argList]
;       reportList:= [[n,key,argList1],:reportList]
;   sayBrightly ["%b","  USE  NAME ARGS","%d"]
;   for [n,fn,args] in NREVERSE SORTBY(sortFn,reportList) repeat
;     sayBrightlyNT [:rightJustifyString(n,6),"  ",fn,": "]
;     pp args

(DEFUN |globalHashtableStats| (|x| |sortFn|)
  (PROG (|keys| |u| |argList| |ISTMP#1| |n| |argList1| |reportList| |fn|
         |ISTMP#2| |args|)
    (RETURN
     (PROGN
      (SETQ |keys| (HKEYS |x|))
      ((LAMBDA (|bfVar#39| |key|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#39|) (PROGN (SETQ |key| (CAR |bfVar#39|)) NIL))
            (RETURN NIL))
           (#1='T
            (PROGN
             (SETQ |u| (HGET |x| |key|))
             ((LAMBDA (|bfVar#41| |bfVar#40|)
                (LOOP
                 (COND
                  ((OR (ATOM |bfVar#41|)
                       (PROGN (SETQ |bfVar#40| (CAR |bfVar#41|)) NIL))
                   (RETURN NIL))
                  (#1#
                   (AND (CONSP |bfVar#40|)
                        (PROGN
                         (SETQ |argList| (CAR |bfVar#40|))
                         (SETQ |ISTMP#1| (CDR |bfVar#40|))
                         (AND (CONSP |ISTMP#1|)
                              (PROGN (SETQ |n| (CAR |ISTMP#1|)) #1#)))
                        (COND
                         ((NULL (INTEGERP |n|))
                          (|keyedSystemError| 'S2GE0013 (LIST |x|)))
                         (#1#
                          (PROGN
                           (SETQ |argList1|
                                   ((LAMBDA (|bfVar#43| |bfVar#42| |x|)
                                      (LOOP
                                       (COND
                                        ((OR (ATOM |bfVar#42|)
                                             (PROGN
                                              (SETQ |x| (CAR |bfVar#42|))
                                              NIL))
                                         (RETURN (NREVERSE |bfVar#43|)))
                                        (#1#
                                         (SETQ |bfVar#43|
                                                 (CONS
                                                  (|constructor2ConstructorForm|
                                                   |x|)
                                                  |bfVar#43|))))
                                       (SETQ |bfVar#42| (CDR |bfVar#42|))))
                                    NIL |argList| NIL))
                           (SETQ |reportList|
                                   (CONS (LIST |n| |key| |argList1|)
                                         |reportList|))))))))
                 (SETQ |bfVar#41| (CDR |bfVar#41|))))
              |u| NIL))))
          (SETQ |bfVar#39| (CDR |bfVar#39|))))
       |keys| NIL)
      (|sayBrightly| (LIST '|%b| '|  USE  NAME ARGS| '|%d|))
      ((LAMBDA (|bfVar#45| |bfVar#44|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#45|)
                (PROGN (SETQ |bfVar#44| (CAR |bfVar#45|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#44|)
                 (PROGN
                  (SETQ |n| (CAR |bfVar#44|))
                  (SETQ |ISTMP#1| (CDR |bfVar#44|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |fn| (CAR |ISTMP#1|))
                        (SETQ |ISTMP#2| (CDR |ISTMP#1|))
                        (AND (CONSP |ISTMP#2|) (EQ (CDR |ISTMP#2|) NIL)
                             (PROGN (SETQ |args| (CAR |ISTMP#2|)) #1#)))))
                 (PROGN
                  (|sayBrightlyNT|
                   (APPEND (|rightJustifyString| |n| 6)
                           (CONS '|  | (CONS |fn| (CONS '|: | NIL)))))
                  (|pp| |args|)))))
          (SETQ |bfVar#45| (CDR |bfVar#45|))))
       (NREVERSE (SORTBY |sortFn| |reportList|)) NIL)))))

; constructor2ConstructorForm x ==
;   VECP x => x.0
;   x

(DEFUN |constructor2ConstructorForm| (|x|)
  (PROG () (RETURN (COND ((VECP |x|) (ELT |x| 0)) ('T |x|)))))

; rightJustifyString(x,maxWidth) ==
;   size:= entryWidth x
;   size > maxWidth => keyedSystemError("S2GE0014",[x])
;   [fillerSpaces(maxWidth-size,'" "),x]

(DEFUN |rightJustifyString| (|x| |maxWidth|)
  (PROG (SIZE)
    (RETURN
     (PROGN
      (SETQ SIZE (|entryWidth| |x|))
      (COND ((< |maxWidth| SIZE) (|keyedSystemError| 'S2GE0014 (LIST |x|)))
            ('T (LIST (|fillerSpaces| (- |maxWidth| SIZE) " ") |x|)))))))

; domainEqualList(argl1, argl2) == EQUAL(argl1, argl2)

(DEFUN |domainEqualList| (|argl1| |argl2|)
  (PROG () (RETURN (EQUAL |argl1| |argl2|))))

; removeAllClams() ==
;   for [fun,:.] in $clamList repeat
;     sayBrightly ['"Un-clamming function",'%b,fun,'%d]
;     SET(fun,eval INTERN STRCONC(STRINGIMAGE fun,'";"))

(DEFUN |removeAllClams| ()
  (PROG (|fun|)
    (RETURN
     ((LAMBDA (|bfVar#47| |bfVar#46|)
        (LOOP
         (COND
          ((OR (ATOM |bfVar#47|)
               (PROGN (SETQ |bfVar#46| (CAR |bfVar#47|)) NIL))
           (RETURN NIL))
          (#1='T
           (AND (CONSP |bfVar#46|) (PROGN (SETQ |fun| (CAR |bfVar#46|)) #1#)
                (PROGN
                 (|sayBrightly|
                  (LIST "Un-clamming function" '|%b| |fun| '|%d|))
                 (SET |fun|
                      (|eval| (INTERN (STRCONC (STRINGIMAGE |fun|) ";"))))))))
         (SETQ |bfVar#47| (CDR |bfVar#47|))))
      |$clamList| NIL))))

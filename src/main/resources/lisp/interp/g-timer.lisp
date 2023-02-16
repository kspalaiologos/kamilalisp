
; )package "BOOT"

(IN-PACKAGE "BOOT")

; makeLongStatStringByProperty _
;  (listofnames, listofclasses, property, classproperty, units, flag) ==
;   total := 0
;   str := '""
;   otherStatTotal := GET('other, property)
;   for [name,class,:ab] in listofnames repeat
;     name = 'other => 'iterate
;     cl := first LASSOC(class, listofclasses)
;     n := GET(name, property)
;     PUT(cl, classproperty, n + GET(cl, classproperty))
;     total := total + n
;     if n >= 0.01
;       then timestr := normalizeStatAndStringify n
;       else
;         timestr := '""
;         otherStatTotal := otherStatTotal + n
;     str := makeStatString(str,timestr,ab,flag)
;   otherStatTotal := otherStatTotal
;   PUT('other, property, otherStatTotal)
;   if otherStatTotal > 0 then
;     str := makeStatString(str,normalizeStatAndStringify otherStatTotal,'O,flag)
;     total := total + otherStatTotal
;     cl := first LASSOC('other, listofnames)
;     cl := first LASSOC(cl, listofclasses)
;     PUT(cl, classproperty, otherStatTotal + GET(cl, classproperty))
;   if flag ~= 'long then
;     total := 0
;     str := '""
;     for [class,name,:ab] in listofclasses repeat
;       n := GET(name, classproperty)
;       n = 0.0 => 'iterate
;       total := total + n
;       timestr := normalizeStatAndStringify n
;       str := makeStatString(str,timestr,ab,flag)
;   total := STRCONC(normalizeStatAndStringify total,'" ", units)
;   str = '"" =>  total
;   STRCONC(str, '" = ", total)

(DEFUN |makeLongStatStringByProperty|
       (|listofnames| |listofclasses| |property| |classproperty| |units|
        |flag|)
  (PROG (|total| |str| |otherStatTotal| |name| |ISTMP#1| |class| |ab| |cl| |n|
         |timestr|)
    (RETURN
     (PROGN
      (SETQ |total| 0)
      (SETQ |str| "")
      (SETQ |otherStatTotal| (GET '|other| |property|))
      ((LAMBDA (|bfVar#2| |bfVar#1|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#2|) (PROGN (SETQ |bfVar#1| (CAR |bfVar#2|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#1|)
                 (PROGN
                  (SETQ |name| (CAR |bfVar#1|))
                  (SETQ |ISTMP#1| (CDR |bfVar#1|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN
                        (SETQ |class| (CAR |ISTMP#1|))
                        (SETQ |ab| (CDR |ISTMP#1|))
                        #1#)))
                 (COND ((EQ |name| '|other|) '|iterate|)
                       (#1#
                        (PROGN
                         (SETQ |cl| (CAR (LASSOC |class| |listofclasses|)))
                         (SETQ |n| (GET |name| |property|))
                         (PUT |cl| |classproperty|
                          (+ |n| (GET |cl| |classproperty|)))
                         (SETQ |total| (+ |total| |n|))
                         (COND
                          ((NOT (< |n| 0.01))
                           (SETQ |timestr| (|normalizeStatAndStringify| |n|)))
                          (#1# (SETQ |timestr| "")
                           (SETQ |otherStatTotal| (+ |otherStatTotal| |n|))))
                         (SETQ |str|
                                 (|makeStatString| |str| |timestr| |ab|
                                  |flag|))))))))
          (SETQ |bfVar#2| (CDR |bfVar#2|))))
       |listofnames| NIL)
      (SETQ |otherStatTotal| |otherStatTotal|)
      (PUT '|other| |property| |otherStatTotal|)
      (COND
       ((< 0 |otherStatTotal|)
        (SETQ |str|
                (|makeStatString| |str|
                 (|normalizeStatAndStringify| |otherStatTotal|) 'O |flag|))
        (SETQ |total| (+ |total| |otherStatTotal|))
        (SETQ |cl| (CAR (LASSOC '|other| |listofnames|)))
        (SETQ |cl| (CAR (LASSOC |cl| |listofclasses|)))
        (PUT |cl| |classproperty|
         (+ |otherStatTotal| (GET |cl| |classproperty|)))))
      (COND
       ((NOT (EQ |flag| '|long|)) (SETQ |total| 0) (SETQ |str| "")
        ((LAMBDA (|bfVar#4| |bfVar#3|)
           (LOOP
            (COND
             ((OR (ATOM |bfVar#4|)
                  (PROGN (SETQ |bfVar#3| (CAR |bfVar#4|)) NIL))
              (RETURN NIL))
             (#1#
              (AND (CONSP |bfVar#3|)
                   (PROGN
                    (SETQ |class| (CAR |bfVar#3|))
                    (SETQ |ISTMP#1| (CDR |bfVar#3|))
                    (AND (CONSP |ISTMP#1|)
                         (PROGN
                          (SETQ |name| (CAR |ISTMP#1|))
                          (SETQ |ab| (CDR |ISTMP#1|))
                          #1#)))
                   (PROGN
                    (SETQ |n| (GET |name| |classproperty|))
                    (COND ((EQUAL |n| 0.0) '|iterate|)
                          (#1#
                           (PROGN
                            (SETQ |total| (+ |total| |n|))
                            (SETQ |timestr| (|normalizeStatAndStringify| |n|))
                            (SETQ |str|
                                    (|makeStatString| |str| |timestr| |ab|
                                     |flag|)))))))))
            (SETQ |bfVar#4| (CDR |bfVar#4|))))
         |listofclasses| NIL)))
      (SETQ |total|
              (STRCONC (|normalizeStatAndStringify| |total|) " " |units|))
      (COND ((EQUAL |str| "") |total|) (#1# (STRCONC |str| " = " |total|)))))))

; normalizeStatAndStringify t ==
;   FLOATP t =>
;       t := roundStat t
;       t = 0.0 => '"0"
;       FORMAT(nil,'"~,2F",t)
;   INTEGERP t =>
;       K := 1024
;       M := K*K
;       t > 9*M => CONCAT(STRINGIMAGE((t + 512*K)/M), '"M")
;       t > 9*K => CONCAT(STRINGIMAGE((t + 512)/K),   '"K")
;       STRINGIMAGE t
;   STRINGIMAGE t

(DEFUN |normalizeStatAndStringify| (|t|)
  (PROG (K M)
    (RETURN
     (COND
      ((FLOATP |t|)
       (PROGN
        (SETQ |t| (|roundStat| |t|))
        (COND ((EQUAL |t| 0.0) "0") (#1='T (FORMAT NIL "~,2F" |t|)))))
      ((INTEGERP |t|)
       (PROGN
        (SETQ K 1024)
        (SETQ M (* K K))
        (COND
         ((< (* 9 M) |t|) (CONCAT (STRINGIMAGE (/ (+ |t| (* 512 K)) M)) "M"))
         ((< (* 9 K) |t|) (CONCAT (STRINGIMAGE (/ (+ |t| 512) K)) "K"))
         (#1# (STRINGIMAGE |t|)))))
      (#1# (STRINGIMAGE |t|))))))

; significantStat t ==
;    FLOATP t => (t > 0.01)
;    INTEGERP  t => (t > 100)
;    true

(DEFUN |significantStat| (|t|)
  (PROG ()
    (RETURN
     (COND ((FLOATP |t|) (< 0.01 |t|)) ((INTEGERP |t|) (< 100 |t|)) ('T T)))))

; roundStat t ==
;   not FLOATP t => t
;   (TRUNCATE (0.5 + t * 1000.0)) / 1000.0

(DEFUN |roundStat| (|t|)
  (PROG ()
    (RETURN
     (COND ((NULL (FLOATP |t|)) |t|)
           ('T (/ (TRUNCATE (+ 0.5 (* |t| 1000.0))) 1000.0))))))

; makeStatString(oldstr,time,abb,flag) ==
;   time = '"" => oldstr
;   opening := (flag = 'long => '"("; '" (")
;   oldstr = '"" => STRCONC(time,opening,abb,'")")
;   STRCONC(oldstr,'" + ",time,opening,abb,'")")

(DEFUN |makeStatString| (|oldstr| |time| |abb| |flag|)
  (PROG (|opening|)
    (RETURN
     (COND ((EQUAL |time| "") |oldstr|)
           (#1='T
            (PROGN
             (SETQ |opening| (COND ((EQ |flag| '|long|) "(") (#1# " (")))
             (COND ((EQUAL |oldstr| "") (STRCONC |time| |opening| |abb| ")"))
                   (#1#
                    (STRCONC |oldstr| " + " |time| |opening| |abb| ")")))))))))

; peekTimedName() == IFCAR $timedNameStack

(DEFUN |peekTimedName| () (PROG () (RETURN (IFCAR |$timedNameStack|))))

; popTimedName() ==
;   name := IFCAR $timedNameStack
;   $timedNameStack := IFCDR $timedNameStack
;   name

(DEFUN |popTimedName| ()
  (PROG (|name|)
    (RETURN
     (PROGN
      (SETQ |name| (IFCAR |$timedNameStack|))
      (SETQ |$timedNameStack| (IFCDR |$timedNameStack|))
      |name|))))

; pushTimedName name ==
;   PUSH(name,$timedNameStack)

(DEFUN |pushTimedName| (|name|)
  (PROG () (RETURN (PUSH |name| |$timedNameStack|))))

; startTimingProcess name ==
;   updateTimedName peekTimedName()
;   pushTimedName name
;   if EQ(name, 'load) then          statRecordLoadEvent()

(DEFUN |startTimingProcess| (|name|)
  (PROG ()
    (RETURN
     (PROGN
      (|updateTimedName| (|peekTimedName|))
      (|pushTimedName| |name|)
      (COND ((EQ |name| '|load|) (|statRecordLoadEvent|)))))))

; stopTimingProcess name ==
;   (name ~= peekTimedName()) and null $InteractiveMode =>
;     keyedSystemError("S2GL0015",[name,peekTimedName()])
;   updateTimedName peekTimedName()
;   popTimedName()

(DEFUN |stopTimingProcess| (|name|)
  (PROG ()
    (RETURN
     (COND
      ((AND (NOT (EQUAL |name| (|peekTimedName|))) (NULL |$InteractiveMode|))
       (|keyedSystemError| 'S2GL0015 (LIST |name| (|peekTimedName|))))
      ('T (PROGN (|updateTimedName| (|peekTimedName|)) (|popTimedName|)))))))

; DEFPARAMETER($oldElapsedSpace, 0)

(DEFPARAMETER |$oldElapsedSpace| 0)

; DEFPARAMETER($oldElapsedGCTime, 0.0)

(DEFPARAMETER |$oldElapsedGCTime| 0.0)

; DEFPARAMETER($oldElapsedTime, 0.0)

(DEFPARAMETER |$oldElapsedTime| 0.0)

; DEFPARAMETER($gcTimeTotal, 0.0)

(DEFPARAMETER |$gcTimeTotal| 0.0)

; DEFPARAMETER($timedNameStack, '(other))

(DEFPARAMETER |$timedNameStack| '(|other|))

; DEFPARAMETER($interpreterTimedNames, '(
; -- name         class abbrev
;   (algebra        2 .   B) _
;   (analysis       1 .   A) _
;   (coercion       1 .   C) _
;   (compilation    3 .   T) _
;   (debug          3 .   D) _
;   (evaluation     2 .   E) _
;   (gc             4 .   G) _
;   (history        3 .   H) _
;   (instantiation  3 .   I) _
;   (load           3 .   L) _
;   (modemaps       1 .   M) _
;   (optimization   3 .   Z) _
;   (querycoerce    1 .   Q) _
;   (other          3 .   O) _
;   (diskread       3 .   K) _
;   (resolve        1 .   R) _
;   ))

(DEFPARAMETER |$interpreterTimedNames|
  '((|algebra| 2 . B) (|analysis| 1 . A) (|coercion| 1 . C)
    (|compilation| 3 . T) (|debug| 3 . D) (|evaluation| 2 . E) (|gc| 4 . G)
    (|history| 3 . H) (|instantiation| 3 . I) (|load| 3 . L) (|modemaps| 1 . M)
    (|optimization| 3 . Z) (|querycoerce| 1 . Q) (|other| 3 . O)
    (|diskread| 3 . K) (|resolve| 1 . R)))

; DEFPARAMETER($interpreterTimedClasses, '(
; -- number class name    short name
;   ( 1    interpreter     .  IN) _
;   ( 2    evaluation      .  EV) _
;   ( 3    other           .  OT) _
;   ( 4    reclaim         .  GC) _
;   ))

(DEFPARAMETER |$interpreterTimedClasses|
  '((1 |interpreter| . IN) (2 |evaluation| . EV) (3 |other| . OT)
    (4 |reclaim| . GC)))

; initializeTimedNames(listofnames,listofclasses) ==
;   for [name,:.] in listofnames repeat
;     PUT(name, 'TimeTotal, 0.0)
;     PUT(name, 'SpaceTotal,  0)
;   for [.,name,:.] in listofclasses repeat
;     PUT( name, 'ClassTimeTotal, 0.0)
;     PUT( name, 'ClassSpaceTotal,  0)
;   $timedNameStack := '(other)
;   computeElapsedTime()
;   PUT('gc, 'TimeTotal, 0.0)
;   PUT('gc, 'SpaceTotal,  0)
;   NIL

(DEFUN |initializeTimedNames| (|listofnames| |listofclasses|)
  (PROG (|name| |ISTMP#1|)
    (RETURN
     (PROGN
      ((LAMBDA (|bfVar#6| |bfVar#5|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#6|) (PROGN (SETQ |bfVar#5| (CAR |bfVar#6|)) NIL))
            (RETURN NIL))
           (#1='T
            (AND (CONSP |bfVar#5|) (PROGN (SETQ |name| (CAR |bfVar#5|)) #1#)
                 (PROGN
                  (PUT |name| '|TimeTotal| 0.0)
                  (PUT |name| '|SpaceTotal| 0)))))
          (SETQ |bfVar#6| (CDR |bfVar#6|))))
       |listofnames| NIL)
      ((LAMBDA (|bfVar#8| |bfVar#7|)
         (LOOP
          (COND
           ((OR (ATOM |bfVar#8|) (PROGN (SETQ |bfVar#7| (CAR |bfVar#8|)) NIL))
            (RETURN NIL))
           (#1#
            (AND (CONSP |bfVar#7|)
                 (PROGN
                  (SETQ |ISTMP#1| (CDR |bfVar#7|))
                  (AND (CONSP |ISTMP#1|)
                       (PROGN (SETQ |name| (CAR |ISTMP#1|)) #1#)))
                 (PROGN
                  (PUT |name| '|ClassTimeTotal| 0.0)
                  (PUT |name| '|ClassSpaceTotal| 0)))))
          (SETQ |bfVar#8| (CDR |bfVar#8|))))
       |listofclasses| NIL)
      (SETQ |$timedNameStack| '(|other|))
      (|computeElapsedTime|)
      (PUT '|gc| '|TimeTotal| 0.0)
      (PUT '|gc| '|SpaceTotal| 0)
      NIL))))

; updateTimedName name ==
;   count := (GET(name, 'TimeTotal) or 0) + computeElapsedTime()
;   PUT(name, 'TimeTotal, count)

(DEFUN |updateTimedName| (|name|)
  (PROG (|count|)
    (RETURN
     (PROGN
      (SETQ |count|
              (+ (OR (GET |name| '|TimeTotal|) 0) (|computeElapsedTime|)))
      (PUT |name| '|TimeTotal| |count|)))))

; makeLongTimeString(listofnames,listofclasses) ==
;   makeLongStatStringByProperty(listofnames, listofclasses,  _
;                                'TimeTotal, 'ClassTimeTotal, _
;                                '"sec", $printTimeIfTrue)

(DEFUN |makeLongTimeString| (|listofnames| |listofclasses|)
  (PROG ()
    (RETURN
     (|makeLongStatStringByProperty| |listofnames| |listofclasses| '|TimeTotal|
      '|ClassTimeTotal| "sec" |$printTimeIfTrue|))))

; makeLongSpaceString(listofnames,listofclasses) ==
;   makeLongStatStringByProperty(listofnames, listofclasses,    _
;                                'SpaceTotal, 'ClassSpaceTotal, _
;                                '"bytes", $printStorageIfTrue)

(DEFUN |makeLongSpaceString| (|listofnames| |listofclasses|)
  (PROG ()
    (RETURN
     (|makeLongStatStringByProperty| |listofnames| |listofclasses|
      '|SpaceTotal| '|ClassSpaceTotal| "bytes" |$printStorageIfTrue|))))

; DEFPARAMETER($inverseTimerTicksPerSecond, 1.0/$timerTicksPerSecond)

(DEFPARAMETER |$inverseTimerTicksPerSecond| (/ 1.0 |$timerTicksPerSecond|))

; computeElapsedTime() ==
;   -- in total time lists, CAR is VIRTCPU and CADR is TOTCPU
;   currentTime:= elapsedUserTime()
;   currentGCTime:= elapsedGcTime()
;   gcDelta := currentGCTime - $oldElapsedGCTime
;   elapsedSeconds:= $inverseTimerTicksPerSecond *
;      (currentTime-$oldElapsedTime-gcDelta)
;   PUT('gc, 'TimeTotal, GET('gc, 'TimeTotal) +
;                    $inverseTimerTicksPerSecond*gcDelta)
;   $oldElapsedTime := currentTime
;   $oldElapsedGCTime := currentGCTime
;   elapsedSeconds

(DEFUN |computeElapsedTime| ()
  (PROG (|elapsedSeconds| |gcDelta| |currentGCTime| |currentTime|)
    (RETURN
     (PROGN
      (SETQ |currentTime| (|elapsedUserTime|))
      (SETQ |currentGCTime| (|elapsedGcTime|))
      (SETQ |gcDelta| (- |currentGCTime| |$oldElapsedGCTime|))
      (SETQ |elapsedSeconds|
              (* |$inverseTimerTicksPerSecond|
                 (- (- |currentTime| |$oldElapsedTime|) |gcDelta|)))
      (PUT '|gc| '|TimeTotal|
       (+ (GET '|gc| '|TimeTotal|)
          (* |$inverseTimerTicksPerSecond| |gcDelta|)))
      (SETQ |$oldElapsedTime| |currentTime|)
      (SETQ |$oldElapsedGCTime| |currentGCTime|)
      |elapsedSeconds|))))

; computeElapsedSpace() ==
;   currentElapsedSpace := HEAPELAPSED()
;   elapsedBytes := currentElapsedSpace - $oldElapsedSpace
;   $oldElapsedSpace := currentElapsedSpace
;   elapsedBytes

(DEFUN |computeElapsedSpace| ()
  (PROG (|elapsedBytes| |currentElapsedSpace|)
    (RETURN
     (PROGN
      (SETQ |currentElapsedSpace| (HEAPELAPSED))
      (SETQ |elapsedBytes| (- |currentElapsedSpace| |$oldElapsedSpace|))
      (SETQ |$oldElapsedSpace| |currentElapsedSpace|)
      |elapsedBytes|))))

; timedAlgebraEvaluation(code) ==
;   startTimingProcess 'algebra
;   r := eval code
;   stopTimingProcess 'algebra
;   r

(DEFUN |timedAlgebraEvaluation| (|code|)
  (PROG (|r|)
    (RETURN
     (PROGN
      (|startTimingProcess| '|algebra|)
      (SETQ |r| (|eval| |code|))
      (|stopTimingProcess| '|algebra|)
      |r|))))

; timedOptimization(code) ==
;   startTimingProcess 'optimization
;   r := lispize code
;   if $reportOptimization then
;     sayBrightlyI bright '"Optimized LISP code:"
;     pp r
;   stopTimingProcess 'optimization
;   r

(DEFUN |timedOptimization| (|code|)
  (PROG (|r|)
    (RETURN
     (PROGN
      (|startTimingProcess| '|optimization|)
      (SETQ |r| (|lispize| |code|))
      (COND
       (|$reportOptimization|
        (|sayBrightlyI| (|bright| "Optimized LISP code:")) (|pp| |r|)))
      (|stopTimingProcess| '|optimization|)
      |r|))))

; timedEVALFUN(code) ==
;   startTimingProcess 'evaluation
;   r := timedEvaluate code
;   stopTimingProcess 'evaluation
;   r

(DEFUN |timedEVALFUN| (|code|)
  (PROG (|r|)
    (RETURN
     (PROGN
      (|startTimingProcess| '|evaluation|)
      (SETQ |r| (|timedEvaluate| |code|))
      (|stopTimingProcess| '|evaluation|)
      |r|))))

; timedEvaluate code ==
;   code is ["LIST",:a] and #a > 200 =>
;     "append"/[eval ["LIST",:x] for x in splitIntoBlocksOf200 a]
;   eval code

(DEFUN |timedEvaluate| (|code|)
  (PROG (|a|)
    (RETURN
     (COND
      ((AND (CONSP |code|) (EQ (CAR |code|) 'LIST)
            (PROGN (SETQ |a| (CDR |code|)) #1='T) (< 200 (LENGTH |a|)))
       ((LAMBDA (|bfVar#10| |bfVar#9| |x|)
          (LOOP
           (COND
            ((OR (ATOM |bfVar#9|) (PROGN (SETQ |x| (CAR |bfVar#9|)) NIL))
             (RETURN |bfVar#10|))
            (#1#
             (SETQ |bfVar#10| (APPEND |bfVar#10| (|eval| (CONS 'LIST |x|))))))
           (SETQ |bfVar#9| (CDR |bfVar#9|))))
        NIL (|splitIntoBlocksOf200| |a|) NIL))
      (#1# (|eval| |code|))))))

; displayHeapStatsIfWanted() ==
;    $printStorageIfTrue => sayBrightly OLDHEAPSTATS()

(DEFUN |displayHeapStatsIfWanted| ()
  (PROG ()
    (RETURN
     (COND (|$printStorageIfTrue| (IDENTITY (|sayBrightly| (OLDHEAPSTATS))))))))

; statRecordInstantiationEvent() == nil

(DEFUN |statRecordInstantiationEvent| () (PROG () (RETURN NIL)))

; statRecordLoadEvent()          == nil

(DEFUN |statRecordLoadEvent| () (PROG () (RETURN NIL)))

; statisticsSummary()  == '"No statistics available."

(DEFUN |statisticsSummary| () (PROG () (RETURN "No statistics available.")))

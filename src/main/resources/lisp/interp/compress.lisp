
; )package "BOOT"

(IN-PACKAGE "BOOT")

; minimalise x ==
;   $hash : local := MAKE_HASHTABLE('UEQUAL)
;   min x where
;     min x ==
;       y:=HGET($hash,x)
;       y => y
;       PAIRP x =>
;         x = '(QUOTE T) => '(QUOTE T)
;         -- copes with a particular Lucid-ism, God knows why
;         -- This circular way of doing things is an attempt to deal with Lucid
;         -- Who may place quoted cells in read-only memory
;         z := min first x
;         if not EQ(z, first x) then RPLACA(x, z)
;         z:=min CDR x
;         if not EQ(z,CDR x) then RPLACD(x,z)
;         HashCheck x
;       REFVECP x =>
;         for i in 0..MAXINDEX x repeat
;           x.i:=min (x.i)
;         HashCheck x
;       STRINGP x => HashCheck x
;       x
;     HashCheck x ==
;       y:=HGET($hash,x)
;       y => y
;       HPUT($hash,x,x)
;       x
;   x

(DEFUN |minimalise| (|x|)
  (PROG (|$hash|)
    (DECLARE (SPECIAL |$hash|))
    (RETURN
     (PROGN
      (SETQ |$hash| (MAKE_HASHTABLE 'UEQUAL))
      (|minimalise,min| |x|)
      |x|))))
(DEFUN |minimalise,min| (|x|)
  (PROG (|y| |z|)
    (RETURN
     (PROGN
      (SETQ |y| (HGET |$hash| |x|))
      (COND (|y| |y|)
            ((CONSP |x|)
             (COND ((EQUAL |x| ''T) ''T)
                   (#1='T
                    (PROGN
                     (SETQ |z| (|minimalise,min| (CAR |x|)))
                     (COND ((NULL (EQ |z| (CAR |x|))) (RPLACA |x| |z|)))
                     (SETQ |z| (|minimalise,min| (CDR |x|)))
                     (COND ((NULL (EQ |z| (CDR |x|))) (RPLACD |x| |z|)))
                     (|minimalise,HashCheck| |x|)))))
            ((REFVECP |x|)
             (PROGN
              ((LAMBDA (|bfVar#1| |i|)
                 (LOOP
                  (COND ((> |i| |bfVar#1|) (RETURN NIL))
                        (#1#
                         (SETF (ELT |x| |i|)
                                 (|minimalise,min| (ELT |x| |i|)))))
                  (SETQ |i| (+ |i| 1))))
               (MAXINDEX |x|) 0)
              (|minimalise,HashCheck| |x|)))
            ((STRINGP |x|) (|minimalise,HashCheck| |x|)) (#1# |x|))))))
(DEFUN |minimalise,HashCheck| (|x|)
  (PROG (|y|)
    (RETURN
     (PROGN
      (SETQ |y| (HGET |$hash| |x|))
      (COND (|y| |y|) ('T (PROGN (HPUT |$hash| |x| |x|) |x|)))))))

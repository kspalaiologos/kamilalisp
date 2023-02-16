
; )package "BOOT"

(IN-PACKAGE "BOOT")

; pathname p ==
;   if SYMBOLP(p) then p := SYMBOL_-NAME(p)
;   PATHNAMEP p => p
;   not PAIRP p => PATHNAME p
;   p is [fn] => PATHNAME make_filename(fn)
;   p is [fn, ft] => PATHNAME make_filename0(fn, ft)
;   error '"Strange argument to pathname"

(DEFUN |pathname| (|p|)
  (PROG (|fn| |ISTMP#1| |ft|)
    (RETURN
     (PROGN
      (COND ((SYMBOLP |p|) (SETQ |p| (SYMBOL-NAME |p|))))
      (COND ((PATHNAMEP |p|) |p|) ((NULL (CONSP |p|)) (PATHNAME |p|))
            ((AND (CONSP |p|) (EQ (CDR |p|) NIL)
                  (PROGN (SETQ |fn| (CAR |p|)) #1='T))
             (PATHNAME (|make_filename| |fn|)))
            ((AND (CONSP |p|)
                  (PROGN
                   (SETQ |fn| (CAR |p|))
                   (SETQ |ISTMP#1| (CDR |p|))
                   (AND (CONSP |ISTMP#1|) (EQ (CDR |ISTMP#1|) NIL)
                        (PROGN (SETQ |ft| (CAR |ISTMP#1|)) #1#))))
             (PATHNAME (|make_filename0| |fn| |ft|)))
            (#1# (|error| "Strange argument to pathname")))))))

; namestring p == NAMESTRING pathname p

(DEFUN |namestring| (|p|) (PROG () (RETURN (NAMESTRING (|pathname| |p|)))))

; pathnameName p == PATHNAME_-NAME pathname p

(DEFUN |pathnameName| (|p|) (PROG () (RETURN (PATHNAME-NAME (|pathname| |p|)))))

; pathnameType p == PATHNAME_-TYPE pathname p

(DEFUN |pathnameType| (|p|) (PROG () (RETURN (PATHNAME-TYPE (|pathname| |p|)))))

; pathnameTypeId p == UPCASE object2Identifier pathnameType p

(DEFUN |pathnameTypeId| (|p|)
  (PROG () (RETURN (UPCASE (|object2Identifier| (|pathnameType| |p|))))))

; pathnameDirectory p ==
;     NAMESTRING MAKE_-PATHNAME(INTERN('"DIRECTORY", '"KEYWORD"),_
;                                PATHNAME_-DIRECTORY pathname p)

(DEFUN |pathnameDirectory| (|p|)
  (PROG ()
    (RETURN
     (NAMESTRING
      (MAKE-PATHNAME (INTERN "DIRECTORY" "KEYWORD")
                     (PATHNAME-DIRECTORY (|pathname| |p|)))))))

; deleteFile f == DELETE_-FILE f

(DEFUN |deleteFile| (|f|) (PROG () (RETURN (DELETE-FILE |f|))))

; isExistingFile f ==
;   if make_input_filename(f)
;     then
;       true
;     else false

(DEFUN |isExistingFile| (|f|)
  (PROG () (RETURN (COND ((|make_input_filename| |f|) T) ('T NIL)))))

; makePathname(name,type) ==
;   -- Common Lisp version of this will have to be written
;   -- using MAKE-PATHNAME and the optional args.
;   pathname [object2String name,object2String type]

(DEFUN |makePathname| (|name| |type|)
  (PROG ()
    (RETURN
     (|pathname| (LIST (|object2String| |name|) (|object2String| |type|))))))

; isSystemDirectory dir == EVERY(function CHAR_=,$SPADROOT,dir)

(DEFUN |isSystemDirectory| (|dir|)
  (PROG () (RETURN (EVERY #'CHAR= $SPADROOT |dir|))))

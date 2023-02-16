
; )package "BOOT"

(IN-PACKAGE "BOOT")

; DEFCONSTANT($LinkToPage, 96)

(DEFCONSTANT |$LinkToPage| 96)

; DEFCONSTANT($StartPage, 97)

(DEFCONSTANT |$StartPage| 97)

; DEFCONSTANT($SendLine, 98)

(DEFCONSTANT |$SendLine| 98)

; DEFCONSTANT($EndOfPage, 99)

(DEFCONSTANT |$EndOfPage| 99)

; DEFCONSTANT($PopUpPage, 95)

(DEFCONSTANT |$PopUpPage| 95)

; DEFCONSTANT($PopUpNamedPage, 94)

(DEFCONSTANT |$PopUpNamedPage| 94)

; DEFCONSTANT($KillPage, 93)

(DEFCONSTANT |$KillPage| 93)

; DEFCONSTANT($ReplacePage, 92)

(DEFCONSTANT |$ReplacePage| 92)

; DEFCONSTANT($ReplaceNamedPage, 91)

(DEFCONSTANT |$ReplaceNamedPage| 91)

; DEFCONSTANT($SpadError, 90)

(DEFCONSTANT |$SpadError| 90)

; DEFCONSTANT($PageStuff, 100)

(DEFCONSTANT |$PageStuff| 100)

; issueHT line ==
; --  unescapeStringsInForm line
;   sockSendInt($MenuServer, $SendLine)
;   sockSendString($MenuServer, line)

(DEFUN |issueHT| (|line|)
  (PROG ()
    (RETURN
     (PROGN
      (|sockSendInt| |$MenuServer| |$SendLine|)
      (|sockSendString| |$MenuServer| |line|)))))

; testPage() ==
;   startHTPage(50)
;   issueHT '"\page{TestPage}{Test Page generated from Lisp} "
;   issueHT '"\horizontalline\beginscroll\beginitems "
;   issueHT '"\item \downlink{Quayle Jokes}{ChickenPage} \space{2} "
;   issueHT '"The misadventures of the White House bellboy. "
;   issueHT '"\enditems\endscroll\autobuttons "
;   endHTPage()

(DEFUN |testPage| ()
  (PROG ()
    (RETURN
     (PROGN
      (|startHTPage| 50)
      (|issueHT| "\\page{TestPage}{Test Page generated from Lisp} ")
      (|issueHT| "\\horizontalline\\beginscroll\\beginitems ")
      (|issueHT| "\\item \\downlink{Quayle Jokes}{ChickenPage} \\space{2} ")
      (|issueHT| "The misadventures of the White House bellboy. ")
      (|issueHT| "\\enditems\\endscroll\\autobuttons ")
      (|endHTPage|)))))

; replaceNamedHTPage(window, name) ==
;   sockSendInt($MenuServer, $PageStuff)
;   sockSendInt($MenuServer, $currentFrameNum)
;   sockSendInt($MenuServer, $ReplaceNamedPage)
;   sockSendInt($MenuServer, window)
;   sockSendString($MenuServer, name)

(DEFUN |replaceNamedHTPage| (|window| |name|)
  (PROG ()
    (RETURN
     (PROGN
      (|sockSendInt| |$MenuServer| |$PageStuff|)
      (|sockSendInt| |$MenuServer| |$currentFrameNum|)
      (|sockSendInt| |$MenuServer| |$ReplaceNamedPage|)
      (|sockSendInt| |$MenuServer| |window|)
      (|sockSendString| |$MenuServer| |name|)))))

; startHTPopUpPage cols ==
;   sockSendInt($MenuServer, $PageStuff)
;   sockSendInt($MenuServer, $currentFrameNum)
;   sockSendInt($MenuServer, $PopUpPage)
;   sockSendInt($MenuServer, cols)
;   sockGetInt($MenuServer)

(DEFUN |startHTPopUpPage| (|cols|)
  (PROG ()
    (RETURN
     (PROGN
      (|sockSendInt| |$MenuServer| |$PageStuff|)
      (|sockSendInt| |$MenuServer| |$currentFrameNum|)
      (|sockSendInt| |$MenuServer| |$PopUpPage|)
      (|sockSendInt| |$MenuServer| |cols|)
      (|sockGetInt| |$MenuServer|)))))

; startHTPage cols ==
;   sockSendInt($MenuServer, $PageStuff)
;   sockSendInt($MenuServer, $currentFrameNum)
;   sockSendInt($MenuServer, $StartPage)
;   sockSendInt($MenuServer, cols)

(DEFUN |startHTPage| (|cols|)
  (PROG ()
    (RETURN
     (PROGN
      (|sockSendInt| |$MenuServer| |$PageStuff|)
      (|sockSendInt| |$MenuServer| |$currentFrameNum|)
      (|sockSendInt| |$MenuServer| |$StartPage|)
      (|sockSendInt| |$MenuServer| |cols|)))))

; startReplaceHTPage w ==
;   sockSendInt($MenuServer, $PageStuff)
;   sockSendInt($MenuServer, $currentFrameNum)
;   sockSendInt($MenuServer, $ReplacePage)
;   sockSendInt($MenuServer, w)

(DEFUN |startReplaceHTPage| (|w|)
  (PROG ()
    (RETURN
     (PROGN
      (|sockSendInt| |$MenuServer| |$PageStuff|)
      (|sockSendInt| |$MenuServer| |$currentFrameNum|)
      (|sockSendInt| |$MenuServer| |$ReplacePage|)
      (|sockSendInt| |$MenuServer| |w|)))))

; killHTPage w ==
;   sockSendInt($MenuServer, $PageStuff)
;   sockSendInt($MenuServer, $currentFrameNum)
;   sockSendInt($MenuServer, $KillPage)
;   sockSendInt($MenuServer, w)

(DEFUN |killHTPage| (|w|)
  (PROG ()
    (RETURN
     (PROGN
      (|sockSendInt| |$MenuServer| |$PageStuff|)
      (|sockSendInt| |$MenuServer| |$currentFrameNum|)
      (|sockSendInt| |$MenuServer| |$KillPage|)
      (|sockSendInt| |$MenuServer| |w|)))))

; linkToHTPage name ==
;   sockSendInt($MenuServer, $PageStuff)
;   sockSendInt($MenuServer, $currentFrameNum)
;   sockSendInt($MenuServer, $LinkToPage)
;   sockSendString($MenuServer, name)

(DEFUN |linkToHTPage| (|name|)
  (PROG ()
    (RETURN
     (PROGN
      (|sockSendInt| |$MenuServer| |$PageStuff|)
      (|sockSendInt| |$MenuServer| |$currentFrameNum|)
      (|sockSendInt| |$MenuServer| |$LinkToPage|)
      (|sockSendString| |$MenuServer| |name|)))))

; popUpNamedHTPage(name,cols) ==
;   sockSendInt($MenuServer, $PageStuff)
;   sockSendInt($MenuServer, $currentFrameNum)
;   sockSendInt($MenuServer, $PopUpNamedPage)
;   sockSendInt($MenuServer, cols)
;   sockSendString($MenuServer, name)
;   sockGetInt($MenuServer)

(DEFUN |popUpNamedHTPage| (|name| |cols|)
  (PROG ()
    (RETURN
     (PROGN
      (|sockSendInt| |$MenuServer| |$PageStuff|)
      (|sockSendInt| |$MenuServer| |$currentFrameNum|)
      (|sockSendInt| |$MenuServer| |$PopUpNamedPage|)
      (|sockSendInt| |$MenuServer| |cols|)
      (|sockSendString| |$MenuServer| |name|)
      (|sockGetInt| |$MenuServer|)))))

; sendHTErrorSignal() ==
;   sockSendInt($MenuServer, $SpadError)

(DEFUN |sendHTErrorSignal| ()
  (PROG () (RETURN (|sockSendInt| |$MenuServer| |$SpadError|))))

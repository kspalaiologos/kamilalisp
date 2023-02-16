
(SDEFUN |TESTCNT;testsuite;SV;1| ((|s| (|String|)) ($ (|Void|)))
        (SEQ (SPADCALL "clear all" (QREFELT $ 19))
             (EXIT (SPADCALL |s| (QREFELT $ 20))))) 

(SDEFUN |TESTCNT;testsuiteNoClear;SV;2| ((|s| (|String|)) ($ (|Void|)))
        (SEQ
         (COND
          ((> (QCSIZE |s|) 15)
           (SPADCALL
            (SPADCALL "WARNING: string for testsuite should have less than "
                      "15 characters!" (QREFELT $ 22))
            (QREFELT $ 24))))
         (SETELT $ 15 |s|)
         (EXIT
          (SPADCALL (CONS (QREFELT $ 15) (SPADCALL (QREFELT $ 26)))
                    (QREFELT $ 12) (QREFELT $ 28))))) 

(SDEFUN |TESTCNT;testcaseNoClear;SV;3| ((|s| (|String|)) ($ (|Void|)))
        (SEQ (SETELT $ 14 |s|)
             (EXIT
              (SPADCALL (CONS (QREFELT $ 14) (VECTOR 0 0 0 0 NIL NIL NIL))
                        (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                        (QREFELT $ 31))))) 

(SDEFUN |TESTCNT;testcase;SV;4| ((|s| (|String|)) ($ (|Void|)))
        (SEQ (SPADCALL "clear all" (QREFELT $ 19))
             (EXIT (SPADCALL |s| (QREFELT $ 32))))) 

(SDEFUN |TESTCNT;incPass;V;5| (($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (EXIT (QSETVELT |cur| 0 (+ (QVELT |cur| 0) 1)))))) 

(SDEFUN |TESTCNT;chkLibraryError;V;6| (($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (EXIT (QSETVELT |cur| 0 (+ (QVELT |cur| 0) 1)))))) 

(SDEFUN |TESTCNT;incLibraryError;SLV;7|
        ((|inp| (|String|)) (|out| (|List| (|OutputForm|))) ($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (QSETVELT |cur| 1 (+ (QVELT |cur| 1) 1))
          (EXIT
           (QSETVELT |cur| 6
                     (CONS (VECTOR (QVELT |cur| 0) |inp| |out|)
                           (QVELT |cur| 6))))))) 

(SDEFUN |TESTCNT;incXfLibraryError;SLV;8|
        ((|inp| (|String|)) (|out| (|List| (|OutputForm|))) ($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (EXIT (QSETVELT |cur| 2 (+ (QVELT |cur| 2) 1)))))) 

(SDEFUN |TESTCNT;incXfFail;V;9| (($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (QSETVELT |cur| 2 (+ (QVELT |cur| 2) 1))
          (EXIT (QSETVELT |cur| 0 (+ (QVELT |cur| 0) 1)))))) 

(SDEFUN |TESTCNT;incFail;SLV;10|
        ((|inp| (|String|)) (|out| (|List| (|OutputForm|))) ($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (QSETVELT |cur| 1 (+ (QVELT |cur| 1) 1))
          (QSETVELT |cur| 6
                    (CONS (VECTOR (QVELT |cur| 0) |inp| |out|)
                          (QVELT |cur| 6)))
          (EXIT (QSETVELT |cur| 0 (+ (QVELT |cur| 0) 1)))))) 

(SDEFUN |TESTCNT;incXfPass;SLV;11|
        ((|inp| (|String|)) (|out| (|List| (|OutputForm|))) ($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (QSETVELT |cur| 3 (+ (QVELT |cur| 3) 1))
          (QSETVELT |cur| 5
                    (CONS (VECTOR (QVELT |cur| 0) |inp| |out|)
                          (QVELT |cur| 5)))
          (EXIT (QSETVELT |cur| 0 (+ (QVELT |cur| 0) 1)))))) 

(SDEFUN |TESTCNT;decXfPass;V;12| (($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (QSETVELT |cur| 0 (- (QVELT |cur| 0) 1))
          (QSETVELT |cur| 5 (CDR (QVELT |cur| 5)))
          (EXIT (QSETVELT |cur| 3 (- (QVELT |cur| 3) 1)))))) 

(SDEFUN |TESTCNT;incFatal;SV;13| ((|inp| (|String|)) ($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (QSETVELT |cur| 0 (+ (QVELT |cur| 0) 1))
          (QSETVELT |cur| 1 (+ (QVELT |cur| 1) 1))
          (EXIT
           (QSETVELT |cur| 4
                     (CONS (CONS (QVELT |cur| 0) |inp|) (QVELT |cur| 4))))))) 

(SDEFUN |TESTCNT;decFatal;V;14| (($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (QSETVELT |cur| 0 (- (QVELT |cur| 0) 1))
          (QSETVELT |cur| 1 (- (QVELT |cur| 1) 1))
          (EXIT (QSETVELT |cur| 4 (CDR (QVELT |cur| 4))))))) 

(SDEFUN |TESTCNT;incXfFatal;SV;15| ((|inp| (|String|)) ($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (QSETVELT |cur| 0 (+ (QVELT |cur| 0) 1))
          (EXIT (QSETVELT |cur| 2 (+ (QVELT |cur| 2) 1)))))) 

(SDEFUN |TESTCNT;decXfFatal;V;16| (($ (|Void|)))
        (SPROG
         ((|cur|
           (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                     (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                     (|:| |fatalities|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|)))))
                     (|:| |xfpassed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output| (|List| (|OutputForm|))))))
                     (|:| |failed|
                          (|List|
                           (|Record| (|:| |index| (|Integer|))
                                     (|:| |input| (|String|))
                                     (|:| |output|
                                          (|List| (|OutputForm|)))))))))
         (SEQ
          (LETT |cur|
                (SPADCALL
                 (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                 (QREFELT $ 14) (QREFELT $ 34)))
          (QSETVELT |cur| 0 (- (QVELT |cur| 0) 1))
          (EXIT (QSETVELT |cur| 2 (- (QVELT |cur| 2) 1)))))) 

(SDEFUN |TESTCNT;addWarning;OfV;17| ((|s| (|OutputForm|)) ($ (|Void|)))
        (SPROG ((|idx| (|Integer|)))
               (SEQ
                (LETT |idx|
                      (QVELT
                       (SPADCALL
                        (SPADCALL (QREFELT $ 12) (QREFELT $ 15) (QREFELT $ 29))
                        (QREFELT $ 14) (QREFELT $ 34))
                       0))
                (EXIT
                 (SETELT $ 13
                         (CONS
                          (SPADCALL
                           (LIST
                            (SPADCALL
                             (SPADCALL "Testsuite: " (QREFELT $ 15)
                                       (QREFELT $ 22))
                             (QREFELT $ 48))
                            (SPADCALL
                             (SPADCALL "Testcase: " (QREFELT $ 14)
                                       (QREFELT $ 22))
                             (QREFELT $ 48))
                            (SPADCALL
                             (SPADCALL "test: " (STRINGIMAGE |idx|)
                                       (QREFELT $ 22))
                             (QREFELT $ 48))
                            |s|)
                           (QREFELT $ 50))
                          (QREFELT $ 13))))))) 

(SDEFUN |TESTCNT;statistics;V;18| (($ (|Void|)))
        (SPROG
         ((#1=#:G857 NIL) (#2=#:G853 NIL) (#3=#:G849 NIL) (#4=#:G845 NIL)
          (#5=#:G841 NIL) (|stotalTests| #6=(|String|)) (|sfailedTests| #6#)
          (|stotalCases| #6#) (|sfailedCases| #6#)
          (|tsfailedTests| (|Integer|)) (|tstotalTests| (|Integer|))
          (|failedCases| (|Integer|)) (|totalCases| (|Integer|))
          (#7=#:G873 NIL) (|tstcase| NIL) (#8=#:G872 NIL) (|tstsuite| NIL)
          (#9=#:G871 NIL) (|f| NIL) (#10=#:G818 NIL) (#11=#:G870 NIL)
          (#12=#:G869 NIL) (|outstring| (|String|)) (#13=#:G867 NIL) (|o| NIL)
          (#14=#:G868 NIL) (|i| NIL) (#15=#:G866 NIL) (#16=#:G795 NIL)
          (#17=#:G865 NIL) (|xfpassedTests| (|Integer|))
          (|xfailedTests| (|Integer|)) (|failedTests| (|Integer|))
          (|totalTests| (|Integer|)) (|xfpassedCases| (|Integer|))
          (#18=#:G864 NIL) (#19=#:G863 NIL) (#20=#:G862 NIL) (|w| NIL))
         (SEQ
          (SPADCALL (|make_full_CVEC2| (QREFELT $ 6) (|STR_to_CHAR| "="))
                    (QREFELT $ 24))
          (SPADCALL "General WARNINGS:" (QREFELT $ 24))
          (SPADCALL
           (SPADCALL "* do not use ')clear completely' before having used "
                     "'statistics()'" (QREFELT $ 22))
           (QREFELT $ 24))
          (SPADCALL "  It clears the statistics without warning!"
                    (QREFELT $ 24))
          (SPADCALL
           (SPADCALL "* do not forget to pass the arguments of the testXxxx "
                     "functions as Strings!" (QREFELT $ 22))
           (QREFELT $ 24))
          (SPADCALL
           (SPADCALL "  Otherwise, the test will fail and statistics() will "
                     "not notice!" (QREFELT $ 22))
           (QREFELT $ 24))
          (SPADCALL
           (SPADCALL "* testLibraryError does not prevent FriCAS from "
                     "aborting the current block." (QREFELT $ 22))
           (QREFELT $ 24))
          (SPADCALL
           (SPADCALL "  Thus, if a block contains other test functions, they "
                     "will not be executed" (QREFELT $ 22))
           (QREFELT $ 24))
          (SPADCALL "  and statistics() will not notice!" (QREFELT $ 24))
          (COND
           ((> (LENGTH (QREFELT $ 13)) 0)
            (SEQ
             (SPADCALL (|make_full_CVEC2| (QREFELT $ 6) (|STR_to_CHAR| "="))
                       (QREFELT $ 24))
             (SPADCALL "WARNINGS:" (QREFELT $ 24))
             (EXIT
              (SEQ (LETT |w| NIL) (LETT #20# (REVERSE (QREFELT $ 13))) G190
                   (COND
                    ((OR (ATOM #20#) (PROGN (LETT |w| (CAR #20#)) NIL))
                     (GO G191)))
                   (SEQ (EXIT (SPADCALL |w| (QREFELT $ 53))))
                   (LETT #20# (CDR #20#)) (GO G190) G191 (EXIT NIL))))))
          (SPADCALL "" (QREFELT $ 54)) (LETT |totalTests| 0)
          (LETT |failedTests| 0) (LETT |xfailedTests| 0)
          (LETT |xfpassedTests| 0)
          (SEQ (LETT |tstsuite| NIL)
               (LETT #19# (REVERSE (SPADCALL (QREFELT $ 12) (QREFELT $ 56))))
               G190
               (COND
                ((OR (ATOM #19#) (PROGN (LETT |tstsuite| (CAR #19#)) NIL))
                 (GO G191)))
               (SEQ (LETT |failedCases| 0) (LETT |xfpassedCases| 0)
                    (LETT |totalCases| 0)
                    (SEQ (LETT |tstcase| NIL)
                         (LETT #18#
                               (REVERSE
                                (SPADCALL (QCDR |tstsuite|) (QREFELT $ 58))))
                         G190
                         (COND
                          ((OR (ATOM #18#)
                               (PROGN (LETT |tstcase| (CAR #18#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |totalCases| (+ |totalCases| 1))
                              (COND
                               ((> (QVELT (QCDR |tstcase|) 1) 0)
                                (LETT |failedCases| (+ |failedCases| 1))))
                              (COND
                               ((> (QVELT (QCDR |tstcase|) 3) 0)
                                (LETT |xfpassedCases| (+ |xfpassedCases| 1))))
                              (LETT |totalTests|
                                    (+ |totalTests|
                                       (QVELT (QCDR |tstcase|) 0)))
                              (LETT |failedTests|
                                    (+ |failedTests|
                                       (QVELT (QCDR |tstcase|) 1)))
                              (LETT |xfailedTests|
                                    (+ |xfailedTests|
                                       (QVELT (QCDR |tstcase|) 2)))
                              (EXIT
                               (LETT |xfpassedTests|
                                     (+ |xfpassedTests|
                                        (QVELT (QCDR |tstcase|) 3)))))
                         (LETT #18# (CDR #18#)) (GO G190) G191 (EXIT NIL))
                    (SPADCALL
                     (|make_full_CVEC2| (QREFELT $ 6) (|STR_to_CHAR| "="))
                     (QREFELT $ 24))
                    (SPADCALL
                     (SPADCALL "Testsuite: " (QCAR |tstsuite|) (QREFELT $ 22))
                     (QREFELT $ 24))
                    (SPADCALL
                     (SPADCALL "  failed (total): "
                               (SPADCALL (STRINGIMAGE |failedCases|)
                                         (SPADCALL " ("
                                                   (SPADCALL
                                                    (STRINGIMAGE |totalCases|)
                                                    ")" (QREFELT $ 22))
                                                   (QREFELT $ 22))
                                         (QREFELT $ 22))
                               (QREFELT $ 22))
                     (QREFELT $ 24))
                    (COND
                     ((> |failedCases| 0)
                      (SEQ (SPADCALL "" (QREFELT $ 54))
                           (SPADCALL "  failed testcases were:" (QREFELT $ 24))
                           (EXIT
                            (SEQ (LETT |tstcase| NIL)
                                 (LETT #17#
                                       (REVERSE
                                        (SPADCALL (QCDR |tstsuite|)
                                                  (QREFELT $ 58))))
                                 G190
                                 (COND
                                  ((OR (ATOM #17#)
                                       (PROGN (LETT |tstcase| (CAR #17#)) NIL))
                                   (GO G191)))
                                 (SEQ
                                  (EXIT
                                   (COND
                                    ((> (QVELT (QCDR |tstcase|) 1) 0)
                                     (SEQ
                                      (SPADCALL
                                       (SPADCALL "  "
                                                 (|make_full_CVEC2|
                                                  (PROG1
                                                      (LETT #16#
                                                            (- (QREFELT $ 6)
                                                               2))
                                                    (|check_subtype2|
                                                     (>= #16# 0)
                                                     '(|NonNegativeInteger|)
                                                     '(|Integer|) #16#))
                                                  (|STR_to_CHAR| "-"))
                                                 (QREFELT $ 22))
                                       (QREFELT $ 24))
                                      (SPADCALL
                                       (SPADCALL "  Testcase: "
                                                 (QCAR |tstcase|)
                                                 (QREFELT $ 22))
                                       (QREFELT $ 24))
                                      (SPADCALL
                                       (SPADCALL "    failed (total): "
                                                 (SPADCALL
                                                  (STRINGIMAGE
                                                   (QVELT (QCDR |tstcase|) 1))
                                                  (SPADCALL " ("
                                                            (SPADCALL
                                                             (STRINGIMAGE
                                                              (QVELT
                                                               (QCDR |tstcase|)
                                                               0))
                                                             ")"
                                                             (QREFELT $ 22))
                                                            (QREFELT $ 22))
                                                  (QREFELT $ 22))
                                                 (QREFELT $ 22))
                                       (QREFELT $ 24))
                                      (COND
                                       ((NULL
                                         (NULL (QVELT (QCDR |tstcase|) 6)))
                                        (SEQ (SPADCALL "" (QREFELT $ 54))
                                             (SPADCALL "    failed tests were:"
                                                       (QREFELT $ 24))
                                             (EXIT
                                              (SEQ (LETT |f| NIL)
                                                   (LETT #15#
                                                         (REVERSE
                                                          (QVELT
                                                           (QCDR |tstcase|)
                                                           6)))
                                                   G190
                                                   (COND
                                                    ((OR (ATOM #15#)
                                                         (PROGN
                                                          (LETT |f| (CAR #15#))
                                                          NIL))
                                                     (GO G191)))
                                                   (SEQ
                                                    (SPADCALL ""
                                                              (QREFELT $ 54))
                                                    (SPADCALL
                                                     (SPADCALL "      "
                                                               (SPADCALL
                                                                (STRINGIMAGE
                                                                 (QVELT |f| 0))
                                                                (SPADCALL ": "
                                                                          (QVELT
                                                                           |f|
                                                                           1)
                                                                          (QREFELT
                                                                           $
                                                                           22))
                                                                (QREFELT $ 22))
                                                               (QREFELT $ 22))
                                                     (QREFELT $ 24))
                                                    (EXIT
                                                     (SEQ (LETT |i| 1)
                                                          (LETT #14#
                                                                (LENGTH
                                                                 (QVELT |f|
                                                                        2)))
                                                          (LETT |o| NIL)
                                                          (LETT #13#
                                                                (QVELT |f| 2))
                                                          G190
                                                          (COND
                                                           ((OR (ATOM #13#)
                                                                (PROGN
                                                                 (LETT |o|
                                                                       (CAR
                                                                        #13#))
                                                                 NIL)
                                                                (|greater_SI|
                                                                 |i| #14#))
                                                            (GO G191)))
                                                          (SEQ
                                                           (LETT |outstring|
                                                                 (SPADCALL
                                                                  "      Output"
                                                                  (SPADCALL
                                                                   (STRINGIMAGE
                                                                    |i|)
                                                                   ": "
                                                                   (QREFELT $
                                                                            22))
                                                                  (QREFELT $
                                                                           22)))
                                                           (EXIT
                                                            (SPADCALL
                                                             (SPADCALL
                                                              (SPADCALL
                                                               |outstring|
                                                               (QREFELT $ 48))
                                                              |o|
                                                              (QREFELT $ 59))
                                                             (QREFELT $ 53))))
                                                          (LETT #13#
                                                                (PROG1
                                                                    (CDR #13#)
                                                                  (LETT |i|
                                                                        (|inc_SI|
                                                                         |i|))))
                                                          (GO G190) G191
                                                          (EXIT NIL))))
                                                   (LETT #15# (CDR #15#))
                                                   (GO G190) G191
                                                   (EXIT NIL))))))
                                      (EXIT
                                       (COND
                                        ((NULL
                                          (NULL (QVELT (QCDR |tstcase|) 4)))
                                         (SEQ (SPADCALL "" (QREFELT $ 54))
                                              (SPADCALL "  fatal tests were:"
                                                        (QREFELT $ 24))
                                              (EXIT
                                               (SEQ (LETT |f| NIL)
                                                    (LETT #12#
                                                          (REVERSE
                                                           (QVELT
                                                            (QCDR |tstcase|)
                                                            4)))
                                                    G190
                                                    (COND
                                                     ((OR (ATOM #12#)
                                                          (PROGN
                                                           (LETT |f|
                                                                 (CAR #12#))
                                                           NIL))
                                                      (GO G191)))
                                                    (SEQ
                                                     (SPADCALL ""
                                                               (QREFELT $ 54))
                                                     (EXIT
                                                      (SPADCALL
                                                       (SPADCALL "      "
                                                                 (SPADCALL
                                                                  (STRINGIMAGE
                                                                   (QCAR |f|))
                                                                  (SPADCALL
                                                                   ": "
                                                                   (QCDR |f|)
                                                                   (QREFELT $
                                                                            22))
                                                                  (QREFELT $
                                                                           22))
                                                                 (QREFELT $
                                                                          22))
                                                       (QREFELT $ 24))))
                                                    (LETT #12# (CDR #12#))
                                                    (GO G190) G191
                                                    (EXIT NIL))))))))))))
                                 (LETT #17# (CDR #17#)) (GO G190) G191
                                 (EXIT NIL))))))
                    (EXIT
                     (COND
                      ((> |xfpassedCases| 0)
                       (SEQ (SPADCALL "" (QREFELT $ 54))
                            (SPADCALL
                             "  testcases with unexpected passed tests were:"
                             (QREFELT $ 24))
                            (EXIT
                             (SEQ (LETT |tstcase| NIL)
                                  (LETT #11#
                                        (REVERSE
                                         (SPADCALL (QCDR |tstsuite|)
                                                   (QREFELT $ 58))))
                                  G190
                                  (COND
                                   ((OR (ATOM #11#)
                                        (PROGN
                                         (LETT |tstcase| (CAR #11#))
                                         NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (COND
                                     ((> (QVELT (QCDR |tstcase|) 3) 0)
                                      (SEQ
                                       (SPADCALL
                                        (SPADCALL "  "
                                                  (|make_full_CVEC2|
                                                   (PROG1
                                                       (LETT #10#
                                                             (- (QREFELT $ 6)
                                                                2))
                                                     (|check_subtype2|
                                                      (>= #10# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #10#))
                                                   (|STR_to_CHAR| "-"))
                                                  (QREFELT $ 22))
                                        (QREFELT $ 24))
                                       (SPADCALL
                                        (SPADCALL "  Testcase: "
                                                  (QCAR |tstcase|)
                                                  (QREFELT $ 22))
                                        (QREFELT $ 24))
                                       (EXIT
                                        (COND
                                         ((NULL
                                           (NULL (QVELT (QCDR |tstcase|) 5)))
                                          (SEQ (SPADCALL "" (QREFELT $ 54))
                                               (SPADCALL
                                                "  unexpected passed tests were:"
                                                (QREFELT $ 24))
                                               (EXIT
                                                (SEQ (LETT |f| NIL)
                                                     (LETT #9#
                                                           (REVERSE
                                                            (QVELT
                                                             (QCDR |tstcase|)
                                                             5)))
                                                     G190
                                                     (COND
                                                      ((OR (ATOM #9#)
                                                           (PROGN
                                                            (LETT |f|
                                                                  (CAR #9#))
                                                            NIL))
                                                       (GO G191)))
                                                     (SEQ
                                                      (SPADCALL ""
                                                                (QREFELT $ 54))
                                                      (EXIT
                                                       (SPADCALL
                                                        (SPADCALL "      "
                                                                  (SPADCALL
                                                                   (STRINGIMAGE
                                                                    (QVELT |f|
                                                                           0))
                                                                   (SPADCALL
                                                                    ": "
                                                                    (QVELT |f|
                                                                           1)
                                                                    (QREFELT $
                                                                             22))
                                                                   (QREFELT $
                                                                            22))
                                                                  (QREFELT $
                                                                           22))
                                                        (QREFELT $ 24))))
                                                     (LETT #9# (CDR #9#))
                                                     (GO G190) G191
                                                     (EXIT NIL))))))))))))
                                  (LETT #11# (CDR #11#)) (GO G190) G191
                                  (EXIT NIL))))))))
               (LETT #19# (CDR #19#)) (GO G190) G191 (EXIT NIL))
          (SPADCALL "" (QREFELT $ 54))
          (SPADCALL (|make_full_CVEC2| (QREFELT $ 6) (|STR_to_CHAR| "="))
                    (QREFELT $ 24))
          (SPADCALL
           "testsuite | testcases: failed (total) | tests: failed (total)"
           (QREFELT $ 24))
          (SEQ (LETT |tstsuite| NIL)
               (LETT #8# (REVERSE (SPADCALL (QREFELT $ 12) (QREFELT $ 56))))
               G190
               (COND
                ((OR (ATOM #8#) (PROGN (LETT |tstsuite| (CAR #8#)) NIL))
                 (GO G191)))
               (SEQ (LETT |failedCases| 0) (LETT |totalCases| 0)
                    (LETT |tsfailedTests| 0) (LETT |tstotalTests| 0)
                    (SEQ (LETT |tstcase| NIL)
                         (LETT #7#
                               (REVERSE
                                (SPADCALL (QCDR |tstsuite|) (QREFELT $ 58))))
                         G190
                         (COND
                          ((OR (ATOM #7#)
                               (PROGN (LETT |tstcase| (CAR #7#)) NIL))
                           (GO G191)))
                         (SEQ (LETT |totalCases| (+ |totalCases| 1))
                              (COND
                               ((> (QVELT (QCDR |tstcase|) 1) 0)
                                (LETT |failedCases| (+ |failedCases| 1))))
                              (LETT |tstotalTests|
                                    (+ |tstotalTests|
                                       (QVELT (QCDR |tstcase|) 0)))
                              (EXIT
                               (LETT |tsfailedTests|
                                     (+ |tsfailedTests|
                                        (QVELT (QCDR |tstcase|) 1)))))
                         (LETT #7# (CDR #7#)) (GO G190) G191 (EXIT NIL))
                    (LETT |sfailedCases| (STRINGIMAGE |failedCases|))
                    (LETT |stotalCases| (STRINGIMAGE |totalCases|))
                    (LETT |sfailedTests| (STRINGIMAGE |tsfailedTests|))
                    (LETT |stotalTests| (STRINGIMAGE |tstotalTests|))
                    (EXIT
                     (SPADCALL
                      (SPADCALL (QCAR |tstsuite|)
                                (SPADCALL
                                 (|make_full_CVEC2|
                                  (PROG1
                                      (LETT #5#
                                            (MAX
                                             (- 24 (QCSIZE (QCAR |tstsuite|)))
                                             0))
                                    (|check_subtype2| (>= #5# 0)
                                                      '(|NonNegativeInteger|)
                                                      '(|Integer|) #5#))
                                  (|STR_to_CHAR| " "))
                                 (SPADCALL
                                  (|make_full_CVEC2|
                                   (PROG1
                                       (LETT #4#
                                             (MAX (- 5 (QCSIZE |sfailedCases|))
                                                  0))
                                     (|check_subtype2| (>= #4# 0)
                                                       '(|NonNegativeInteger|)
                                                       '(|Integer|) #4#))
                                   (|STR_to_CHAR| " "))
                                  (SPADCALL |sfailedCases|
                                            (SPADCALL
                                             (|make_full_CVEC2|
                                              (PROG1
                                                  (LETT #3#
                                                        (MAX
                                                         (- 6
                                                            (QCSIZE
                                                             |stotalCases|))
                                                         0))
                                                (|check_subtype2| (>= #3# 0)
                                                                  '(|NonNegativeInteger|)
                                                                  '(|Integer|)
                                                                  #3#))
                                              (|STR_to_CHAR| " "))
                                             (SPADCALL "("
                                                       (SPADCALL |stotalCases|
                                                                 (SPADCALL ")"
                                                                           (SPADCALL
                                                                            (|make_full_CVEC2|
                                                                             (PROG1
                                                                                 (LETT
                                                                                  #2#
                                                                                  (MAX
                                                                                   (-
                                                                                    16
                                                                                    (QCSIZE
                                                                                     |sfailedTests|))
                                                                                   0))
                                                                               (|check_subtype2|
                                                                                (>=
                                                                                 #2#
                                                                                 0)
                                                                                '(|NonNegativeInteger|)
                                                                                '(|Integer|)
                                                                                #2#))
                                                                             (|STR_to_CHAR|
                                                                              " "))
                                                                            (SPADCALL
                                                                             |sfailedTests|
                                                                             (SPADCALL
                                                                              (|make_full_CVEC2|
                                                                               (PROG1
                                                                                   (LETT
                                                                                    #1#
                                                                                    (MAX
                                                                                     (-
                                                                                      6
                                                                                      (QCSIZE
                                                                                       |stotalTests|))
                                                                                     0))
                                                                                 (|check_subtype2|
                                                                                  (>=
                                                                                   #1#
                                                                                   0)
                                                                                  '(|NonNegativeInteger|)
                                                                                  '(|Integer|)
                                                                                  #1#))
                                                                               (|STR_to_CHAR|
                                                                                " "))
                                                                              (SPADCALL
                                                                               "("
                                                                               (SPADCALL
                                                                                |stotalTests|
                                                                                ")"
                                                                                (QREFELT
                                                                                 $
                                                                                 22))
                                                                               (QREFELT
                                                                                $
                                                                                22))
                                                                              (QREFELT
                                                                               $
                                                                               22))
                                                                             (QREFELT
                                                                              $
                                                                              22))
                                                                            (QREFELT
                                                                             $
                                                                             22))
                                                                           (QREFELT
                                                                            $
                                                                            22))
                                                                 (QREFELT $
                                                                          22))
                                                       (QREFELT $ 22))
                                             (QREFELT $ 22))
                                            (QREFELT $ 22))
                                  (QREFELT $ 22))
                                 (QREFELT $ 22))
                                (QREFELT $ 22))
                      (QREFELT $ 24))))
               (LETT #8# (CDR #8#)) (GO G190) G191 (EXIT NIL))
          (SPADCALL (|make_full_CVEC2| (QREFELT $ 6) (|STR_to_CHAR| "="))
                    (QREFELT $ 24))
          (SPADCALL "File summary." (QREFELT $ 24))
          (SPADCALL
           (SPADCALL "unexpected failures: " (STRINGIMAGE |failedTests|)
                     (QREFELT $ 22))
           (QREFELT $ 24))
          (SPADCALL
           (SPADCALL "expected failures: " (STRINGIMAGE |xfailedTests|)
                     (QREFELT $ 22))
           (QREFELT $ 24))
          (SPADCALL
           (SPADCALL "unexpected passes: " (STRINGIMAGE |xfpassedTests|)
                     (QREFELT $ 22))
           (QREFELT $ 24))
          (EXIT
           (SPADCALL
            (SPADCALL "total tests: " (STRINGIMAGE |totalTests|)
                      (QREFELT $ 22))
            (QREFELT $ 24)))))) 

(DECLAIM (NOTINLINE |UnittestCount;|)) 

(DEFUN |UnittestCount| ()
  (SPROG NIL
         (PROG (#1=#:G875)
           (RETURN
            (COND
             ((LETT #1# (HGET |$ConstructorCache| '|UnittestCount|))
              (|CDRwithIncrement| (CDAR #1#)))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (CDDAR
                       (HPUT |$ConstructorCache| '|UnittestCount|
                             (LIST (CONS NIL (CONS 1 (|UnittestCount;|))))))
                    (LETT #1# T))
                (COND
                 ((NOT #1#) (HREM |$ConstructorCache| '|UnittestCount|)))))))))) 

(DEFUN |UnittestCount;| ()
  (SPROG ((|dv$| NIL) ($ NIL) (|pv$| NIL))
         (PROGN
          (LETT |dv$| '(|UnittestCount|))
          (LETT $ (GETREFV 61))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache| '|UnittestCount| NIL (CONS 1 $))
          (|stuffDomainSlots| $)
          (SETF |pv$| (QREFELT $ 3))
          (QSETREFV $ 6 77)
          (QSETREFV $ 12 (SPADCALL (QREFELT $ 11)))
          (QSETREFV $ 13 NIL)
          (QSETREFV $ 14 #1="")
          (QSETREFV $ 15 #1#)
          $))) 

(MAKEPROP '|UnittestCount| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL '|maxWidth|
              (|Record| (|:| |index| (|Integer|)) (|:| |input| 17))
              (|Record| (|:| |index| (|Integer|)) (|:| |input| 17)
                        (|:| |output| 37))
              (|Record| (|:| |total| (|Integer|)) (|:| |fail| (|Integer|))
                        (|:| |xfail| (|Integer|)) (|:| |xfpass| (|Integer|))
                        (|:| |fatalities| (|List| 7))
                        (|:| |xfpassed| (|List| 8)) (|:| |failed| (|List| 8)))
              (|AssociationList| 17 25) (0 . |empty|) '|tests| '|warnings|
              '|currentTestcase| '|currentTestsuite| (|Void|) (|String|)
              (|MoreSystemCommands|) (4 . |systemCommand|)
              |TESTCNT;testsuiteNoClear;SV;2| |TESTCNT;testsuite;SV;1|
              (9 . |elt|) (|OutputForm|) (15 . |messagePrint|)
              (|AssociationList| 17 9) (20 . |empty|)
              (|Record| (|:| |key| 17) (|:| |entry| 25)) (24 . |insert!|)
              (30 . |elt|) (|Record| (|:| |key| 17) (|:| |entry| 9))
              (36 . |insert!|) |TESTCNT;testcaseNoClear;SV;3|
              |TESTCNT;testcase;SV;4| (42 . |elt|) |TESTCNT;incPass;V;5|
              |TESTCNT;chkLibraryError;V;6| (|List| 23)
              |TESTCNT;incLibraryError;SLV;7| |TESTCNT;incXfLibraryError;SLV;8|
              |TESTCNT;incXfFail;V;9| |TESTCNT;incFail;SLV;10|
              |TESTCNT;incXfPass;SLV;11| |TESTCNT;decXfPass;V;12|
              |TESTCNT;incFatal;SV;13| |TESTCNT;decFatal;V;14|
              |TESTCNT;incXfFatal;SV;15| |TESTCNT;decXfFatal;V;16|
              (48 . |message|) (|List| $) (53 . |pile|)
              |TESTCNT;addWarning;OfV;17| (|OutputPackage|) (58 . |output|)
              (63 . |output|) (|List| 27) (68 . |parts|) (|List| 30)
              (73 . |parts|) (78 . |hconcat|) |TESTCNT;statistics;V;18|)
           '#(|testsuiteNoClear| 84 |testsuite| 89 |testcaseNoClear| 94
              |testcase| 99 |statistics| 104 |incXfPass| 108
              |incXfLibraryError| 114 |incXfFatal| 120 |incXfFail| 125
              |incPass| 129 |incLibraryError| 133 |incFatal| 139 |incFail| 144
              |decXfPass| 150 |decXfFatal| 154 |decFatal| 158 |chkLibraryError|
              162 |addWarning| 166)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST '((|testsuite| ((|Void|) (|String|))) T)
                                   '((|testsuiteNoClear| ((|Void|) (|String|)))
                                     T)
                                   '((|testcase| ((|Void|) (|String|))) T)
                                   '((|testcaseNoClear| ((|Void|) (|String|)))
                                     T)
                                   '((|statistics| ((|Void|))) T)
                                   '((|incPass| ((|Void|))) T)
                                   '((|incFail|
                                      ((|Void|) (|String|)
                                       (|List| (|OutputForm|))))
                                     T)
                                   '((|incXfPass|
                                      ((|Void|) (|String|)
                                       (|List| (|OutputForm|))))
                                     T)
                                   '((|decXfPass| ((|Void|))) T)
                                   '((|incXfFail| ((|Void|))) T)
                                   '((|chkLibraryError| ((|Void|))) T)
                                   '((|incLibraryError|
                                      ((|Void|) (|String|)
                                       (|List| (|OutputForm|))))
                                     T)
                                   '((|incXfLibraryError|
                                      ((|Void|) (|String|)
                                       (|List| (|OutputForm|))))
                                     T)
                                   '((|incFatal| ((|Void|) (|String|))) T)
                                   '((|incXfFatal| ((|Void|) (|String|))) T)
                                   '((|decFatal| ((|Void|))) T)
                                   '((|decXfFatal| ((|Void|))) T)
                                   '((|addWarning| ((|Void|) (|OutputForm|)))
                                     T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 60
                                            '(0 10 0 11 1 18 16 17 19 2 17 0 0
                                              0 22 1 23 16 17 24 0 25 0 26 2 10
                                              0 27 0 28 2 10 25 0 17 29 2 25 0
                                              30 0 31 2 25 9 0 17 34 1 23 0 17
                                              48 1 23 0 49 50 1 52 16 23 53 1
                                              52 16 17 54 1 10 55 0 56 1 25 57
                                              0 58 2 23 0 0 0 59 1 0 16 17 20 1
                                              0 16 17 21 1 0 16 17 32 1 0 16 17
                                              33 0 0 16 60 2 0 16 17 37 42 2 0
                                              16 17 37 39 1 0 16 17 46 0 0 16
                                              40 0 0 16 35 2 0 16 17 37 38 1 0
                                              16 17 44 2 0 16 17 37 41 0 0 16
                                              43 0 0 16 47 0 0 16 45 0 0 16 36
                                              1 0 16 23 51)))))
           '|lookupComplete|)) 

(MAKEPROP '|UnittestCount| 'NILADIC T) 

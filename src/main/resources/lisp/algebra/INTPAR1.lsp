
(SDEFUN |INTPAR1;monologextint;LMMR;1|
        ((|lup| (|List| UP))
         (|csolve|
          (|Mapping| (|List| (|Vector| (|Fraction| (|Integer|))))
                     (|Matrix| F)))
         (|rec1|
          (|Mapping|
           #1=(|Record| (|:| |logands| #2=(|List| F))
                        (|:| |basis|
                             #3=(|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| F)))
         ($
          (|Record| (|:| |logands| (|List| (|Fraction| UP)))
                    (|:| |basis|
                         (|List| (|Vector| (|Fraction| (|Integer|))))))))
        (SPROG
         ((#4=#:G756 NIL) (|i| NIL) (|j| NIL) (#5=#:G755 NIL)
          (|pv| (|Vector| (|Fraction| (|Integer|)))) (#6=#:G753 NIL)
          (|rbv| NIL) (#7=#:G754 NIL) (|bv| NIL)
          (|nl| (|List| (|Fraction| UP))) (#8=#:G752 NIL) (|le| NIL)
          (#9=#:G751 NIL) (|rbl| (|List| (|Vector| (|Fraction| (|Integer|)))))
          (#10=#:G750 NIL) (#11=#:G749 NIL) (|n3| (|NonNegativeInteger|))
          (|n2| (|NonNegativeInteger|)) (|n1| (|NonNegativeInteger|))
          (|bl| #3#) (|ll| #2#) (|#G11| #1#) (|nlc0| (|List| F))
          (#12=#:G748 NIL) (#13=#:G747 NIL)
          (|cb| (|List| (|Vector| (|Fraction| (|Integer|)))))
          (|lup2| (|List| UP)) (#14=#:G745 NIL) (|p| NIL) (#15=#:G746 NIL)
          (|c0| NIL) (#16=#:G744 NIL) (|lc0| (|List| F)) (#17=#:G743 NIL)
          (#18=#:G742 NIL) (|n0| (|NonNegativeInteger|)))
         (SEQ (LETT |n0| (LENGTH |lup|))
              (LETT |lc0|
                    (PROGN
                     (LETT #18# NIL)
                     (SEQ (LETT |p| NIL) (LETT #17# |lup|) G190
                          (COND
                           ((OR (ATOM #17#) (PROGN (LETT |p| (CAR #17#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #18#
                                  (CONS (SPADCALL |p| 0 (QREFELT $ 11))
                                        #18#))))
                          (LETT #17# (CDR #17#)) (GO G190) G191
                          (EXIT (NREVERSE #18#)))))
              (LETT |lup2|
                    (PROGN
                     (LETT #16# NIL)
                     (SEQ (LETT |c0| NIL) (LETT #15# |lc0|) (LETT |p| NIL)
                          (LETT #14# |lup|) G190
                          (COND
                           ((OR (ATOM #14#) (PROGN (LETT |p| (CAR #14#)) NIL)
                                (ATOM #15#) (PROGN (LETT |c0| (CAR #15#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #16#
                                  (CONS
                                   (SPADCALL |p| (SPADCALL |c0| (QREFELT $ 12))
                                             (QREFELT $ 13))
                                   #16#))))
                          (LETT #14# (PROG1 (CDR #14#) (LETT #15# (CDR #15#))))
                          (GO G190) G191 (EXIT (NREVERSE #16#)))))
              (LETT |cb| (SPADCALL |csolve| |lup2| (QREFELT $ 18)))
              (LETT |nlc0|
                    (PROGN
                     (LETT #13# NIL)
                     (SEQ (LETT |bv| NIL) (LETT #12# |cb|) G190
                          (COND
                           ((OR (ATOM #12#) (PROGN (LETT |bv| (CAR #12#)) NIL))
                            (GO G191)))
                          (SEQ
                           (EXIT
                            (LETT #13#
                                  (CONS (SPADCALL |bv| |lc0| (QREFELT $ 22))
                                        #13#))))
                          (LETT #12# (CDR #12#)) (GO G190) G191
                          (EXIT (NREVERSE #13#)))))
              (PROGN
               (LETT |#G11| (SPADCALL |nlc0| |rec1|))
               (LETT |ll| (QCAR |#G11|))
               (LETT |bl| (QCDR |#G11|))
               |#G11|)
              (EXIT
               (COND ((NULL |bl|) (CONS NIL NIL))
                     ('T
                      (SEQ (LETT |n1| (LENGTH |cb|)) (LETT |n2| (LENGTH |ll|))
                           (LETT |n3| (+ |n0| |n2|))
                           (LETT |rbl|
                                 (PROGN
                                  (LETT #11# NIL)
                                  (SEQ (LETT |bv| NIL) (LETT #10# |bl|) G190
                                       (COND
                                        ((OR (ATOM #10#)
                                             (PROGN
                                              (LETT |bv| (CAR #10#))
                                              NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #11#
                                               (CONS
                                                (MAKEARR1 |n3|
                                                          (|spadConstant| $
                                                                          24))
                                                #11#))))
                                       (LETT #10# (CDR #10#)) (GO G190) G191
                                       (EXIT (NREVERSE #11#)))))
                           (LETT |nl|
                                 (PROGN
                                  (LETT #9# NIL)
                                  (SEQ (LETT |le| NIL) (LETT #8# |ll|) G190
                                       (COND
                                        ((OR (ATOM #8#)
                                             (PROGN (LETT |le| (CAR #8#)) NIL))
                                         (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (LETT #9#
                                               (CONS
                                                (SPADCALL
                                                 (SPADCALL |le| (QREFELT $ 12))
                                                 (QREFELT $ 26))
                                                #9#))))
                                       (LETT #8# (CDR #8#)) (GO G190) G191
                                       (EXIT (NREVERSE #9#)))))
                           (SEQ (LETT |bv| NIL) (LETT #7# |bl|)
                                (LETT |rbv| NIL) (LETT #6# |rbl|) G190
                                (COND
                                 ((OR (ATOM #6#)
                                      (PROGN (LETT |rbv| (CAR #6#)) NIL)
                                      (ATOM #7#)
                                      (PROGN (LETT |bv| (CAR #7#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (LETT |pv|
                                       (SPADCALL
                                        (SPADCALL |bv|
                                                  (SPADCALL 1 |n1|
                                                            (QREFELT $ 31))
                                                  (QREFELT $ 32))
                                        |cb| (QREFELT $ 34)))
                                 (SEQ (LETT |i| 1) (LETT #5# |n0|) G190
                                      (COND ((|greater_SI| |i| #5#) (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SPADCALL |rbv| |i|
                                                  (SPADCALL |pv| |i|
                                                            (QREFELT $ 35))
                                                  (QREFELT $ 36))))
                                      (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                      (EXIT NIL))
                                 (EXIT
                                  (SEQ (LETT |j| (+ |n1| 1))
                                       (LETT |i| (+ |n0| 1)) (LETT #4# |n3|)
                                       G190 (COND ((> |i| #4#) (GO G191)))
                                       (SEQ
                                        (EXIT
                                         (SPADCALL |rbv| |i|
                                                   (SPADCALL |bv| |j|
                                                             (QREFELT $ 35))
                                                   (QREFELT $ 36))))
                                       (LETT |i|
                                             (PROG1 (+ |i| 1)
                                               (LETT |j| (+ |j| 1))))
                                       (GO G190) G191 (EXIT NIL))))
                                (LETT #6#
                                      (PROG1 (CDR #6#) (LETT #7# (CDR #7#))))
                                (GO G190) G191 (EXIT NIL))
                           (EXIT (CONS |nl| |rbl|))))))))) 

(SDEFUN |INTPAR1;logextint;MMMMLR;2|
        ((|der| (|Mapping| UP UP)) (|ufactor| (|Mapping| (|Factored| UP) UP))
         (|csolve|
          (|Mapping| #1=(|List| (|Vector| (|Fraction| (|Integer|))))
                     (|Matrix| F)))
         (|rec|
          (|Mapping|
           #2=(|Record| (|:| |logands| (|List| (|Fraction| UP)))
                        (|:| |basis|
                             (|List| (|Vector| (|Fraction| (|Integer|))))))
           (|List| UP)))
         (|lg| (|List| (|Fraction| UP)))
         ($
          (|Record| (|:| |logands| #3=(|List| (|Fraction| UP)))
                    (|:| |basis|
                         #4=(|List| (|Vector| (|Fraction| (|Integer|))))))))
        (SPROG
         ((#5=#:G943 NIL) (|i| NIL) (#6=#:G944 NIL) (|j| NIL) (#7=#:G941 NIL)
          (#8=#:G942 NIL) (|pv| #9=(|Vector| (|Fraction| (|Integer|))))
          (#10=#:G940 NIL) (|bv1| #11=(|Vector| (|Fraction| (|Integer|))))
          (#12=#:G938 NIL) (|rbv| NIL) (#13=#:G939 NIL) (|bv| NIL)
          (|rbas| (|List| (|Vector| (|Fraction| (|Integer|)))))
          (#14=#:G937 NIL) (#15=#:G936 NIL) (|n6| (|NonNegativeInteger|))
          (|n5| #16=(|NonNegativeInteger|)) (|nlog| (|List| (|Fraction| UP)))
          (|rbasl1| (|List| (|Fraction| UP))) (#17=#:G935 NIL) (|up| NIL)
          (#18=#:G934 NIL) (|fbas| #4#) (|flog| #3#) (|#G54| #2#)
          (#19=#:G933 NIL) (|g| NIL) (#20=#:G932 NIL) (|n4| #16#)
          (|lg7| (|List| #21=(|Fraction| UP))) (#22=#:G931 NIL)
          (#23=#:G930 NIL) (|cb4e| (|List| #9#)) (#24=#:G929 NIL)
          (#25=#:G928 NIL) (|ncb2| (|List| #9#)) (#26=#:G927 NIL)
          (#27=#:G926 NIL)
          (|cb4| #28=(|List| (|Vector| (|Fraction| (|Integer|)))))
          (|lg6| (|List| (|Fraction| UP))) (|lrf| (|List| (|Fraction| UP)))
          (|r| (UP)) (|q| (UP))
          (|#G50| #29=(|Record| (|:| |quotient| UP) (|:| |remainder| UP)))
          (|den| (UP)) (#30=#:G925 NIL) (|lg5| (|List| #31=(|Fraction| UP)))
          (#32=#:G923 NIL) (#33=#:G924 NIL) (|pc| NIL) (#34=#:G922 NIL)
          (|lg4| (|List| #31#)) (#35=#:G921 NIL) (|ghr| NIL) (#36=#:G920 NIL)
          (|nlpc| (|List| #21#)) (#37=#:G919 NIL) (#38=#:G918 NIL)
          (|ncb| (|List| #9#)) (#39=#:G917 NIL) (#40=#:G916 NIL)
          (|cb3e| (|List| #11#)) (#41=#:G915 NIL) (#42=#:G914 NIL)
          (|cb3| (|List| #11#)) (#43=#:G913 NIL) (#44=#:G912 NIL) (|cb2| #1#)
          (|rs3| (|Matrix| F)) (|lpc| (|List| (|Fraction| UP))) (|#G41| #29#)
          (|dbj| (UP)) (#45=#:G910 NIL) (#46=#:G911 NIL) (|bj| NIL)
          (#47=#:G908 NIL) (|num| NIL) (#48=#:G909 NIL) (|nl| (|List| UP))
          (|jl| (|List| (|Integer|))) (|fl| (|List| UP)) (|j0| (|Integer|))
          (|j1| (|Integer|)) (|sl1| #49=(|List| (|NonNegativeInteger|)))
          (#50=#:G906 NIL) (#51=#:G907 NIL) (|fj| NIL) (|fl1| (|List| UP))
          (#52=#:G904 NIL) (#53=#:G905 NIL) (|m3| (|Matrix| UP))
          (|n3| (|NonNegativeInteger|)) (|sl| #49#) (#54=#:G903 NIL)
          (#55=#:G902 NIL) (|basl1| (|List| UP))
          (|mbasfl| (|List| (|List| UP))) (#56=#:G901 NIL) (|frr| NIL)
          (#57=#:G900 NIL) (#58=#:G899 NIL) (|mbasp| NIL) (#59=#:G898 NIL)
          (|mbasl| (|List| UP)) (|n1| #16#) (|m2| #60=(|Matrix| (|Integer|)))
          (|mbas| #61=(|Vector| UP))
          (|#G29| (|Record| (|:| |basis| #61#) (|:| |transform| #60#)))
          (|lden1| (|List| UP)) (#62=#:G897 NIL) (#63=#:G896 NIL)
          (|lg3| (|List| #21#)) (#64=#:G895 NIL) (#65=#:G894 NIL)
          (|lg2| (|List| #66=(|Fraction| UP))) (#67=#:G893 NIL)
          (#68=#:G892 NIL) (|cb| #28#) (|lg1| (|List| #69=(|Fraction| UP)))
          (#70=#:G891 NIL) (#71=#:G890 NIL)
          (|lghr|
           (|List|
            (|Record| (|:| |answer| #69#) (|:| |logpart| #66#)
                      (|:| |specpart| (|Fraction| UP)) (|:| |polypart| UP))))
          (#72=#:G889 NIL) (#73=#:G888 NIL) (|n0| #16#))
         (SEQ
          (COND ((NULL |lg|) (CONS NIL NIL))
                (#74='T
                 (SEQ (LETT |n0| (LENGTH |lg|))
                      (LETT |lghr|
                            (PROGN
                             (LETT #73# NIL)
                             (SEQ (LETT |g| NIL) (LETT #72# |lg|) G190
                                  (COND
                                   ((OR (ATOM #72#)
                                        (PROGN (LETT |g| (CAR #72#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #73#
                                          (CONS
                                           (SPADCALL |g| |der| (QREFELT $ 44))
                                           #73#))))
                                  (LETT #72# (CDR #72#)) (GO G190) G191
                                  (EXIT (NREVERSE #73#)))))
                      (LETT |lg1|
                            (PROGN
                             (LETT #71# NIL)
                             (SEQ (LETT |ghr| NIL) (LETT #70# |lghr|) G190
                                  (COND
                                   ((OR (ATOM #70#)
                                        (PROGN (LETT |ghr| (CAR #70#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #71# (CONS (QVELT |ghr| 0) #71#))))
                                  (LETT #70# (CDR #70#)) (GO G190) G191
                                  (EXIT (NREVERSE #71#)))))
                      (LETT |cb| (SPADCALL |csolve| |lg1| (QREFELT $ 46)))
                      (LETT |lg2|
                            (PROGN
                             (LETT #68# NIL)
                             (SEQ (LETT |ghr| NIL) (LETT #67# |lghr|) G190
                                  (COND
                                   ((OR (ATOM #67#)
                                        (PROGN (LETT |ghr| (CAR #67#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #68# (CONS (QVELT |ghr| 1) #68#))))
                                  (LETT #67# (CDR #67#)) (GO G190) G191
                                  (EXIT (NREVERSE #68#)))))
                      (LETT |lg3|
                            (PROGN
                             (LETT #65# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #64# |cb|) G190
                                  (COND
                                   ((OR (ATOM #64#)
                                        (PROGN (LETT |bv| (CAR #64#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #65#
                                          (CONS
                                           (SPADCALL |bv| |lg2| (QREFELT $ 47))
                                           #65#))))
                                  (LETT #64# (CDR #64#)) (GO G190) G191
                                  (EXIT (NREVERSE #65#)))))
                      (LETT |lden1|
                            (PROGN
                             (LETT #63# NIL)
                             (SEQ (LETT |g| NIL) (LETT #62# |lg3|) G190
                                  (COND
                                   ((OR (ATOM #62#)
                                        (PROGN (LETT |g| (CAR #62#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #63#
                                          (CONS (SPADCALL |g| (QREFELT $ 48))
                                                #63#))))
                                  (LETT #62# (CDR #62#)) (GO G190) G191
                                  (EXIT (NREVERSE #63#)))))
                      (PROGN
                       (LETT |#G29|
                             (SPADCALL (SPADCALL |lden1| (QREFELT $ 50))
                                       (QREFELT $ 53)))
                       (LETT |mbas| (QCAR |#G29|))
                       (LETT |m2| (QCDR |#G29|))
                       |#G29|)
                      (LETT |n1| (LENGTH |lg3|))
                      (LETT |mbasl| (SPADCALL |mbas| (QREFELT $ 54)))
                      (LETT |mbasfl|
                            (PROGN
                             (LETT #59# NIL)
                             (SEQ (LETT |mbasp| NIL) (LETT #58# |mbasl|) G190
                                  (COND
                                   ((OR (ATOM #58#)
                                        (PROGN (LETT |mbasp| (CAR #58#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #59#
                                          (CONS
                                           (PROGN
                                            (LETT #57# NIL)
                                            (SEQ (LETT |frr| NIL)
                                                 (LETT #56#
                                                       (SPADCALL
                                                        (SPADCALL |mbasp|
                                                                  |ufactor|)
                                                        (QREFELT $ 59)))
                                                 G190
                                                 (COND
                                                  ((OR (ATOM #56#)
                                                       (PROGN
                                                        (LETT |frr| (CAR #56#))
                                                        NIL))
                                                   (GO G191)))
                                                 (SEQ
                                                  (EXIT
                                                   (LETT #57#
                                                         (CONS (QVELT |frr| 1)
                                                               #57#))))
                                                 (LETT #56# (CDR #56#))
                                                 (GO G190) G191
                                                 (EXIT (NREVERSE #57#))))
                                           #59#))))
                                  (LETT #58# (CDR #58#)) (GO G190) G191
                                  (EXIT (NREVERSE #59#)))))
                      (LETT |basl1|
                            (SPADCALL (ELT $ 61) |mbasfl| NIL (QREFELT $ 64)))
                      (LETT |sl|
                            (PROGN
                             (LETT #55# NIL)
                             (SEQ (LETT #54# |mbasfl|) G190
                                  (COND
                                   ((OR (ATOM #54#)
                                        (PROGN (LETT |fl1| (CAR #54#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #55# (CONS (LENGTH |fl1|) #55#))))
                                  (LETT #54# (CDR #54#)) (GO G190) G191
                                  (EXIT (NREVERSE #55#)))))
                      (LETT |n3| (SPADCALL (ELT $ 69) |sl| 0 (QREFELT $ 72)))
                      (LETT |m3|
                            (MAKE_MATRIX1 |n3| (+ |n1| |n3|)
                                          (|spadConstant| $ 9)))
                      (SEQ (LETT |g| NIL) (LETT #53# |lg3|) (LETT |i| 1)
                           (LETT #52# |n1|) G190
                           (COND
                            ((OR (|greater_SI| |i| #52#) (ATOM #53#)
                                 (PROGN (LETT |g| (CAR #53#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |fl| NIL) (LETT |jl| NIL)
                                (LETT |sl1| |sl|) (LETT |fl1| NIL)
                                (LETT |j0| 1) (LETT |j1| 0)
                                (SEQ (LETT |fj| NIL) (LETT #51# |basl1|)
                                     (LETT |j| 1) (LETT #50# |n3|) G190
                                     (COND
                                      ((OR (|greater_SI| |j| #50#) (ATOM #51#)
                                           (PROGN (LETT |fj| (CAR #51#)) NIL))
                                       (GO G191)))
                                     (SEQ (LETT |j1| (+ |j1| 1))
                                          (COND
                                           ((> |j1| (|SPADfirst| |sl1|))
                                            (SEQ (LETT |sl1| (CDR |sl1|))
                                                 (LETT |j1| 0)
                                                 (EXIT
                                                  (LETT |j0| (+ |j0| 1))))))
                                          (EXIT
                                           (COND
                                            ((EQL
                                              (SPADCALL |m2| |j0| |i|
                                                        (QREFELT $ 74))
                                              1)
                                             (SEQ (LETT |fl| (CONS |fj| |fl|))
                                                  (EXIT
                                                   (LETT |jl|
                                                         (CONS |j| |jl|))))))))
                                     (LETT |j|
                                           (PROG1 (|inc_SI| |j|)
                                             (LETT #51# (CDR #51#))))
                                     (GO G190) G191 (EXIT NIL))
                                (LETT |nl|
                                      (SPADCALL (SPADCALL |g| (QREFELT $ 75))
                                                |fl| (QREFELT $ 77)))
                                (EXIT
                                 (SEQ (LETT |j| NIL) (LETT #48# |jl|)
                                      (LETT |num| NIL) (LETT #47# |nl|) G190
                                      (COND
                                       ((OR (ATOM #47#)
                                            (PROGN (LETT |num| (CAR #47#)) NIL)
                                            (ATOM #48#)
                                            (PROGN (LETT |j| (CAR #48#)) NIL))
                                        (GO G191)))
                                      (SEQ
                                       (EXIT
                                        (SPADCALL |m3| |j| |i| |num|
                                                  (QREFELT $ 79))))
                                      (LETT #47#
                                            (PROG1 (CDR #47#)
                                              (LETT #48# (CDR #48#))))
                                      (GO G190) G191 (EXIT NIL))))
                           (LETT |i|
                                 (PROG1 (|inc_SI| |i|) (LETT #53# (CDR #53#))))
                           (GO G190) G191 (EXIT NIL))
                      (LETT |lpc| NIL)
                      (SEQ (LETT |bj| NIL) (LETT #46# |basl1|) (LETT |j| 1)
                           (LETT #45# |n3|) G190
                           (COND
                            ((OR (|greater_SI| |j| #45#) (ATOM #46#)
                                 (PROGN (LETT |bj| (CAR #46#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |dbj| (SPADCALL |bj| |der|))
                                (PROGN
                                 (LETT |#G41|
                                       (SPADCALL |dbj| |bj| (QREFELT $ 81)))
                                 (LETT |q| (QCAR |#G41|))
                                 (LETT |r| (QCDR |#G41|))
                                 |#G41|)
                                (SPADCALL |m3| |j| (+ |n1| |j|) |r|
                                          (QREFELT $ 79))
                                (EXIT
                                 (LETT |lpc|
                                       (CONS (SPADCALL |q| (QREFELT $ 26))
                                             |lpc|))))
                           (LETT |j|
                                 (PROG1 (|inc_SI| |j|) (LETT #46# (CDR #46#))))
                           (GO G190) G191 (EXIT NIL))
                      (LETT |lpc| (NREVERSE |lpc|))
                      (LETT |rs3| (SPADCALL |m3| (QREFELT $ 84)))
                      (LETT |cb2| (SPADCALL |rs3| |csolve|))
                      (LETT |cb3|
                            (PROGN
                             (LETT #44# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #43# |cb2|) G190
                                  (COND
                                   ((OR (ATOM #43#)
                                        (PROGN (LETT |bv| (CAR #43#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #44#
                                          (CONS
                                           (SPADCALL |bv|
                                                     (SPADCALL 1 |n1|
                                                               (QREFELT $ 31))
                                                     (QREFELT $ 32))
                                           #44#))))
                                  (LETT #43# (CDR #43#)) (GO G190) G191
                                  (EXIT (NREVERSE #44#)))))
                      (LETT |cb3e|
                            (PROGN
                             (LETT #42# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #41# |cb2|) G190
                                  (COND
                                   ((OR (ATOM #41#)
                                        (PROGN (LETT |bv| (CAR #41#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #42#
                                          (CONS
                                           (SPADCALL |bv|
                                                     (SPADCALL (+ |n1| 1)
                                                               (+ |n1| |n3|)
                                                               (QREFELT $ 31))
                                                     (QREFELT $ 32))
                                           #42#))))
                                  (LETT #41# (CDR #41#)) (GO G190) G191
                                  (EXIT (NREVERSE #42#)))))
                      (LETT |ncb|
                            (PROGN
                             (LETT #40# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #39# |cb3|) G190
                                  (COND
                                   ((OR (ATOM #39#)
                                        (PROGN (LETT |bv| (CAR #39#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #40#
                                          (CONS
                                           (SPADCALL |bv| |cb| (QREFELT $ 34))
                                           #40#))))
                                  (LETT #39# (CDR #39#)) (GO G190) G191
                                  (EXIT (NREVERSE #40#)))))
                      (LETT |nlpc|
                            (PROGN
                             (LETT #38# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #37# |cb3e|) G190
                                  (COND
                                   ((OR (ATOM #37#)
                                        (PROGN (LETT |bv| (CAR #37#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #38#
                                          (CONS
                                           (SPADCALL |bv| |lpc| (QREFELT $ 47))
                                           #38#))))
                                  (LETT #37# (CDR #37#)) (GO G190) G191
                                  (EXIT (NREVERSE #38#)))))
                      (LETT |lg4|
                            (PROGN
                             (LETT #36# NIL)
                             (SEQ (LETT |ghr| NIL) (LETT #35# |lghr|) G190
                                  (COND
                                   ((OR (ATOM #35#)
                                        (PROGN (LETT |ghr| (CAR #35#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #36#
                                          (CONS
                                           (SPADCALL
                                            (SPADCALL (QVELT |ghr| 3)
                                                      (QREFELT $ 26))
                                            (QVELT |ghr| 2) (QREFELT $ 65))
                                           #36#))))
                                  (LETT #35# (CDR #35#)) (GO G190) G191
                                  (EXIT (NREVERSE #36#)))))
                      (LETT |lg5|
                            (PROGN
                             (LETT #34# NIL)
                             (SEQ (LETT |pc| NIL) (LETT #33# |nlpc|)
                                  (LETT |bv| NIL) (LETT #32# |ncb|) G190
                                  (COND
                                   ((OR (ATOM #32#)
                                        (PROGN (LETT |bv| (CAR #32#)) NIL)
                                        (ATOM #33#)
                                        (PROGN (LETT |pc| (CAR #33#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #34#
                                          (CONS
                                           (SPADCALL
                                            (SPADCALL |bv| |lg4|
                                                      (QREFELT $ 47))
                                            |pc| (QREFELT $ 65))
                                           #34#))))
                                  (LETT #32#
                                        (PROG1 (CDR #32#)
                                          (LETT #33# (CDR #33#))))
                                  (GO G190) G191 (EXIT (NREVERSE #34#)))))
                      (LETT |lrf| NIL) (LETT |lg6| NIL)
                      (SEQ (LETT |g| NIL) (LETT #30# |lg5|) G190
                           (COND
                            ((OR (ATOM #30#) (PROGN (LETT |g| (CAR #30#)) NIL))
                             (GO G191)))
                           (SEQ (LETT |den| (SPADCALL |g| (QREFELT $ 48)))
                                (PROGN
                                 (LETT |#G50|
                                       (SPADCALL (SPADCALL |g| (QREFELT $ 75))
                                                 |den| (QREFELT $ 81)))
                                 (LETT |q| (QCAR |#G50|))
                                 (LETT |r| (QCDR |#G50|))
                                 |#G50|)
                                (LETT |lrf|
                                      (CONS (SPADCALL |r| |den| (QREFELT $ 85))
                                            |lrf|))
                                (EXIT
                                 (LETT |lg6|
                                       (CONS (SPADCALL |q| (QREFELT $ 26))
                                             |lg6|))))
                           (LETT #30# (CDR #30#)) (GO G190) G191 (EXIT NIL))
                      (LETT |lrf| (NREVERSE |lrf|))
                      (LETT |lg6| (NREVERSE |lg6|))
                      (LETT |cb4| (SPADCALL |csolve| |lrf| (QREFELT $ 46)))
                      (LETT |ncb2|
                            (PROGN
                             (LETT #27# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #26# |cb4|) G190
                                  (COND
                                   ((OR (ATOM #26#)
                                        (PROGN (LETT |bv| (CAR #26#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #27#
                                          (CONS
                                           (SPADCALL |bv| |ncb| (QREFELT $ 34))
                                           #27#))))
                                  (LETT #26# (CDR #26#)) (GO G190) G191
                                  (EXIT (NREVERSE #27#)))))
                      (LETT |cb4e|
                            (PROGN
                             (LETT #25# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #24# |cb4|) G190
                                  (COND
                                   ((OR (ATOM #24#)
                                        (PROGN (LETT |bv| (CAR #24#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #25#
                                          (CONS
                                           (SPADCALL |bv| |cb3e|
                                                     (QREFELT $ 34))
                                           #25#))))
                                  (LETT #24# (CDR #24#)) (GO G190) G191
                                  (EXIT (NREVERSE #25#)))))
                      (LETT |lg7|
                            (PROGN
                             (LETT #23# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #22# |cb4|) G190
                                  (COND
                                   ((OR (ATOM #22#)
                                        (PROGN (LETT |bv| (CAR #22#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #23#
                                          (CONS
                                           (SPADCALL |bv| |lg6| (QREFELT $ 47))
                                           #23#))))
                                  (LETT #22# (CDR #22#)) (GO G190) G191
                                  (EXIT (NREVERSE #23#)))))
                      (LETT |n4| (LENGTH |lg7|))
                      (PROGN
                       (LETT |#G54|
                             (SPADCALL
                              (PROGN
                               (LETT #20# NIL)
                               (SEQ (LETT |g| NIL) (LETT #19# |lg7|) G190
                                    (COND
                                     ((OR (ATOM #19#)
                                          (PROGN (LETT |g| (CAR #19#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (EXIT
                                      (LETT #20#
                                            (CONS (SPADCALL |g| (QREFELT $ 86))
                                                  #20#))))
                                    (LETT #19# (CDR #19#)) (GO G190) G191
                                    (EXIT (NREVERSE #20#))))
                              |rec|))
                       (LETT |flog| (QCAR |#G54|))
                       (LETT |fbas| (QCDR |#G54|))
                       |#G54|)
                      (EXIT
                       (COND ((NULL |fbas|) (CONS NIL NIL))
                             (#74#
                              (SEQ
                               (LETT |rbasl1|
                                     (PROGN
                                      (LETT #18# NIL)
                                      (SEQ (LETT |up| NIL) (LETT #17# |basl1|)
                                           G190
                                           (COND
                                            ((OR (ATOM #17#)
                                                 (PROGN
                                                  (LETT |up| (CAR #17#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #18#
                                                   (CONS
                                                    (SPADCALL |up|
                                                              (QREFELT $ 26))
                                                    #18#))))
                                           (LETT #17# (CDR #17#)) (GO G190)
                                           G191 (EXIT (NREVERSE #18#)))))
                               (LETT |nlog|
                                     (SPADCALL |rbasl1| |flog| (QREFELT $ 87)))
                               (LETT |n5| (LENGTH |flog|))
                               (LETT |n6| (+ (+ |n0| |n3|) |n5|))
                               (LETT |rbas|
                                     (PROGN
                                      (LETT #15# NIL)
                                      (SEQ (LETT |bv| NIL) (LETT #14# |fbas|)
                                           G190
                                           (COND
                                            ((OR (ATOM #14#)
                                                 (PROGN
                                                  (LETT |bv| (CAR #14#))
                                                  NIL))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (LETT #15#
                                                   (CONS
                                                    (MAKEARR1 |n6|
                                                              (|spadConstant| $
                                                                              24))
                                                    #15#))))
                                           (LETT #14# (CDR #14#)) (GO G190)
                                           G191 (EXIT (NREVERSE #15#)))))
                               (SEQ (LETT |bv| NIL) (LETT #13# |fbas|)
                                    (LETT |rbv| NIL) (LETT #12# |rbas|) G190
                                    (COND
                                     ((OR (ATOM #12#)
                                          (PROGN (LETT |rbv| (CAR #12#)) NIL)
                                          (ATOM #13#)
                                          (PROGN (LETT |bv| (CAR #13#)) NIL))
                                      (GO G191)))
                                    (SEQ
                                     (LETT |bv1|
                                           (SPADCALL |bv|
                                                     (SPADCALL 1 |n4|
                                                               (QREFELT $ 31))
                                                     (QREFELT $ 32)))
                                     (LETT |pv|
                                           (SPADCALL |bv1| |ncb2|
                                                     (QREFELT $ 34)))
                                     (SEQ (LETT |i| 1) (LETT #10# |n0|) G190
                                          (COND
                                           ((|greater_SI| |i| #10#) (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (SPADCALL |rbv| |i|
                                                      (SPADCALL |pv| |i|
                                                                (QREFELT $ 35))
                                                      (QREFELT $ 36))))
                                          (LETT |i| (|inc_SI| |i|)) (GO G190)
                                          G191 (EXIT NIL))
                                     (LETT |pv|
                                           (SPADCALL |bv1| |cb4e|
                                                     (QREFELT $ 34)))
                                     (SEQ (LETT |j| 1) (LETT #8# |n3|)
                                          (LETT |i| (+ |n0| 1))
                                          (LETT #7# (+ |n0| |n3|)) G190
                                          (COND
                                           ((OR (> |i| #7#)
                                                (|greater_SI| |j| #8#))
                                            (GO G191)))
                                          (SEQ
                                           (EXIT
                                            (SPADCALL |rbv| |i|
                                                      (SPADCALL |pv| |j|
                                                                (QREFELT $ 35))
                                                      (QREFELT $ 36))))
                                          (LETT |i|
                                                (PROG1 (+ |i| 1)
                                                  (LETT |j| (|inc_SI| |j|))))
                                          (GO G190) G191 (EXIT NIL))
                                     (EXIT
                                      (SEQ (LETT |j| (+ |n4| 1))
                                           (LETT #6# (+ |n4| |n5|))
                                           (LETT |i| (+ (+ |n0| |n3|) 1))
                                           (LETT #5# |n6|) G190
                                           (COND
                                            ((OR (> |i| #5#) (> |j| #6#))
                                             (GO G191)))
                                           (SEQ
                                            (EXIT
                                             (SPADCALL |rbv| |i|
                                                       (SPADCALL |bv| |j|
                                                                 (QREFELT $
                                                                          35))
                                                       (QREFELT $ 36))))
                                           (LETT |i|
                                                 (PROG1 (+ |i| 1)
                                                   (LETT |j| (+ |j| 1))))
                                           (GO G190) G191 (EXIT NIL))))
                                    (LETT #12#
                                          (PROG1 (CDR #12#)
                                            (LETT #13# (CDR #13#))))
                                    (GO G190) G191 (EXIT NIL))
                               (EXIT (CONS |nlog| |rbas|)))))))))))) 

(SDEFUN |INTPAR1;RF_to_GP|
        ((|f| (|Fraction| UP)) ($ (|LaurentPolynomial| F UP)))
        (SPROG ((#1=#:G948 NIL))
               (PROG2
                   (LETT #1#
                         (SPADCALL
                          (SPADCALL (SPADCALL |f| (QREFELT $ 75))
                                    (QREFELT $ 92))
                          (SPADCALL (SPADCALL |f| (QREFELT $ 48))
                                    (QREFELT $ 92))
                          (QREFELT $ 94)))
                   (QCDR #1#)
                 (|check_union2| (QEQCAR #1# 0)
                                 (|LaurentPolynomial| (QREFELT $ 6)
                                                      (QREFELT $ 7))
                                 (|Union|
                                  (|LaurentPolynomial| (QREFELT $ 6)
                                                       (QREFELT $ 7))
                                  "failed")
                                 #1#)))) 

(SDEFUN |INTPAR1;primextint;MMMLL;4|
        ((|der| (|Mapping| UP UP))
         (|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| F)))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| (|Fraction| UP)))
         ($
          (|List|
           (|Record| (|:| |ratpart| (|Fraction| UP))
                     (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1111 NIL) (|bv| NIL) (#2=#:G1112 NIL) (|ba| NIL)
          (#3=#:G1110 NIL) (|nlba| (|List| (|Fraction| UP))) (#4=#:G1108 NIL)
          (#5=#:G1109 NIL) (#6=#:G1107 NIL) (|lba| (|List| (|Fraction| UP)))
          (|cb| (|List| (|Vector| F))) (#7=#:G1105 NIL) (|be| NIL)
          (#8=#:G1106 NIL) (#9=#:G1104 NIL) (|cba| (|List| F))
          (#10=#:G1103 NIL) (#11=#:G1102 NIL) (|ncb| (|List| (|Vector| F)))
          (#12=#:G1101 NIL) (#13=#:G1100 NIL) (|cb0| (|List| (|Vector| F)))
          (#14=#:G1099 NIL) (#15=#:G1098 NIL) (|n1p| (|NonNegativeInteger|))
          (|b2|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|lgj1| (|List| F)) (|ff| (F)) (#16=#:G1096 NIL) (#17=#:G1097 NIL)
          (|aa| NIL) (|lgj| (|List| F)) (|gij| (F)) (|gi| (UP))
          (#18=#:G1095 NIL) (|i| NIL) (|n1| (|NonNegativeInteger|)) (|j| NIL)
          (#19=#:G1094 NIL) (#20=#:G1093 NIL) (|dk| (F))
          (|d| (|NonNegativeInteger|)) (|ldg| (|List| (|NonNegativeInteger|)))
          (#21=#:G1092 NIL) (|g2| NIL) (#22=#:G1091 NIL) (|vg2| (|Vector| UP))
          (|lg2| (|List| UP)) (#23=#:G1090 NIL) (|ghr| NIL) (#24=#:G1089 NIL)
          (#25=#:G1088 NIL) (#26=#:G1087 NIL)
          (|a1l| (|List| #27=(|Fraction| UP))) (#28=#:G1086 NIL)
          (#29=#:G1085 NIL) (|lg1| (|List| #30=(|Fraction| UP)))
          (#31=#:G1084 NIL) (#32=#:G1083 NIL)
          (|lghr|
           (|List|
            (|Record| (|:| |answer| #27#) (|:| |logpart| #30#)
                      (|:| |specpart| (|Fraction| UP)) (|:| |polypart| UP))))
          (#33=#:G1082 NIL) (|g| NIL) (#34=#:G1081 NIL)
          (|n| (|NonNegativeInteger|)))
         (SEQ
          (COND ((NULL |lg|) NIL)
                ('T
                 (SEQ (LETT |n| (LENGTH |lg|))
                      (LETT |lghr|
                            (PROGN
                             (LETT #34# NIL)
                             (SEQ (LETT |g| NIL) (LETT #33# |lg|) G190
                                  (COND
                                   ((OR (ATOM #33#)
                                        (PROGN (LETT |g| (CAR #33#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #34#
                                          (CONS
                                           (SPADCALL |g| |der| (QREFELT $ 44))
                                           #34#))))
                                  (LETT #33# (CDR #33#)) (GO G190) G191
                                  (EXIT (NREVERSE #34#)))))
                      (LETT |lg1|
                            (PROGN
                             (LETT #32# NIL)
                             (SEQ (LETT |ghr| NIL) (LETT #31# |lghr|) G190
                                  (COND
                                   ((OR (ATOM #31#)
                                        (PROGN (LETT |ghr| (CAR #31#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #32# (CONS (QVELT |ghr| 1) #32#))))
                                  (LETT #31# (CDR #31#)) (GO G190) G191
                                  (EXIT (NREVERSE #32#)))))
                      (LETT |cb| (SPADCALL |csolve| |lg1| (QREFELT $ 98)))
                      (LETT |a1l|
                            (PROGN
                             (LETT #29# NIL)
                             (SEQ (LETT |ghr| NIL) (LETT #28# |lghr|) G190
                                  (COND
                                   ((OR (ATOM #28#)
                                        (PROGN (LETT |ghr| (CAR #28#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #29# (CONS (QVELT |ghr| 0) #29#))))
                                  (LETT #28# (CDR #28#)) (GO G190) G191
                                  (EXIT (NREVERSE #29#)))))
                      (LETT |lba|
                            (PROGN
                             (LETT #26# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #25# |cb|) G190
                                  (COND
                                   ((OR (ATOM #25#)
                                        (PROGN (LETT |bv| (CAR #25#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #26#
                                          (CONS (|spadConstant| $ 99) #26#))))
                                  (LETT #25# (CDR #25#)) (GO G190) G191
                                  (EXIT (NREVERSE #26#)))))
                      (LETT |lg2|
                            (PROGN
                             (LETT #24# NIL)
                             (SEQ (LETT |ghr| NIL) (LETT #23# |lghr|) G190
                                  (COND
                                   ((OR (ATOM #23#)
                                        (PROGN (LETT |ghr| (CAR #23#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #24# (CONS (QVELT |ghr| 3) #24#))))
                                  (LETT #23# (CDR #23#)) (GO G190) G191
                                  (EXIT (NREVERSE #24#)))))
                      (LETT |vg2| (SPADCALL |lg2| (QREFELT $ 50)))
                      (LETT |ldg|
                            (PROGN
                             (LETT #22# NIL)
                             (SEQ (LETT |g2| NIL) (LETT #21# |lg2|) G190
                                  (COND
                                   ((OR (ATOM #21#)
                                        (PROGN (LETT |g2| (CAR #21#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #22#
                                          (CONS (SPADCALL |g2| (QREFELT $ 100))
                                                #22#))))
                                  (LETT #21# (CDR #21#)) (GO G190) G191
                                  (EXIT (NREVERSE #22#)))))
                      (LETT |d| (SPADCALL (ELT $ 101) |ldg| (QREFELT $ 102)))
                      (LETT |dk|
                            (SPADCALL
                             (SPADCALL
                              (SPADCALL (|spadConstant| $ 27) 1
                                        (QREFELT $ 103))
                              |der|)
                             (QREFELT $ 104)))
                      (LETT |cba|
                            (PROGN
                             (LETT #20# NIL)
                             (SEQ (LETT |bv| NIL) (LETT #19# |cb|) G190
                                  (COND
                                   ((OR (ATOM #19#)
                                        (PROGN (LETT |bv| (CAR #19#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #20#
                                          (CONS (|spadConstant| $ 8) #20#))))
                                  (LETT #19# (CDR #19#)) (GO G190) G191
                                  (EXIT (NREVERSE #20#)))))
                      (SEQ (LETT |j| |d|) G190 (COND ((< |j| 0) (GO G191)))
                           (SEQ (LETT |n1| (LENGTH |cb|)) (LETT |lgj| NIL)
                                (SEQ (LETT |i| 1) (LETT #18# |n|) G190
                                     (COND ((|greater_SI| |i| #18#) (GO G191)))
                                     (SEQ
                                      (LETT |gi|
                                            (SPADCALL |vg2| |i|
                                                      (QREFELT $ 105)))
                                      (LETT |gij| (|spadConstant| $ 8))
                                      (COND
                                       ((EQL (SPADCALL |gi| (QREFELT $ 100))
                                             |j|)
                                        (SEQ
                                         (LETT |gij|
                                               (SPADCALL |gi| (QREFELT $ 106)))
                                         (EXIT
                                          (SPADCALL |vg2| |i|
                                                    (SPADCALL |gi|
                                                              (QREFELT $ 107))
                                                    (QREFELT $ 108))))))
                                      (EXIT (LETT |lgj| (CONS |gij| |lgj|))))
                                     (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                     (EXIT NIL))
                                (LETT |lgj| (NREVERSE |lgj|)) (LETT |lgj1| NIL)
                                (SEQ (LETT |aa| NIL) (LETT #17# |cba|)
                                     (LETT |bv| NIL) (LETT #16# |cb|) G190
                                     (COND
                                      ((OR (ATOM #16#)
                                           (PROGN (LETT |bv| (CAR #16#)) NIL)
                                           (ATOM #17#)
                                           (PROGN (LETT |aa| (CAR #17#)) NIL))
                                       (GO G191)))
                                     (SEQ
                                      (LETT |ff|
                                            (SPADCALL
                                             (SPADCALL |bv| |lgj|
                                                       (QREFELT $ 110))
                                             (SPADCALL
                                              (SPADCALL
                                               (SPADCALL (+ |j| 1)
                                                         (QREFELT $ 111))
                                               |dk| (QREFELT $ 112))
                                              |aa| (QREFELT $ 112))
                                             (QREFELT $ 113)))
                                      (EXIT (LETT |lgj1| (CONS |ff| |lgj1|))))
                                     (LETT #16#
                                           (PROG1 (CDR #16#)
                                             (LETT #17# (CDR #17#))))
                                     (GO G190) G191 (EXIT NIL))
                                (LETT |lgj1| (NREVERSE |lgj1|))
                                (LETT |b2| (SPADCALL (CONS |dk| |lgj1|) |ext|))
                                (LETT |n1p| (+ |n1| 1))
                                (LETT |cb0|
                                      (PROGN
                                       (LETT #15# NIL)
                                       (SEQ (LETT |be| NIL) (LETT #14# |b2|)
                                            G190
                                            (COND
                                             ((OR (ATOM #14#)
                                                  (PROGN
                                                   (LETT |be| (CAR #14#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #15#
                                                    (CONS
                                                     (SPADCALL (QCDR |be|)
                                                               (SPADCALL 2
                                                                         |n1p|
                                                                         (QREFELT
                                                                          $
                                                                          31))
                                                               (QREFELT $ 114))
                                                     #15#))))
                                            (LETT #14# (CDR #14#)) (GO G190)
                                            G191 (EXIT (NREVERSE #15#)))))
                                (LETT |ncb|
                                      (PROGN
                                       (LETT #13# NIL)
                                       (SEQ (LETT |bv| NIL) (LETT #12# |cb0|)
                                            G190
                                            (COND
                                             ((OR (ATOM #12#)
                                                  (PROGN
                                                   (LETT |bv| (CAR #12#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #13#
                                                    (CONS
                                                     (SPADCALL |bv| |cb|
                                                               (QREFELT $ 115))
                                                     #13#))))
                                            (LETT #12# (CDR #12#)) (GO G190)
                                            G191 (EXIT (NREVERSE #13#)))))
                                (LETT |cba|
                                      (PROGN
                                       (LETT #11# NIL)
                                       (SEQ (LETT |be| NIL) (LETT #10# |b2|)
                                            G190
                                            (COND
                                             ((OR (ATOM #10#)
                                                  (PROGN
                                                   (LETT |be| (CAR #10#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #11#
                                                    (CONS (QCAR |be|) #11#))))
                                            (LETT #10# (CDR #10#)) (GO G190)
                                            G191 (EXIT (NREVERSE #11#)))))
                                (LETT |nlba|
                                      (PROGN
                                       (LETT #9# NIL)
                                       (SEQ (LETT |bv| NIL) (LETT #8# |cb0|)
                                            (LETT |be| NIL) (LETT #7# |b2|)
                                            G190
                                            (COND
                                             ((OR (ATOM #7#)
                                                  (PROGN
                                                   (LETT |be| (CAR #7#))
                                                   NIL)
                                                  (ATOM #8#)
                                                  (PROGN
                                                   (LETT |bv| (CAR #8#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (EXIT
                                              (LETT #9#
                                                    (CONS
                                                     (SPADCALL
                                                      (SPADCALL
                                                       (SPADCALL |bv| |lba|
                                                                 (QREFELT $
                                                                          116))
                                                       (SPADCALL
                                                        (SPADCALL (QCAR |be|)
                                                                  |j|
                                                                  (QREFELT $
                                                                           103))
                                                        (QREFELT $ 26))
                                                       (QREFELT $ 65))
                                                      (SPADCALL
                                                       (SPADCALL
                                                        (SPADCALL
                                                         (SPADCALL (QCDR |be|)
                                                                   1
                                                                   (QREFELT $
                                                                            117))
                                                         (SPADCALL (+ |j| 1)
                                                                   (QREFELT $
                                                                            111))
                                                         (QREFELT $ 118))
                                                        (+ |j| 1)
                                                        (QREFELT $ 103))
                                                       (QREFELT $ 26))
                                                      (QREFELT $ 65))
                                                     #9#))))
                                            (LETT #7#
                                                  (PROG1 (CDR #7#)
                                                    (LETT #8# (CDR #8#))))
                                            (GO G190) G191
                                            (EXIT (NREVERSE #9#)))))
                                (LETT |cb| |ncb|) (EXIT (LETT |lba| |nlba|)))
                           (LETT |j| (+ |j| -1)) (GO G190) G191 (EXIT NIL))
                      (LETT |nlba|
                            (PROGN
                             (LETT #6# NIL)
                             (SEQ (LETT |ba| NIL) (LETT #5# |lba|)
                                  (LETT |bv| NIL) (LETT #4# |cb|) G190
                                  (COND
                                   ((OR (ATOM #4#)
                                        (PROGN (LETT |bv| (CAR #4#)) NIL)
                                        (ATOM #5#)
                                        (PROGN (LETT |ba| (CAR #5#)) NIL))
                                    (GO G191)))
                                  (SEQ
                                   (EXIT
                                    (LETT #6#
                                          (CONS
                                           (SPADCALL |ba|
                                                     (SPADCALL |bv| |a1l|
                                                               (QREFELT $ 116))
                                                     (QREFELT $ 119))
                                           #6#))))
                                  (LETT #4#
                                        (PROG1 (CDR #4#) (LETT #5# (CDR #5#))))
                                  (GO G190) G191 (EXIT (NREVERSE #6#)))))
                      (EXIT
                       (PROGN
                        (LETT #3# NIL)
                        (SEQ (LETT |ba| NIL) (LETT #2# |nlba|) (LETT |bv| NIL)
                             (LETT #1# |cb|) G190
                             (COND
                              ((OR (ATOM #1#) (PROGN (LETT |bv| (CAR #1#)) NIL)
                                   (ATOM #2#)
                                   (PROGN (LETT |ba| (CAR #2#)) NIL))
                               (GO G191)))
                             (SEQ
                              (EXIT (LETT #3# (CONS (CONS |ba| |bv|) #3#))))
                             (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                             (GO G190) G191 (EXIT (NREVERSE #3#))))))))))) 

(SDEFUN |INTPAR1;expextint;MMMLL;5|
        ((|der| (|Mapping| UP UP))
         (|rde|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|Integer|) (|List| F)))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| (|Fraction| UP)))
         ($
          (|List|
           (|Record| (|:| |ratpart| (|Fraction| UP))
                     (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#1=#:G1244 NIL) (|bv| NIL) (#2=#:G1245 NIL) (|bar| NIL)
          (#3=#:G1243 NIL) (|lbar| (|List| (|Fraction| UP))) (#4=#:G1241 NIL)
          (#5=#:G1242 NIL) (|ba| NIL) (#6=#:G1240 NIL) (|j| #7=(|Integer|))
          (|lba| (|List| (|LaurentPolynomial| F UP)))
          (|cb| (|List| (|Vector| F)))
          (|nlba| (|List| #8=(|LaurentPolynomial| F UP))) (#9=#:G1239 NIL)
          (|be| NIL) (#10=#:G1238 NIL) (|ncb| (|List| (|Vector| F)))
          (#11=#:G1237 NIL) (#12=#:G1236 NIL) (#13=#:G1221 NIL)
          (|b2|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F)))))
          (|lgj1| (|List| F)) (|ff| (F)) (#14=#:G1235 NIL) (|lgj| (|List| F))
          (#15=#:G1220 NIL) (|gij| (F)) (|last_iter| (|Boolean|))
          (|gi| (|LaurentPolynomial| F UP)) (#16=#:G1234 NIL) (|i| NIL)
          (|d| #7#) (|ldg| (|List| (|Integer|))) (#17=#:G1233 NIL) (|g2| NIL)
          (#18=#:G1232 NIL) (|vg2| (|Vector| (|LaurentPolynomial| F UP)))
          (|lg2| (|List| #8#)) (#19=#:G1231 NIL) (|ghr| NIL) (#20=#:G1230 NIL)
          (#21=#:G1229 NIL) (#22=#:G1228 NIL)
          (|a1l| (|List| #23=(|Fraction| UP))) (#24=#:G1227 NIL)
          (#25=#:G1226 NIL) (|lg1| (|List| #26=(|Fraction| UP)))
          (#27=#:G1225 NIL) (#28=#:G1224 NIL)
          (|lghr|
           (|List|
            (|Record| (|:| |answer| #23#) (|:| |logpart| #26#)
                      (|:| |specpart| (|Fraction| UP)) (|:| |polypart| UP))))
          (#29=#:G1223 NIL) (|g| NIL) (#30=#:G1222 NIL))
         (SEQ
          (EXIT
           (COND ((NULL |lg|) NIL)
                 ('T
                  (SEQ
                   (LETT |lghr|
                         (PROGN
                          (LETT #30# NIL)
                          (SEQ (LETT |g| NIL) (LETT #29# |lg|) G190
                               (COND
                                ((OR (ATOM #29#)
                                     (PROGN (LETT |g| (CAR #29#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #30#
                                       (CONS
                                        (SPADCALL |g| |der| (QREFELT $ 44))
                                        #30#))))
                               (LETT #29# (CDR #29#)) (GO G190) G191
                               (EXIT (NREVERSE #30#)))))
                   (LETT |lg1|
                         (PROGN
                          (LETT #28# NIL)
                          (SEQ (LETT |ghr| NIL) (LETT #27# |lghr|) G190
                               (COND
                                ((OR (ATOM #27#)
                                     (PROGN (LETT |ghr| (CAR #27#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT (LETT #28# (CONS (QVELT |ghr| 1) #28#))))
                               (LETT #27# (CDR #27#)) (GO G190) G191
                               (EXIT (NREVERSE #28#)))))
                   (LETT |cb| (SPADCALL |csolve| |lg1| (QREFELT $ 98)))
                   (LETT |a1l|
                         (PROGN
                          (LETT #25# NIL)
                          (SEQ (LETT |ghr| NIL) (LETT #24# |lghr|) G190
                               (COND
                                ((OR (ATOM #24#)
                                     (PROGN (LETT |ghr| (CAR #24#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT (LETT #25# (CONS (QVELT |ghr| 0) #25#))))
                               (LETT #24# (CDR #24#)) (GO G190) G191
                               (EXIT (NREVERSE #25#)))))
                   (LETT |lba|
                         (PROGN
                          (LETT #22# NIL)
                          (SEQ (LETT |bv| NIL) (LETT #21# |cb|) G190
                               (COND
                                ((OR (ATOM #21#)
                                     (PROGN (LETT |bv| (CAR #21#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #22#
                                       (CONS (|spadConstant| $ 125) #22#))))
                               (LETT #21# (CDR #21#)) (GO G190) G191
                               (EXIT (NREVERSE #22#)))))
                   (LETT |lg2|
                         (PROGN
                          (LETT #20# NIL)
                          (SEQ (LETT |ghr| NIL) (LETT #19# |lghr|) G190
                               (COND
                                ((OR (ATOM #19#)
                                     (PROGN (LETT |ghr| (CAR #19#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #20#
                                       (CONS
                                        (SPADCALL
                                         (SPADCALL (QVELT |ghr| 3)
                                                   (QREFELT $ 92))
                                         (|INTPAR1;RF_to_GP| (QVELT |ghr| 2) $)
                                         (QREFELT $ 126))
                                        #20#))))
                               (LETT #19# (CDR #19#)) (GO G190) G191
                               (EXIT (NREVERSE #20#)))))
                   (LETT |vg2| (SPADCALL |lg2| (QREFELT $ 129)))
                   (LETT |ldg|
                         (PROGN
                          (LETT #18# NIL)
                          (SEQ (LETT |g2| NIL) (LETT #17# |lg2|) G190
                               (COND
                                ((OR (ATOM #17#)
                                     (PROGN (LETT |g2| (CAR #17#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #18#
                                       (CONS (SPADCALL |g2| (QREFELT $ 130))
                                             #18#))))
                               (LETT #17# (CDR #17#)) (GO G190) G191
                               (EXIT (NREVERSE #18#)))))
                   (LETT |d| (SPADCALL (ELT $ 131) |ldg| (QREFELT $ 134)))
                   (LETT |j| |d|)
                   (SEQ
                    (EXIT
                     (SEQ G190 NIL
                          (SEQ (LETT |last_iter| 'T) (LETT |lgj| NIL)
                               (SEQ (LETT |i| 1) (LETT #16# (QVSIZE |vg2|))
                                    G190
                                    (COND ((|greater_SI| |i| #16#) (GO G191)))
                                    (SEQ
                                     (LETT |gi|
                                           (SPADCALL |vg2| |i|
                                                     (QREFELT $ 135)))
                                     (LETT |gij| (|spadConstant| $ 8))
                                     (COND
                                      ((SPADCALL |gi| (|spadConstant| $ 125)
                                                 (QREFELT $ 137))
                                       (SEQ (LETT |last_iter| NIL)
                                            (EXIT
                                             (COND
                                              ((EQL
                                                (SPADCALL |gi| (QREFELT $ 130))
                                                |j|)
                                               (SEQ
                                                (LETT |gij|
                                                      (SPADCALL |gi|
                                                                (QREFELT $
                                                                         138)))
                                                (EXIT
                                                 (SPADCALL |vg2| |i|
                                                           (SPADCALL |gi|
                                                                     (QREFELT $
                                                                              139))
                                                           (QREFELT $
                                                                    140))))))))))
                                     (EXIT (LETT |lgj| (CONS |gij| |lgj|))))
                                    (LETT |i| (|inc_SI| |i|)) (GO G190) G191
                                    (EXIT NIL))
                               (EXIT
                                (COND
                                 (|last_iter|
                                  (PROGN
                                   (LETT #15# |$NoValue|)
                                   (GO #31=#:G1211)))
                                 ('T
                                  (SEQ (LETT |lgj| (NREVERSE |lgj|))
                                       (LETT |lgj1| NIL)
                                       (SEQ (LETT |bv| NIL) (LETT #14# |cb|)
                                            G190
                                            (COND
                                             ((OR (ATOM #14#)
                                                  (PROGN
                                                   (LETT |bv| (CAR #14#))
                                                   NIL))
                                              (GO G191)))
                                            (SEQ
                                             (LETT |ff|
                                                   (SPADCALL |bv| |lgj|
                                                             (QREFELT $ 110)))
                                             (EXIT
                                              (LETT |lgj1|
                                                    (CONS |ff| |lgj1|))))
                                            (LETT #14# (CDR #14#)) (GO G190)
                                            G191 (EXIT NIL))
                                       (LETT |lgj1| (NREVERSE |lgj1|))
                                       (LETT |b2| (SPADCALL |j| |lgj1| |rde|))
                                       (EXIT
                                        (COND
                                         ((NULL |b2|)
                                          (PROGN
                                           (LETT #13# NIL)
                                           (GO #32=#:G1219)))
                                         ('T
                                          (SEQ
                                           (LETT |ncb|
                                                 (PROGN
                                                  (LETT #12# NIL)
                                                  (SEQ (LETT |be| NIL)
                                                       (LETT #11# |b2|) G190
                                                       (COND
                                                        ((OR (ATOM #11#)
                                                             (PROGN
                                                              (LETT |be|
                                                                    (CAR #11#))
                                                              NIL))
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (LETT #12#
                                                               (CONS
                                                                (SPADCALL
                                                                 (QCDR |be|)
                                                                 |cb|
                                                                 (QREFELT $
                                                                          115))
                                                                #12#))))
                                                       (LETT #11# (CDR #11#))
                                                       (GO G190) G191
                                                       (EXIT
                                                        (NREVERSE #12#)))))
                                           (LETT |nlba|
                                                 (PROGN
                                                  (LETT #10# NIL)
                                                  (SEQ (LETT |be| NIL)
                                                       (LETT #9# |b2|) G190
                                                       (COND
                                                        ((OR (ATOM #9#)
                                                             (PROGN
                                                              (LETT |be|
                                                                    (CAR #9#))
                                                              NIL))
                                                         (GO G191)))
                                                       (SEQ
                                                        (EXIT
                                                         (LETT #10#
                                                               (CONS
                                                                (SPADCALL
                                                                 (SPADCALL
                                                                  (QCDR |be|)
                                                                  |lba|
                                                                  (QREFELT $
                                                                           141))
                                                                 (SPADCALL
                                                                  (QCAR |be|)
                                                                  |j|
                                                                  (QREFELT $
                                                                           142))
                                                                 (QREFELT $
                                                                          126))
                                                                #10#))))
                                                       (LETT #9# (CDR #9#))
                                                       (GO G190) G191
                                                       (EXIT
                                                        (NREVERSE #10#)))))
                                           (LETT |cb| |ncb|)
                                           (LETT |lba| |nlba|)
                                           (EXIT (LETT |j| (- |j| 1))))))))))))
                          NIL (GO G190) G191 (EXIT NIL)))
                    #31# (EXIT #15#))
                   (LETT |lbar|
                         (PROGN
                          (LETT #6# NIL)
                          (SEQ (LETT |ba| NIL) (LETT #5# |lba|) (LETT |bv| NIL)
                               (LETT #4# |cb|) G190
                               (COND
                                ((OR (ATOM #4#)
                                     (PROGN (LETT |bv| (CAR #4#)) NIL)
                                     (ATOM #5#)
                                     (PROGN (LETT |ba| (CAR #5#)) NIL))
                                 (GO G191)))
                               (SEQ
                                (EXIT
                                 (LETT #6#
                                       (CONS
                                        (SPADCALL
                                         (SPADCALL |ba| (QREFELT $ 143))
                                         (SPADCALL |bv| |a1l| (QREFELT $ 116))
                                         (QREFELT $ 119))
                                        #6#))))
                               (LETT #4#
                                     (PROG1 (CDR #4#) (LETT #5# (CDR #5#))))
                               (GO G190) G191 (EXIT (NREVERSE #6#)))))
                   (EXIT
                    (PROGN
                     (LETT #3# NIL)
                     (SEQ (LETT |bar| NIL) (LETT #2# |lbar|) (LETT |bv| NIL)
                          (LETT #1# |cb|) G190
                          (COND
                           ((OR (ATOM #1#) (PROGN (LETT |bv| (CAR #1#)) NIL)
                                (ATOM #2#) (PROGN (LETT |bar| (CAR #2#)) NIL))
                            (GO G191)))
                          (SEQ (EXIT (LETT #3# (CONS (CONS |bar| |bv|) #3#))))
                          (LETT #1# (PROG1 (CDR #1#) (LETT #2# (CDR #2#))))
                          (GO G190) G191 (EXIT (NREVERSE #3#)))))))))
          #32# (EXIT #13#)))) 

(SDEFUN |INTPAR1;diffextint1|
        ((|trim| (|Mapping| UP (|Fraction| UP)))
         (|ext|
          (|Mapping|
           #1=(|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| UP)))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| (|Fraction| UP)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((#2=#:G1266 NIL) (|re| NIL) (#3=#:G1265 NIL) (|res1| #1#)
          (|lup1| (|List| UP)) (#4=#:G1264 NIL) (|bv| NIL) (#5=#:G1263 NIL)
          (|cb| (|List| (|Vector| F))) (|lg1| (|List| (|Fraction| UP)))
          (#6=#:G1261 NIL) (|g| NIL) (#7=#:G1262 NIL) (|up| NIL)
          (#8=#:G1260 NIL) (|lup| (|List| UP)) (#9=#:G1259 NIL)
          (#10=#:G1258 NIL))
         (SEQ
          (LETT |lup|
                (PROGN
                 (LETT #10# NIL)
                 (SEQ (LETT |g| NIL) (LETT #9# |lg|) G190
                      (COND
                       ((OR (ATOM #9#) (PROGN (LETT |g| (CAR #9#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT (LETT #10# (CONS (SPADCALL |g| |trim|) #10#))))
                      (LETT #9# (CDR #9#)) (GO G190) G191
                      (EXIT (NREVERSE #10#)))))
          (LETT |lg1|
                (PROGN
                 (LETT #8# NIL)
                 (SEQ (LETT |up| NIL) (LETT #7# |lup|) (LETT |g| NIL)
                      (LETT #6# |lg|) G190
                      (COND
                       ((OR (ATOM #6#) (PROGN (LETT |g| (CAR #6#)) NIL)
                            (ATOM #7#) (PROGN (LETT |up| (CAR #7#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #8#
                              (CONS
                               (SPADCALL |g| (SPADCALL |up| (QREFELT $ 26))
                                         (QREFELT $ 119))
                               #8#))))
                      (LETT #6# (PROG1 (CDR #6#) (LETT #7# (CDR #7#))))
                      (GO G190) G191 (EXIT (NREVERSE #8#)))))
          (LETT |cb| (SPADCALL |csolve| |lg1| (QREFELT $ 98)))
          (LETT |lup1|
                (PROGN
                 (LETT #5# NIL)
                 (SEQ (LETT |bv| NIL) (LETT #4# |cb|) G190
                      (COND
                       ((OR (ATOM #4#) (PROGN (LETT |bv| (CAR #4#)) NIL))
                        (GO G191)))
                      (SEQ
                       (EXIT
                        (LETT #5#
                              (CONS (SPADCALL |bv| |lup| (QREFELT $ 146))
                                    #5#))))
                      (LETT #4# (CDR #4#)) (GO G190) G191
                      (EXIT (NREVERSE #5#)))))
          (LETT |res1| (SPADCALL |lup1| |ext|))
          (EXIT
           (PROGN
            (LETT #3# NIL)
            (SEQ (LETT |re| NIL) (LETT #2# |res1|) G190
                 (COND
                  ((OR (ATOM #2#) (PROGN (LETT |re| (CAR #2#)) NIL))
                   (GO G191)))
                 (SEQ
                  (EXIT
                   (LETT #3#
                         (CONS
                          (CONS (QCAR |re|)
                                (SPADCALL (QCDR |re|) |cb| (QREFELT $ 115)))
                          #3#))))
                 (LETT #2# (CDR #2#)) (GO G190) G191 (EXIT (NREVERSE #3#)))))))) 

(SDEFUN |INTPAR1;lin_part| ((|f| (|Fraction| UP)) ($ (UP)))
        (SPROG ((|p| (UP)))
               (SEQ
                (LETT |p|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 75))
                                (SPADCALL |f| (QREFELT $ 48)) (QREFELT $ 147)))
                (EXIT
                 (SPADCALL
                  (SPADCALL (SPADCALL |p| 1 (QREFELT $ 11)) 1 (QREFELT $ 103))
                  (SPADCALL (SPADCALL |p| 0 (QREFELT $ 11)) (QREFELT $ 12))
                  (QREFELT $ 68)))))) 

(SDEFUN |INTPAR1;diffextint;MMLL;8|
        ((|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| UP)))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| (|Fraction| UP)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (|INTPAR1;diffextint1| (CONS #'|INTPAR1;diffextint;MMLL;8!0| $) |ext|
         |csolve| |lg| $)) 

(SDEFUN |INTPAR1;diffextint;MMLL;8!0| ((|x| NIL) ($ NIL))
        (|INTPAR1;lin_part| |x| $)) 

(SDEFUN |INTPAR1;coeff0| ((|f| (|Fraction| UP)) ($ (UP)))
        (SPROG ((|p| (UP)))
               (SEQ
                (LETT |p|
                      (SPADCALL (SPADCALL |f| (QREFELT $ 75))
                                (SPADCALL |f| (QREFELT $ 48)) (QREFELT $ 147)))
                (EXIT
                 (SPADCALL (SPADCALL |p| 0 (QREFELT $ 11)) (QREFELT $ 12)))))) 

(SDEFUN |INTPAR1;unkextint;MMLL;10|
        ((|ext|
          (|Mapping|
           (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
           (|List| F)))
         (|csolve| (|Mapping| (|List| (|Vector| F)) (|Matrix| F)))
         (|lg| (|List| (|Fraction| UP)))
         ($ (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))))
        (SPROG
         ((|ext1|
           (|Mapping|
            (|List| (|Record| (|:| |ratpart| F) (|:| |coeffs| (|Vector| F))))
            (|List| UP))))
         (SEQ
          (LETT |ext1| (CONS #'|INTPAR1;unkextint;MMLL;10!0| (VECTOR |ext| $)))
          (EXIT
           (|INTPAR1;diffextint1| (CONS #'|INTPAR1;unkextint;MMLL;10!1| $)
            |ext1| |csolve| |lg| $))))) 

(SDEFUN |INTPAR1;unkextint;MMLL;10!1| ((|x| NIL) ($ NIL))
        (|INTPAR1;coeff0| |x| $)) 

(SDEFUN |INTPAR1;unkextint;MMLL;10!0| ((|lup| NIL) ($$ NIL))
        (PROG ($ |ext|)
          (LETT $ (QREFELT $$ 1))
          (LETT |ext| (QREFELT $$ 0))
          (RETURN
           (PROGN
            (SPROG ((|lf| NIL) (#1=#:G1282 NIL) (|p| NIL) (#2=#:G1281 NIL))
                   (SEQ
                    (LETT |lf|
                          (PROGN
                           (LETT #2# NIL)
                           (SEQ (LETT |p| NIL) (LETT #1# |lup|) G190
                                (COND
                                 ((OR (ATOM #1#)
                                      (PROGN (LETT |p| (CAR #1#)) NIL))
                                  (GO G191)))
                                (SEQ
                                 (EXIT
                                  (LETT #2#
                                        (CONS (SPADCALL |p| (QREFELT $ 104))
                                              #2#))))
                                (LETT #1# (CDR #1#)) (GO G190) G191
                                (EXIT (NREVERSE #2#)))))
                    (EXIT (SPADCALL |lf| |ext|)))))))) 

(DECLAIM (NOTINLINE |ParametricTranscendentalIntegration;|)) 

(DEFUN |ParametricTranscendentalIntegration| (&REST #1=#:G1288)
  (SPROG NIL
         (PROG (#2=#:G1289)
           (RETURN
            (COND
             ((LETT #2#
                    (|lassocShiftWithFunction| (|devaluateList| #1#)
                                               (HGET |$ConstructorCache|
                                                     '|ParametricTranscendentalIntegration|)
                                               '|domainEqualList|))
              (|CDRwithIncrement| #2#))
             ('T
              (UNWIND-PROTECT
                  (PROG1
                      (APPLY
                       (|function| |ParametricTranscendentalIntegration;|) #1#)
                    (LETT #2# T))
                (COND
                 ((NOT #2#)
                  (HREM |$ConstructorCache|
                        '|ParametricTranscendentalIntegration|)))))))))) 

(DEFUN |ParametricTranscendentalIntegration;| (|#1| |#2|)
  (SPROG ((|pv$| NIL) ($ NIL) (|dv$| NIL) (DV$2 NIL) (DV$1 NIL))
         (PROGN
          (LETT DV$1 (|devaluate| |#1|))
          (LETT DV$2 (|devaluate| |#2|))
          (LETT |dv$| (LIST '|ParametricTranscendentalIntegration| DV$1 DV$2))
          (LETT $ (GETREFV 152))
          (QSETREFV $ 0 |dv$|)
          (QSETREFV $ 3 (LETT |pv$| (|buildPredVector| 0 0 NIL)))
          (|haddProp| |$ConstructorCache|
                      '|ParametricTranscendentalIntegration| (LIST DV$1 DV$2)
                      (CONS 1 $))
          (|stuffDomainSlots| $)
          (QSETREFV $ 6 |#1|)
          (QSETREFV $ 7 |#2|)
          (SETF |pv$| (QREFELT $ 3))
          $))) 

(MAKEPROP '|ParametricTranscendentalIntegration| '|infovec|
          (LIST
           '#(NIL NIL NIL NIL NIL NIL (|local| |#1|) (|local| |#2|)
              (0 . |Zero|) (4 . |Zero|) (|NonNegativeInteger|)
              (8 . |coefficient|) (14 . |coerce|) (19 . -) (|List| 19)
              (|Mapping| 14 82) (|List| 7) (|LiftLinearDependence| 6 23 7)
              (25 . |csolve_pol|) (|Vector| 23) (|List| 6)
              (|LinearCombinationUtilities| 6 7) (31 . |lin_comb|)
              (|Fraction| 29) (37 . |Zero|) (|Fraction| 7) (41 . |coerce|)
              (46 . |One|) (50 . |One|) (|Integer|) (|UniversalSegment| 29)
              (54 . SEGMENT) (60 . |elt|)
              (|LinearCombinationUtilities| 23
                                            (|SparseUnivariatePolynomial| 23))
              (66 . |lin_comb|) (72 . |elt|) (78 . |setelt!|)
              (|Record| (|:| |logands| 45) (|:| |basis| 14))
              (|Record| (|:| |logands| 20) (|:| |basis| 14)) (|Mapping| 38 20)
              |INTPAR1;monologextint;LMMR;1|
              (|Record| (|:| |answer| 25) (|:| |logpart| 25)
                        (|:| |specpart| 25) (|:| |polypart| 7))
              (|Mapping| 7 7) (|TranscendentalHermiteIntegration| 6 7)
              (85 . |HermiteIntegrate|) (|List| 25) (91 . |csolve_rf|)
              (97 . |lin_comb|) (103 . |denom|) (|Vector| 7) (108 . |vector|)
              (|Record| (|:| |basis| 49) (|:| |transform| 73)) (|GcdBasis| 7)
              (113 . |gcdDecomposition|) (118 . |entries|)
              (|Union| '"nil" '"sqfr" '"irred" '"prime")
              (|Record| (|:| |flag| 55) (|:| |factor| 7) (|:| |exponent| 10))
              (|List| 56) (|Factored| 7) (123 . |factorList|) (128 . |concat|)
              (134 . |concat|) (|Mapping| 16 16 16) (|List| 16)
              (140 . |reduce|) (147 . +) (153 . +) (159 . +) (165 . +)
              (171 . +) (|Mapping| 10 10 10) (|List| 10) (177 . |reduce|)
              (|Matrix| 29) (184 . |elt|) (191 . |numer|)
              (|PartialFractionUtilities| 6 7) (196 . |decompose|) (|Matrix| 7)
              (202 . |setelt!|)
              (|Record| (|:| |quotient| $) (|:| |remainder| $))
              (210 . |divide|) (|Matrix| 6) (|Matrix| $)
              (216 . |reducedSystem|) (221 . /) (227 . |retract|)
              (232 . |concat|) (|Mapping| 58 7) (|Mapping| 37 16)
              |INTPAR1;logextint;MMMMLR;2| (|LaurentPolynomial| 6 7)
              (238 . |coerce|) (|Union| $ '"failed") (243 . |exquo|)
              (|List| 109) (|Mapping| 95 82) (|LiftLinearDependence| 6 6 7)
              (249 . |csolve_rf|) (255 . |Zero|) (259 . |degree|) (264 . |max|)
              (270 . |reduce|) (276 . |monomial|) (282 . |retract|)
              (287 . |elt|) (293 . |leadingCoefficient|) (298 . |reductum|)
              (303 . |setelt!|) (|Vector| 6) (310 . |lin_comb|)
              (316 . |coerce|) (321 . *) (327 . +) (333 . |elt|)
              (339 . |lin_comb|) (345 . |lin_comb|) (351 . |elt|) (357 . /)
              (363 . -) (|Record| (|:| |ratpart| 25) (|:| |coeffs| 109))
              (|List| 120) (|Record| (|:| |ratpart| 6) (|:| |coeffs| 109))
              (|Mapping| 148 20) |INTPAR1;primextint;MMMLL;4| (369 . |Zero|)
              (373 . +) (|List| 91) (|Vector| 91) (379 . |vector|)
              (384 . |degree|) (389 . |max|) (|Mapping| 29 29 29) (|List| 29)
              (395 . |reduce|) (401 . |elt|) (|Boolean|) (407 . ~=)
              (413 . |leadingCoefficient|) (418 . |reductum|) (423 . |setelt!|)
              (430 . |lin_comb|) (436 . |monomial|) (442 . |convert|)
              (|Mapping| 148 29 20) |INTPAR1;expextint;MMMLL;5|
              (447 . |lin_comb|) (453 . |quo|) (|List| 122) (|Mapping| 148 16)
              |INTPAR1;diffextint;MMLL;8| |INTPAR1;unkextint;MMLL;10|)
           '#(|unkextint| 459 |primextint| 466 |monologextint| 474 |logextint|
              481 |expextint| 490 |diffextint| 498)
           'NIL
           (CONS (|makeByteWordVec2| 1 '(0))
                 (CONS '#(NIL)
                       (CONS
                        '#((|Join|
                            (|mkCategory|
                             (LIST
                              '((|primextint|
                                 ((|List|
                                   (|Record| (|:| |ratpart| (|Fraction| |#2|))
                                             (|:| |coeffs| (|Vector| |#1|))))
                                  (|Mapping| |#2| |#2|)
                                  (|Mapping|
                                   (|List|
                                    (|Record| (|:| |ratpart| |#1|)
                                              (|:| |coeffs| (|Vector| |#1|))))
                                   (|List| |#1|))
                                  (|Mapping| (|List| (|Vector| |#1|))
                                             (|Matrix| |#1|))
                                  (|List| (|Fraction| |#2|))))
                                T)
                              '((|expextint|
                                 ((|List|
                                   (|Record| (|:| |ratpart| (|Fraction| |#2|))
                                             (|:| |coeffs| (|Vector| |#1|))))
                                  (|Mapping| |#2| |#2|)
                                  (|Mapping|
                                   (|List|
                                    (|Record| (|:| |ratpart| |#1|)
                                              (|:| |coeffs| (|Vector| |#1|))))
                                   (|Integer|) (|List| |#1|))
                                  (|Mapping| (|List| (|Vector| |#1|))
                                             (|Matrix| |#1|))
                                  (|List| (|Fraction| |#2|))))
                                T)
                              '((|diffextint|
                                 ((|List|
                                   (|Record| (|:| |ratpart| |#1|)
                                             (|:| |coeffs| (|Vector| |#1|))))
                                  (|Mapping|
                                   (|List|
                                    (|Record| (|:| |ratpart| |#1|)
                                              (|:| |coeffs| (|Vector| |#1|))))
                                   (|List| |#2|))
                                  (|Mapping| (|List| (|Vector| |#1|))
                                             (|Matrix| |#1|))
                                  (|List| (|Fraction| |#2|))))
                                T)
                              '((|unkextint|
                                 ((|List|
                                   (|Record| (|:| |ratpart| |#1|)
                                             (|:| |coeffs| (|Vector| |#1|))))
                                  (|Mapping|
                                   (|List|
                                    (|Record| (|:| |ratpart| |#1|)
                                              (|:| |coeffs| (|Vector| |#1|))))
                                   (|List| |#1|))
                                  (|Mapping| (|List| (|Vector| |#1|))
                                             (|Matrix| |#1|))
                                  (|List| (|Fraction| |#2|))))
                                T)
                              '((|logextint|
                                 ((|Record|
                                   (|:| |logands| (|List| (|Fraction| |#2|)))
                                   (|:| |basis|
                                        (|List|
                                         (|Vector| (|Fraction| (|Integer|))))))
                                  (|Mapping| |#2| |#2|)
                                  (|Mapping| (|Factored| |#2|) |#2|)
                                  (|Mapping|
                                   (|List| (|Vector| (|Fraction| (|Integer|))))
                                   (|Matrix| |#1|))
                                  (|Mapping|
                                   (|Record|
                                    (|:| |logands| (|List| (|Fraction| |#2|)))
                                    (|:| |basis|
                                         (|List|
                                          (|Vector|
                                           (|Fraction| (|Integer|))))))
                                   (|List| |#2|))
                                  (|List| (|Fraction| |#2|))))
                                T)
                              '((|monologextint|
                                 ((|Record|
                                   (|:| |logands| (|List| (|Fraction| |#2|)))
                                   (|:| |basis|
                                        (|List|
                                         (|Vector| (|Fraction| (|Integer|))))))
                                  (|List| |#2|)
                                  (|Mapping|
                                   (|List| (|Vector| (|Fraction| (|Integer|))))
                                   (|Matrix| |#1|))
                                  (|Mapping|
                                   (|Record| (|:| |logands| (|List| |#1|))
                                             (|:| |basis|
                                                  (|List|
                                                   (|Vector|
                                                    (|Fraction|
                                                     (|Integer|))))))
                                   (|List| |#1|))))
                                T))
                             (LIST) NIL NIL)))
                        (|makeByteWordVec2| 151
                                            '(0 6 0 8 0 7 0 9 2 7 6 0 10 11 1 7
                                              0 6 12 2 7 0 0 0 13 2 17 14 15 16
                                              18 2 21 6 19 20 22 0 23 0 24 1 25
                                              0 7 26 0 6 0 27 0 7 0 28 2 30 0
                                              29 29 31 2 19 0 0 30 32 2 33 19
                                              19 14 34 2 19 23 0 29 35 3 19 23
                                              0 29 23 36 2 43 41 25 42 44 2 17
                                              14 15 45 46 2 21 25 19 45 47 1 25
                                              7 0 48 1 49 0 16 50 1 52 51 49 53
                                              1 49 16 0 54 1 58 57 0 59 2 19 0
                                              0 0 60 2 16 0 0 0 61 3 63 16 62 0
                                              16 64 2 25 0 0 0 65 2 23 0 0 0 66
                                              2 19 0 0 0 67 2 7 0 0 0 68 2 10 0
                                              0 0 69 3 71 10 70 0 10 72 3 73 29
                                              0 29 29 74 1 25 7 0 75 2 76 16 7
                                              16 77 4 78 7 0 29 29 7 79 2 7 80
                                              0 0 81 1 7 82 83 84 2 25 0 7 7 85
                                              1 25 7 0 86 2 45 0 0 0 87 1 91 0
                                              7 92 2 91 93 0 0 94 2 97 95 96 45
                                              98 0 25 0 99 1 7 10 0 100 2 10 0
                                              0 0 101 2 71 10 70 0 102 2 7 0 6
                                              10 103 1 7 6 0 104 2 49 7 0 29
                                              105 1 7 6 0 106 1 7 0 0 107 3 49
                                              7 0 29 7 108 2 21 6 109 20 110 1
                                              6 0 29 111 2 6 0 0 0 112 2 6 0 0
                                              0 113 2 109 0 0 30 114 2 21 109
                                              109 95 115 2 21 25 109 45 116 2
                                              109 6 0 29 117 2 6 0 0 0 118 2 25
                                              0 0 0 119 0 91 0 125 2 91 0 0 0
                                              126 1 128 0 127 129 1 91 29 0 130
                                              2 29 0 0 0 131 2 133 29 132 0 134
                                              2 128 91 0 29 135 2 91 136 0 0
                                              137 1 91 6 0 138 1 91 0 0 139 3
                                              128 91 0 29 91 140 2 21 91 109
                                              127 141 2 91 0 6 29 142 1 91 25 0
                                              143 2 21 7 109 16 146 2 7 0 0 0
                                              147 3 0 148 123 96 45 151 4 0 121
                                              42 123 96 45 124 3 0 37 16 15 39
                                              40 5 0 37 42 88 15 89 45 90 4 0
                                              121 42 144 96 45 145 3 0 148 149
                                              96 45 150)))))
           '|lookupComplete|)) 

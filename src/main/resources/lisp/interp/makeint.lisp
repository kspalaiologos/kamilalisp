(progn (load "./interp-proclaims.lisp"))
(load #-:ecl "util" #+:ecl "./util.lisp")
(in-package "BOOT")
(progn (setq boot::|$build_date|    "Wed Jun 22 11:03:51 PM HKT 2022")        (setq boot::|$build_version| "FriCAS 1.3.8"))
#+:ecl(setf fricas-lisp::*fricas-initial-lisp-objects* (append fricas-lisp::*fricas-initial-lisp-objects*  (quote (
 "../boot/initial-env.fasl"  "../boot/ptyout.fasl"  "../boot/btincl2.fasl"  "../boot/btscan2.fasl"  "../boot/typrops.fasl"  "../boot/btpile2.fasl"  "../boot/typars.fasl"  "../boot/tytree1.fasl"
))))
(build-interpsys (quote ( "vmlisp.fasl"  "hashcode.fasl"  "as.fasl"  "foam_l.fasl"  "macros.fasl"  "setq.fasl"  "buildom.fasl"  "cattable.fasl"  "clam.fasl"  "clammed.fasl"  "compat.fasl"  "compress.fasl"  "cparse.fasl"  "cstream.fasl"  "database.fasl"  "format.fasl"  "g-boot.fasl"  "g-cndata.fasl"  "g-error.fasl"  "g-opt.fasl"  "g-timer.fasl"  "g-util.fasl"  "hypertex.fasl"  "i-analy.fasl"  "i-coerce.fasl"  "i-coerfn.fasl"  "i-eval.fasl"  "i-funsel.fasl"  "i-intern.fasl"  "i-map.fasl"  "i-output.fasl"  "i-resolv.fasl"  "i-spec1.fasl"  "i-spec2.fasl"  "i-syscmd.fasl"  "i-toplev.fasl"  "incl.fasl"  "interop.fasl"  "int-top.fasl"  "lisplib.fasl"  "macex.fasl"  "match.fasl"  "msg.fasl"  "msgdb.fasl"  "nlib.fasl"  "nrunfast.fasl"  "nrungo.fasl"  "nrunopt.fasl"  "pathname.fasl"  "pf2sex.fasl"  "pile.fasl"  "posit.fasl"  "ptrees.fasl"  "rulesets.fasl"  "scan.fasl"  "serror.fasl"  "server.fasl"  "setvars.fasl"  "sfsfun.fasl"  "simpbool.fasl"  "slam.fasl"  "spad.fasl"  "termrw.fasl"  "trace.fasl"  "daase.fasl"  "ncomp.fasl"  "parsing.fasl"  "parse.fasl"  "postpar.fasl"  "setvart.fasl"  "s-parser.fasl"  "scwrap2.fasl"  "spaderror.fasl"  "ax.fasl"  "bc-matrix.fasl"  "bc-misc.fasl"  "bc-solve.fasl"  "ht-util.fasl"  "htsetvar.fasl"  "ht-root.fasl"  "br-con.fasl"  "br-data.fasl"  "showimp.fasl"  "br-op1.fasl"  "br-op2.fasl"  "br-search.fasl"  "br-util.fasl"  "br-saturn.fasl"  "apply.fasl"  "c-doc.fasl"  "c-util.fasl"  "category.fasl"  "compiler.fasl"  "define.fasl"  "functor.fasl"  "info.fasl"  "iterator.fasl"  "modemap.fasl"  "nruncomp.fasl"  "package.fasl"  "htcheck.fasl")) "/tmp/fricas-1.3.8/target/x86_64-linux-gnu")
(in-package "BOOT")
#-:ecl(|clearClams|)
#+:GCL (setq compiler::*suppress-compiler-notes* t)
#+:GCL (si::gbc-time 0)

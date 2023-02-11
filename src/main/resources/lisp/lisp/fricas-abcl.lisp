(in-package "FRICAS-LISP")

(defun exit-with-status (s) (cl-user::quit))

(defmacro fricas-foreign-call (&rest arguments) NIL)

(defun get-current-directory ()
    (trim-directory-name (namestring (truename ""))))

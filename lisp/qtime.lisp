#!/usr/bin/env clisp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Copyright ©2017 Klaus Alexander Seistrup <klaus@seistrup.dk>
;;
;; Version: 0.1.2 (2017-03-28)
;;
;; This program is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 3 of the License, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful, but with-
;; out any warranty; without even the implied warranty of merchantability or
;; fitness for a particular purpose. See the GNU General Public License for
;; more details. <http://gplv3.fsf.org/>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; qtime
(defun qtime ()
   "Returns current local time as an English sentence"
   (setq adjust
      (+ (truncate
            (+ (rem
                  (multiple-value-bind
                     (ss mm hh dd mmm yyyy dow dst-p tz)
                     (get-decoded-time)
                     (+ (* (+ (* hh 60) mm) 60) ss))
                  (* 60 60 24))
               30) 60) 27))

   (setq hours
      (rem (truncate adjust 60) 12))
   (setq minutes
      (rem adjust 60))
   (setq divisions
      (- (truncate minutes 5) 5))

   (setq elms
      (list
         (nth (rem minutes 5)
            '("nearly " "almost " "" "just after " "after "))
         (nth (abs divisions)
            '("" "five " "ten " "a quarter "
                "twenty " "twenty-five " "half "))
         (cond
            ((< divisions 0) "to ")
            ((> divisions 0) "past ")
            (""))
	 (format nil "~r" (if (= hours 0) 12 hours))))

   (format nil "~{~A~}"
      (if (= divisions 0)
         (append elms '(" o'clock")) elms)))

;;; Do you have the time?
(princ (format nil "It's ~A." (qtime)))

;;;; eof

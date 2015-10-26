
(def appusage ()
  (prn "  to run a script:    sudoarc foo.l")
  (prn "  to get a repl:      sudoarc")
  (prn ""))

(def script? (name)
  (endswith name ".l")
  (endswith name ".arc"))

(def appmain (argv)
  (when (none? (or argv ()))
    (return (repl)))
  (let (op (at argv 0)
        params (cut argv 1))
    ; help.
    (when (in? op (list "-h" "--help" "help"))
      (appusage)
      (return))
    ; run a lumen script.
    (when (script? op)
      (return (load op)))
    ; repl.
    (when (= op "repl")
      (return))) ; lumen's (main) will start a repl.
  ; eval files.
  (step arg argv
    (if (dir? arg) (monkitree arg)
        (script? arg) (load arg)
        (error (cat "unknown cmd " arg)))))
(appmain (args))



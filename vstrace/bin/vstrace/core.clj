(ns vstrace.core (:gen-class))
(use '[clojure.java.shell :only [sh]])
(import '(java.io File))

(defn run-prog [pr-args]
  (prn pr-args)
        (let [run-result (apply sh pr-args)
              EXIT_SUCCESS 0]
                (shutdown-agents) ; http://tinyurl.com/java-shell-takes-minute
                (println (:out run-result))
                (println (:err run-result))
                (when (not= (:exit run-result) EXIT_SUCCESS)
                        (throw (Exception."Execution failed!")))))

(defn mktemp-dir []
        (let [temp (. File createTempFile "vstrace-" ".tmp")]
                (. temp delete)
                (when-not (. temp mkdir)
                        (throw (Exception. 
                                (format "Can't create temporary directory: %s!" temp))))
                (. temp deleteOnExit)
                (. temp getPath)))

(defn run-in-strace [prog out-dir]
        (let [full-cmd 
                ["strace"
                 "-D"
                 "-ff"
                 "-ttt"
                 "-v"
                 "-x"
                 "-y"
                 "-s" "255"
                 "-o" (str out-dir "/strace-out")
                 "--"
                 prog]]
        (run-prog full-cmd)))

(defn -main [prog-to-run]
        (let [out-dir (mktemp-dir)]
        ; check if the right strace is available?
                (run-in-strace prog-to-run out-dir)))

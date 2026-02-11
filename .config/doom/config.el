;;; config.el --- Minimal loader for literate modules -*- lexical-binding: t; -*-

(load! "lisp/99-local")       ; User identity
(load! "lisp/00-system")      ; System & environment
(load! "lisp/10-thinking")    ; Writing & thinking
(load! "lisp/11-snippets")    ; YASnippet config
(load! "lisp/90-controls")    ; Keybindings

;; Machine specifics  -*- lexical-binding: t; -*-

(set-face-attribute 'default nil :family "Menlo" :height 130)

;; Left Option is Meta
;; Right Option acts normally -> Right Option + 3 = #
(setq mac-option-modifier 'meta)
(setq mac-right-option-modifier 'nil)

;; Fix native comp warnings on macOS 27.0
(require 'comp)
(setq native-comp-driver-options (cons "-mmacosx-version-min=11" native-comp-driver-options))

(provide 'MKA-4011.local)

;;; ~/.doom.d/bindings.el -*- lexical-binding: t; -*-

;;; :completion
;;; complete when pressing Tab instead of Enter
(map! (:when (featurep! :completion company)
       (:after company
        (:map company-active-map
         "TAB"     #'company-complete
         [tab]     #'company-complete
        )
       )
      )
)

(evil-ex-define-cmd "W" #'evil-write)
(evil-ex-define-cmd "Q" #'evil-quit)
(evil-ex-define-cmd "Wq" #'evil-save-and-quit)
(evil-ex-define-cmd "WQ" #'evil-save-and-quit)

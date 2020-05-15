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

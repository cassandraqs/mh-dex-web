(in-package :mh-dex-web)

(def-widget page-group ((active-page :attribute))
  (:main ((style :display "inline-block"
                 :padding-bottom "20px"
                 :flex-grow 1))
         (:about-page ((active-page active-page)))
         (map (lambda (x)
                (:app-page ((name x) 
                            (key (+ "page:" x))
                            (active-page active-page) )))
              (array "monster-page" "weapon-page" "armor-page"
                     "map-page" "quest-page" "item-page" "searcher-page"
                     "misc-page"))))

(def-widget main-app-view ((active-page :state "about-page") )
  (labels ((component-did-mount ()
             (funcall (@ component-handler upgrade-dom))
             nil)

           (component-did-update ()
             (funcall (@ component-handler upgrade-dom))
             nil)

           ;; Callback to switch the active page.
           (switch-active-page (page)
             (trace page)
             (update-state active-page page)
             nil))
    
    (:div ((class "mdl-layout" "mdl-js-layout" "has-drawer" "mdl-layout--fixed-header"))
          (:app-header ())
          (:app-drawer ())
          (:main ((class "mdl-layout__content"))
                 (:div ((class "mdl-grid" "mdl-grid--no-spacing"))
                       (:div ((class "nav-and-content"
                                     "mdl-cell" "mdl-cell--12-col")
                              (style :display "flex"))
                             (:app-navigation ((switch-page-callback (@ this switch-active-page))
                                               (active-page (:state active-page))))
                             (:page-group ((active-page (:state active-page))))))
                 (:app-footer ())))))

(let ((*template-path* 
       (merge-pathnames "templates/template.html"
                        (asdf:system-source-directory :mh-dex-web))))
  (def-app dex ()
    :title "MH4G Dex"
    :icon "assets/images/favico.png"
    :port 5120
    :system :mh-dex-web
    :includes ("assets/js/environment.js"
               "assets/js/page.js")
    :static-root (merge-pathnames "assets/"
                                  (asdf:system-source-directory :mh-dex-web))
    :widget (:main-app-view ())))

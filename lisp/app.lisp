(in-package :mh-dex-web)

(def-widget main-app-view ()
  (labels ((component-did-mount ()
             (funcall (@ component-handler upgrade-element)
                      (funcall (@ *react find-d-o-m-node) this))
             nil))
    (:div ((class "mdl-layout" "mdl-js-layout" "has-drawer" "mdl-layout--fixed-header"))
          (:app-header ())
          (:app-drawer ())
          (:main ((class "mdl-layout__content"))
                 (:div ((class "mdl-grid" "mdl-grid--no-spacing"))
                       (:div ((class "nav-and-content"
                                     "mdl-cell" "mdl-cell--12-col")
                              (style :display "flex"))
                             (:app-navigation ())
                             (:main ((style :display "inline-block"
                                            :padding-bottom "20px"
                                            :flex-grow 1))
                                    (:about-page ((is-active true)))
                                    (:app-page ((link "monster-page")
                                                (is-active false)))
                                    (:app-page ((link "weapon-page")
                                                (is-active false)))
                                    (:app-page ((link "armor-page")
                                                (is-active false))))))
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

                      

  
  



               
        
      
      
    

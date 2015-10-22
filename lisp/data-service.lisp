(in-package :mh-dex-web.data-service)

(defvar *database* nil
  "The special variable that represents the current database. Overload
   it before any database call.")

(defparameter *dex-database-path*
  (merge-pathnames "data/mh4g.db"
                   (asdf:system-source-directory :mh-dex-web))
  "The path to the dex SQLite database.")

(defclass base-object ()
  ((id :type (unsigned-byte 32) :initarg :id)
   (name :type 'list :initarg :name)))

(defclass equippable-object (base-object)
  ((defense :type (signed-byte 32) :initarg :defense)
   (slots :type (unsigned-byte 8) :initarg :slots)
   (rare :type (unsigned-byte 32) :initarg :rare)))


;; -------------------- Helpers --------------------

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro do-query (&body body)
    `(sqlite:execute-to-list
      *database*
      ,(format nil "~{~a~^ ~};"
               (loop for form in body
                  collect (ecase (car form)
                            (:select (format nil "SELECT ~{~a~^, ~}"
                                             (rest form)))
                            (:from (format nil "FROM ~a" (second form)))
                            (:where (format nil "WHERE ~{~a~^ AND ~}"
                                            (rest form)))
                            (:limit (format nil "LIMIT ~a" (second form)))
                            (:group-by (format nil "GROUP BY ~{~a~^, ~}"
                                               (rest form)))
                            (:inner-join (format nil "INNER JOIN ~a ON ~a"
                                                 (second form)
                                                 (third form)))
                            (:order-by (format nil "ORDER BY ~{~a~^, ~}"
                                               (rest form)))))))))

;; -------------------- Weapon --------------------

(defclass special-attack ()
  ((type-id :type (unsigned-byte 32) :initarg :type-id)
   (damage :type (unsigned-byte 32) :initarg :damage)
   (awaken :type (or boolean keyword) :initarg :awaken)))

(defmethod %to-json ((object special-attack))
  (with-object
    (write-key-value "typeId" (slot-value object 'type-id))
    (write-key-value "damage" (slot-value object 'damage))
    (write-key-value "awaken" (slot-value object 'awaken))))
  
(defclass weapon (equippable-object)
  ((type :type (unsigned-byte 32) :initarg :type)
   (damage :type (unsigned-byte 32) :initarg :damage)
   (affinity :type (signed-byte 32) :initarg :affinity)
   (parent :type (unsigned-byte 32) :initarg :parent)
   (children :type 'list :initarg :children)
   (sharpness :type 'list :initarg :sharpness)
   (special :type 'list :initarg :special)))

(defclass weapon-entry-output ()
  ((id :type (unsigned-byte 32) :initarg :id)
   (sub-id :type (unsigned-byte 32) :initarg :sub-id)
   (name :type 'string :initarg :name)
   (type :type (unsigned-byte 32) :initarg :type)
   (damage :type (unsigned-byte 32) :initarg :damage)
   (affinity :type (signed-byte 32) :initarg :affinity)
   (defense :type (signed-byte 32) :initarg :defense)
   (slots :type (unsigned-byte 8) :initarg :slots)
   (rare :type (unsigned-byte 32) :initarg :rare)
   (sharpness :type 'list :initarg :sharpness)
   (special :type 'list :initarg :special)))

(defmethod %to-json ((object weapon-entry-output))
  (with-object
    (write-key-value "id" (slot-value object 'id))
    (write-key-value "subId" (slot-value object 'sub-id))
    (write-key-value "name" (slot-value object 'name))
    (write-key-value "type" (slot-value object 'type))
    (write-key-value "rare" (slot-value object 'rare))
    (write-key-value "slots" (slot-value object 'slots))
    (write-key-value "damage" (slot-value object 'damage))
    (write-key-value "affinity" (slot-value object 'affinity))
    (write-key-value "sharpness" (slot-value object 'sharpness))
    (write-key-value "special" (slot-value object 'special))
    (write-key-value "defense" (slot-value object 'defense))))

(defparameter *weapon-list* nil)

(defun convert-sharpness (sharp-string)
  (let ((result (rest (loop for start from 0 to 14 by 2
                           collect (handler-case 
                                       (parse-integer (subseq sharp-string 
                                                              start (+ start 2)))
                                     (t () 0))))))
    (pop result)
    (loop while (and result (zerop (car result)))
       do (pop result))
    (nreverse result)))

(defun convert-special (type-a damage-a type-b damage-b awaken)
  (let ((result nil))
    (labels ((maybe-push-special (type damage awaken)
               (when (plusp type)
                 (push (make-instance 'special-attack 
                                      :type-id type
                                      :damage damage
                                      :awaken (or (plusp awaken) :false))
                       result))))
      (maybe-push-special type-a damage-a awaken)
      (maybe-push-special type-b damage-b awaken))
    result))

(defun update-weapon-list ()
  (sqlite:with-open-database (*database* *dex-database-path*)
    (let* ((result (do-query 
                     (:select "DB_Wpn.Wpn_ID" "Wpn_Type_ID" "Child" "Rare" "Atk"
                              "Slot" "Affinity" "Def" "Sharp"
                              "SpAtk1_ID" "SpAtk1_Pt" "SpAtk2_ID" "SpAtk2_Pt" "SpAtk_H"
                              "Wpn_Name_0" "Wpn_Name_1" "Wpn_Name_3")
                     (:from "DB_Wpn")
                     (:inner-join "ID_Wpn_Name" "DB_Wpn.Wpn_ID = ID_Wpn_Name.Wpn_ID")
                     (:order-by "DB_Wpn.Wpn_ID")))
           (current-stack nil)
           (contents
            (cons (make-instance 'weapon)
                  (loop for (id type-id child rare attack slot affinity defense sharp
                                special-id-1 special-points-1 
                                special-id-2 special-points-2 special-awaken
                                name-en name-chs name-jp)
                     in result
                     collect (make-instance 'weapon 
                                            :id id
                                            :name (list :en name-en
                                                        :chs name-chs
                                                        :jp name-jp)
                                            :type type-id
                                            :defense defense
                                            :slots slot
                                            :affinity (round (* affinity 100))
                                            :rare rare
                                            :special (convert-special special-id-1 
                                                                      special-points-1
                                                                      special-id-2
                                                                      special-points-2
                                                                      special-awaken)
                                            :sharpness (convert-sharpness sharp)
                                            :damage attack)))))
      (setf *weapon-list* (make-array (length contents)
                                      :initial-contents contents)))))

(defun ensure-weapon-list ()
  (unless *weapon-list*
    (update-weapon-list)))

(defun convert-to-weapon-entry-output (object language)
  (make-instance 'weapon-entry-output
                 :id (slot-value object 'id)
                 :sub-id 1
                 :name (getf (slot-value object 'name) language)
                 :type (slot-value object 'type)
                 :rare (slot-value object 'rare)
                 :slots (slot-value object 'slots)
                 :affinity (slot-value object 'affinity)
                 :defense (slot-value object 'defense)
                 :sharpness (slot-value object 'sharpness)
                 :special (slot-value object 'special)
                 :damage (slot-value object 'damage)))

(defun get-weapon-entries (language &optional weapon-type)
  (let ((result (loop 
                   for weapon across *weapon-list*
                   for id from 0
                   when (and (plusp id)
                             (or (null weapon-type)
                                 (= (slot-value weapon 'type)
                                    weapon-type)))
                   collect (convert-to-weapon-entry-output weapon language))))
    (loop 
       for weapon in result
       for sub-id from 0
       do (setf (slot-value weapon 'sub-id) sub-id))
    result))

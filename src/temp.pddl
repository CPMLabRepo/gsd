(define (domain greenhouse)
  (:requirements :strips :typing)
  #(:types block)


  (:predicates (location ?x - square) 
               (at ?z - thing ?x - square)
               (square-conn ?x - square ?y - square)
               (plant-watered ?x - square)
	       (have ?z - thing)
               (holding ?h - hand)
               (handempty)
               (left-item ?z - thing ?x - square)
	       (can-act)
               (left-item-checked)
               (watered-checked)
               (fluents-check)
           )

(:action human-can-act
:parameters ()
:precondition
(and
( robot-can-act )

)
:effect
(and
( human-can-act )

)
)

(:action human-move
:parameters (?from ?to)
:precondition
(and
( human-can-act )
( human-location ?from )
( human-square-conn ?from ?to )

)
:effect
(and
( human-location ?to )
(not ( human-location ?from ))
)
)

(:action human-pick-up
:parameters (?thing ?square ?hand)
:precondition
(and
( human-can-act )
( human-location ?square )
( human-at ?thing ?square )
( human-handempty ?hand )

)
:effect
(and
( human-have ?thing )
( human-holding ?hand )
(not ( human-at ?thing ?square ))
(not ( human-handempty ?hand ))
)
)

(:action human-put-down
:parameters (?thing ?square ?hand)
:precondition
(and


)
:effect
(and
( human-handempty ?hand )
( human-at ?thing ?square )
(not ( human-have ?thing ))
(not ( human-holding ?hand ))
)
)

(:action human-spray
:parameters (?thing ?square)
:precondition
(and


)
:effect
(and
( human-plant-watered ?square )

)
)

(:action robot-can-act
:parameters ()
:precondition
(and
( robot-can-act )
( human-can-act )

)
:effect
(and
( robot-can-act )
( human-can-act )

)
)

(:action robot-move
:parameters (?from ?to)
:precondition
(and
( robot-can-act )
( robot-location ?from )
( robot-square-conn ?from ?to )

)
:effect
(and
( robot-location ?to )
(not ( robot-location ?from ))
)
)

(:action robot-pick-up
:parameters (?thing ?square ?hand)
:precondition
(and
( robot-can-act )
( robot-location ?square )
( robot-at ?thing ?square )
( robot-handempty ?hand )

)
:effect
(and
( robot-have ?thing )
( robot-holding ?hand )
(not ( robot-at ?thing ?square ))
(not ( robot-handempty ?hand ))
)
)

(:action robot-put-down
:parameters (?thing ?square ?hand)
:precondition
(and


)
:effect
(and
( robot-handempty ?hand )
( robot-at ?thing ?square )
(not ( robot-have ?thing ))
(not ( robot-holding ?hand ))
)
)

(:action robot-spray
:parameters (?thing ?square)
:precondition
(and


)
:effect
(and
( robot-plant-watered ?square )

)
)

(:action disable-robot
:parameters ()
:precondition
(and
( robot-can-act )

)
:effect
(and
( robot-can-act )

)
)

(:action compare-left-item-fluents
:parameters (?thing ?square)
:precondition
(and
( left-item-checked )
( human-can-act )
( robot-can-act )

)
:effect
(and
( left-item-checked )
( when (or         (and (not(human_left_item ?thing ?square )
( and ((human_left_item ?thing ?square )
(not ( robot_left_item ?thing ?square ))
)
)

(:action compare-spray-fluents
:parameters (?square)
:precondition
(and
( watered-checked )
( human-can-act )
( robot-can-act )

)
:effect
(and
( watered-checked )
( when (or         (and (not(human-plant-watered ?square )
( and ((human-plant-watered ?square )
(not ( robot-plant-watered ?square ))
)
)

(:action check-fluents-compared
:parameters ()
:precondition
(and
( left-item-checked )
( watered-checked )
( fluents-check )

)
:effect
(and
( fluents-check )

)
)


)

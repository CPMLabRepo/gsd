(define (domain greenhouse)
    (:requirements :strips :action-costs :numeric-fluents)
    (:predicates 
        (human-location ?square) 
        (human-at ?thing ?square)
        (human-square-conn ?square1 ?square2) 
        (human-plant-watered ?square)
        (human-have ?thing) 
        (human-holding ?hand) 
        (human-handempty ?hand) 
        (human-left-item ?thing ?square) 
    
        (human-can-act)

        (robot-location ?square)
        (robot-at ?thing ?square)
        (robot-square-conn ?square1 ?square2) 
        (robot-plant-watered ?square) 
        (robot-have ?thing) 
        (robot-holding ?hand) 
        (robot-handempty ?hand) 
        (robot-left-item ?thing ?square) 
        
        (robot-can-act) 
        
        (left-item-checked)
        (watered-checked)
        (fluents-check)
    )
    (:functions (total-cost)) 


    (:action human-can-act
    :precondition (and (not(robot-can-act))) 
    :effect (and (human-can-act)))


    (:action human-move
        :parameters (?from ?to)
        :precondition (and (human-can-act) (human-location ?from) (human-square-conn ?from ?to))
        :effect (and (not (human-location ?from)) (human-location ?to)))

	 
    (:action human-pick-up
        :parameters (?thing ?square ?hand)
        :precondition (and (human-can-act) (human-location ?square) (human-at ?thing ?square) (human-handempty ?hand)) 
        :effect (and (human-have ?thing) (not (human-at ?thing ?square)) (not (human-handempty ?hand)) (human-holding ?hand))
    ) 


    (:action human-put-down
        :parameters (?thing ?square ?hand)
        :precondition (human-can-act) (human-have ?thing) 
        :effect (and (not (human-have ?thing)) (not (human-holding ?hand)) (human-handempty ?hand) (human-at ?thing ?square))
    )


    (:action human-spray
        :parameters (?thing ?square)
        :precondition (human-can-act) (human-have ?thing) (not(human-plant-watered ?square)) 
        :effect (and (human-plant-watered ?square))
    )


    (:action robot-can-act
    :precondition (and (not(robot-can-act)) (human-can-act)) 
    :effect (and (robot-can-act) (not(human-can-act))) 
    )
  
  
    (:action robot-move
        :parameters (?from ?to)
        :precondition (and (robot-can-act) (robot-location ?from) (robot-square-conn ?from ?to))
        :effect (and (not (robot-location ?from)) (robot-location ?to))
    )
	 
	 
    (:action robot-pick-up
        :parameters (?thing ?square ?hand)
        :precondition (and (robot-can-act) (robot-location ?square) (robot-at ?thing ?square) (robot-handempty ?hand)) 
        :effect (and (robot-have ?thing) (not (robot-at ?thing ?square)) (not (robot-handempty ?hand)) (robot-holding ?hand))
    ) 


    (:action robot-put-down
        :parameters (?thing ?square ?hand)
        :precondition (robot-can-act) (robot-have ?thing) 
        :effect (and (not (robot-have ?thing)) (not (robot-holding ?hand)) (robot-handempty ?hand) (robot-at ?thing ?square))
    )


    (:action robot-spray
        :parameters (?thing ?square)
        :precondition (robot-can-act) (robot-have ?thing) (not(robot-plant-watered ?square)) 
        :effect (and (robot-plant-watered ?square))
    )

 
    (:action disable-robot
    :precondition (and (robot-can-act)) 
    :effect (and(not(robot-can-act)))
    )

    (:action compare-left-item-fluents
    :parameters (?thing ?square) 
    :precondition (and
        (not(left-item-checked))
        (not(human-can-act)) 
        (not(robot-can-act)) )
    :effect (and (left-item-checked)
        (when (or
        (and (not(human_left_item ?thing ?square)) and (robot_left_item ?thing ?square))
        (and ((human_left_item ?thing ?square) (not (robot_left_item ?thing ?square))) ) 
        )
    (increase (total-cost) 1)) 
    ) )

  
    (:action compare-spray-fluents
    :parameters  (?square) 
    :precondition (and 
        (not(watered-checked))
        (not(human-can-act)) 
        (not(robot-can-act)) )
    :effect (and (watered-checked)
        (when (or
        (and (not(human-plant-watered ?square)) and (robot-plant-watered ?square))
        (and ((human-plant-watered ?square) (not (robot-plant-watered ?square))) 
        )
    (increase (total-cost) 1) ) 
    ) ) )
    

    (:action check-fluents-compared
    :precondition (and 
        (left-item-checked)
        (watered-checked)
        (not(fluents-check))
        ) 
    :effect (and (fluents-check) ) )
) 


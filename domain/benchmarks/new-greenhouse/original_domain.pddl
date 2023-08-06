(define (domain greenhouse)
    (:requirements :strips :action-costs)
    (:predicates 
        (location-of-human ?square)
        (human-plant ?plant)
        (human-tool ?tool)
        (human-square-place ?square) 
        (human-at ?thing ?square)
        (human-square-conn ?square1 ?square2) 
        
        (human-plant-watered ?plant) 
        (human-have ?thing)
        (human-holding ?hand) 
        (human-handempty ?hand) 
        (human-left-item ?thing ?square) 
    
        (human-can-act)

        (location-of-robot ?square)
        (robot-plant ?plant)
        (robot-tool ?tool)
        (robot-square-place ?square)
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
    



    (:action human-can-act
        :precondition (and (not(robot-can-act))) 
        :effect (and (human-can-act)))


    (:action human-move
        :parameters (?from ?to)
        :precondition (and (human-can-act) (location-of-human ?from) (human-square-conn ?from ?to))
        :effect (and (not (location-of-human ?from)) (location-of-human ?to)))

        
    (:action human-pick-up
        :parameters (?thing ?square ?hand)
        :precondition (and (human-can-act) (location-of-human ?square) (human-at ?thing ?square) (human-handempty ?hand) (human-tool ?tool))
        :effect (and (human-have ?thing) (not (human-at ?thing ?square)) (not (human-handempty ?hand)) (human-holding ?hand))) 


    (:action human-put-down
        :parameters (?thing ?square ?hand)
        :precondition (and (human-can-act) (human-have ?thing) (human-tool ?tool))
        :effect (and (not (human-have ?thing)) (not (human-holding ?hand)) (human-handempty ?hand) (human-at ?thing ?square)))


    (:action human-water-plant
        :parameters (?thing ?square ?plant)
        :precondition (and (human-can-act) (human-have ?thing) (not(human-plant-watered ?plant)) (location-of-human ?square) (human-at ?plant ?square) (human-tool ?tool) (human-plant ?plant))
        :effect (and (human-plant-watered ?plant)))


    (:action robot-can-act
    :precondition (and (not(robot-can-act)) (human-can-act)) 
    :effect (and (robot-can-act) (not(human-can-act))) 
    )
    
    
    (:action robot-move
        :parameters (?from ?to)
        :precondition (and (robot-can-act) (location-of-robot ?from) (robot-square-conn ?from ?to))
        :effect (and (not (location-of-robot ?from)) (location-of-robot ?to)))
        
        
    (:action robot-pick-up
        :parameters (?thing ?square ?hand)
        :precondition (and (robot-can-act) (location-of-robot ?square) (robot-at ?thing ?square) (robot-handempty ?hand) (robot-tool ?tool))
        :effect (and (robot-have ?thing) (not (robot-at ?thing ?square)) (not (robot-handempty ?hand)) (robot-holding ?hand))) 


    (:action robot-put-down
        :parameters (?thing ?square ?hand)
        :precondition (and (robot-can-act) (robot-have ?thing) (robot-tool ?tool))
        :effect (and (not (robot-have ?thing)) (not (robot-holding ?hand)) (robot-handempty ?hand) (robot-at ?thing ?square)))


    (:action robot-water-plant
        :parameters (?thing ?square ?plant)
        :precondition (and (robot-can-act) (robot-have ?thing) (not(robot-plant-watered ?square)) (location-of-robot ?square) (robot-at ?plant ?square) (robot-tool ?tool) (robot-plant ?plant)) 
        :effect (and (robot-plant-watered ?square)))

    
    (:action disable-robot
        :precondition (and (robot-can-act)) 
        :effect (and(not(robot-can-act))))
	

    (:action compare-left-item-fluents
    :parameters (?thing ?square) 
    :precondition (and
        (not(left-item-checked))
        (not(human-can-act)) 
        (not(robot-can-act)) )
    :effect (and (left-item-checked)
        (when (or
        (and (not(human_left_item ?thing ?square)) and (robot_left_item ?thing ?square))
        (and ((human_left_item ?thing ?square) (not (robot_left_item ?thing ?square))) 
        ) ) )
    (increase (total-cost) 1)
    ) 
    )

    
    (:action compare-water-fluents
    :parameters (?plant) 
    :precondition (and 
        (not(watered-checked))
        (not(human-can-act)) 
        (not(robot-can-act)) )
    :effect (and (water-checked)
        (when (or
        (and (not(human-plant-watered ?plant)) and (robot-plant-watered ?plant))
        (and ((human-plant-watered ?plant) (not (robot-plant-watered ?plant))) 
        ) ) )
    (increase (total-cost) 1) 
    ) 
    )
 
    (:action check-fluents-compared
    :precondition (and 
        (left-item-checked)
        (watered-checked)
        (not(fluents-check))
        ) 
    :effect (and (fluents-check) ) )
 
)
 
 



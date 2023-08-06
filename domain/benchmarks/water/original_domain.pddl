(define (domain grid)
  (:requirements :strips)
  (:predicates (place ?p) (at ?r ?x ) (at-robot ?x) (conn ?x ?y) (holding ?tool)
               (arm-empty )(tool ?tool) (need-water ?x) (watered ?x))

  
  (:action move
    :parameters (?curpos ?nextpos)
    :precondition (and (place ?curpos) (place ?nextpos) (at-robot ?curpos)
		       (conn ?curpos ?nextpos))
    :effect (and (at-robot ?nextpos) (not (at-robot ?curpos))))	
    
    
    (:action pickup-water-pail
      :parameters (?curpos)
      :precondition (and (place ?curpos) (tool water-pail) (at-robot ?curpos) (at water-pail ?curpos) (arm-empty ))
      :effect (and (holding water-pail) (not (arm-empty)) (not (at water-pail ?curpos)))
    )
    
    (:action pickup-hose
      :parameters (?curpos)
      :precondition (and (place ?curpos) (tool hose) (at-robot ?curpos) (at hose ?curpos) (arm-empty ))
      :effect (and (holding hose) (not (arm-empty)) (not (at hose ?curpos)))
    )
    
    
  (:action putdown
    :parameters (?curpos ?tool)
    :precondition (and (place ?curpos) (tool ?tool) (at-robot ?curpos)
		       (holding ?tool))
    :effect (and (arm-empty ) (at ?tool ?curpos) (not (holding ?tool))))


  (:action water
    :parameters (?curpos ?plantstate ?tool)
    :precondition (and (place ?curpos) (place ?plantstate)(tool ?tool)
		       (conn ?curpos ?plantstate)
		       (at-robot ?curpos) (need-water ?plantstate) (holding ?tool))
    :effect (and (watered ?plantstate) (not (need-water ?plantstate))))


  )
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

%OPERATORS%

)

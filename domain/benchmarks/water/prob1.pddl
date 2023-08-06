(define (problem small)
  (:domain grid)
  (:objects node0-0 node0-1 node0-2 node0-3 node0-4 node1-0 node1-1 node1-2 node1-3 node1-4
	    node2-0 node2-1 node2-2 node2-3 node2-4 node3-0 node3-1 node3-2 node3-3 node4-4
	    water-pail hose)
	    
  (:init (place node0-0) (place node0-1) (place node0-2) (place node0-3) (place node0-4)
	 (place node1-0) (place node1-1) (place node1-2) (place node1-3) (place node1-4)
	 (place node2-0) (place node2-1) (place node2-2) (place node2-3) (place node2-4)
	 (place node3-0) (place node3-1) (place node3-2) (place node3-3) (place node4-4)
	 
	 (tool water-pail) (tool hose)
     (arm-empty)
     
	 (conn node0-0 node1-0) (conn node0-0 node0-1) (conn node0-1 node1-1)
	 (conn node0-1 node0-2) (conn node0-1 node0-0) (conn node0-2 node1-2)
	 (conn node0-2 node0-1) (conn node0-3 node1-3) (conn node0-3 node0-2) (conn node0-3 node0-4)
	 (conn node0-4 node1-4) (conn node0-4 node0-3) (conn node1-0 node2-0) (conn node1-0 node0-0) (conn node1-0 node1-1) 
	 (conn node1-1 node2-1) (conn node1-1 node0-1) (conn node1-1 node1-2) 
	 (conn node1-1 node1-0) (conn node1-2 node2-2) (conn node1-2 node0-2) 
	 (conn node1-2 node1-1) (conn node1-3 node2-3) (conn node1-3 node0-3) (conn node1-3 node1-4) 
	 (conn node1-3 node1-2) (conn node1-4 node1-3) (conn node1-4 node0-4) (conn node1-4 node2-4) 
	 (conn node2-0 node1-0) (conn node2-0 node2-1) (conn node2-0 node3-0) 
	 (conn node2-1 node1-1) (conn node2-1 node2-2) (conn node2-1 node2-0) (conn node2-1 node3-1) 
	 (conn node2-2 node1-2) (conn node2-2 node2-1) (conn node2-2 node3-2) (conn node2-3 node1-3)
	 (conn node2-3 node2-2) (conn node2-3 node3-3) (conn node2-3 node2-4)
	 (conn node2-4 node2-3) (conn node2-4 node1-4) (conn node2-4 node4-4)
	 (conn node3-0 node2-0) (conn node3-0 node3-1)
	 (conn node3-1 node3-0) (conn node3-1 node3-2) (conn node3-1 node2-1)
	 (conn node3-2 node3-1) (conn node3-2 node3-3) (conn node3-2 node2-2)
	 (conn node3-3 node3-2) (conn node3-3 node2-3) (conn node3-3 node4-4)
	 (conn node4-4 node3-3) (conn node4-4 node2-4)
	 
	 (need-water node2-1) 
	 (need-water node2-2)
	 (need-water node2-3)
	 (need-water node1-1)
	 (need-water node1-3)

	 (at water-pail node3-0)
	 (at hose node1-2)

	 
	 (at-robot node0-0))
	 
  (:goal (and (watered node2-1) (watered node2-2) (watered node2-3) (watered node1-1) (watered node1-3) ))
  )
  
  
  ;need water is your locked equivalent
  ;key is your tool equivalent
  

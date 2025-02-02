(define (problem ZTRAVEL-2-4)
(:domain zeno-travel)
(:objects
	plane1 - aircraft
	plane2 - aircraft
	person1 - person
	person2 - person
	person3 - person
	person4 - person
	city0 - city
	city1 - city
	city2 - city
	city3 - city
	fl0 - flevel
	fl1 - flevel
	fl2 - flevel
	fl3 - flevel
	fl4 - flevel
	fl5 - flevel
	fl6 - flevel
	)
(:init
	(at plane1 city1)
	(fuel-level plane1 fl6)
	(at plane2 city2)
	
	(at person1 city3)
	
	(at person3 city0)
	
	(next fl0 fl1)
	(next fl1 fl2)
	
	(next fl3 fl4)
	
	(next fl5 fl6)
)
(:goal (and
	(at person1 city2)
	(at person2 city3)
	(at person3 city3)
	(at person4 city3)
	))

)

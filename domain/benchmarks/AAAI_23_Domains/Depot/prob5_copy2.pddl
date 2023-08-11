(define (problem depotprob1212) (:domain Depot)
(:objects
	depot0 - Depot
	distributor0 distributor1 - Distributor
	truck0 truck1 - Truck
	pallet0 pallet1 pallet2 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 crate8 crate9 - Crate
	hoist0 hoist1 hoist2 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate4)
	(at pallet1 distributor0)
	(clear crate8)
	(at pallet2 distributor1)
	
	(at hoist1 distributor0)
	(available hoist1)
	(at hoist2 distributor1)
	(available hoist2)
	(at crate0 distributor1)
	(on crate0 pallet2)
	(at crate1 depot0)
	(on crate1 pallet0)
	(at crate2 distributor1)
	(on crate2 crate0)
	(at crate3 depot0)
	(on crate3 crate1)
	(at crate4 depot0)
	(on crate4 crate3)
	(at crate5 distributor1)
	(on crate5 crate2)
	(at crate6 distributor0)
	(on crate6 pallet1)
	(at crate7 distributor0)
	(on crate7 crate6)
	(at crate8 distributor0)
	(on crate8 crate7)
	(at crate9 distributor1)
	(on crate9 crate5)
)

(:goal (and
		(on crate0 crate5)
		(on crate1 pallet1)
		(on crate2 crate0)
		(on crate3 pallet2)
		(on crate4 crate6)
		(on crate5 crate4)
		(on crate6 crate9)
		(on crate7 crate1)
		(on crate8 crate3)
		(on crate9 pallet0)
	)
))

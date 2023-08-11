(define (problem depotprob6512) (:domain Depot)
(:objects
	depot0 - Depot
	distributor0 distributor1 - Distributor
	truck0 truck1 - Truck
	pallet0 pallet1 pallet2 - Pallet
	crate0 crate1 crate2 crate3 crate4 crate5 crate6 crate7 - Crate
	hoist0 hoist1 hoist2 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate7)
	(at pallet1 distributor0)
	(clear crate2)
	(at pallet2 distributor1)
	(clear crate6)
	(at truck0 distributor1)
	(at truck1 distributor1)
	(at hoist0 depot0)
	(available hoist0)
	(at hoist1 distributor0)
	(available hoist1)
	(at hoist2 distributor1)
	(available hoist2)
	(at crate0 depot0)
	
	(at crate3 distributor1)
	(on crate3 pallet2)
	(at crate4 depot0)
	(on crate4 crate1)
	(at crate5 distributor1)
	(on crate5 crate3)
	(at crate6 distributor1)
	(on crate6 crate5)
	(at crate7 depot0)
	(on crate7 crate4)
)

(:goal (and
		(on crate0 crate4)
		(on crate2 crate6)
		(on crate4 crate7)
		(on crate5 pallet2)
		(on crate6 pallet1)
		(on crate7 pallet0)
	)
))

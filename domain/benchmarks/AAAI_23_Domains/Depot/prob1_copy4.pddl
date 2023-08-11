(define (problem depotprob1818) (:domain Depot)
(:objects
	depot0 - Depot
	distributor0 distributor1 - Distributor
	truck0 truck1 - Truck
	pallet0 pallet1 pallet2 - Pallet
	crate0 crate1 - Crate
	hoist0 hoist1 hoist2 - Hoist)
(:init
	(at pallet0 depot0)
	(clear crate1)
	(at pallet1 distributor0)
	(clear crate0)
	
	(clear pallet2)
	(at truck0 distributor1)
	(at truck1 depot0)
	(at hoist0 depot0)
	(available hoist0)
	(at hoist1 distributor0)
	
	(at hoist2 distributor1)
	(available hoist2)
	(at crate0 distributor0)
)

(:goal (and
		(on crate0 pallet2)
		(on crate1 pallet1)
	)
))

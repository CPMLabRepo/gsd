(define (domain grounded-FETCHWORLD)
(:predicates
(ontable_b)
(holding_a)
(clear_c)
(on_a_b)
(on_d_c)
(on_c_c)
(on_a_d)
(on_a_c)
(clear_d)
(holding_c)
(on_d_b)
(on_c_a)
(on_a_a)
(on_b_a)
(on_b_b)
(handempty)
(on_b_d)
(holding_d)
(on_c_b)
(clear_a)
(on_b_c)
(ontable_a)
(ontable_c)
(clear_b)
(on_d_a)
(ontable_d)
(holding_b)
(on_c_d)
(on_d_d)
)

	(:action unstack_b_b
		:parameters ()
		:precondition
		(and 
			(clear_b)
			(on_b_b)
			(handempty))
		:effect
		(and 
			(holding_b)
			(not (handempty))
		)
	)
	(:action unstack_b_d
		:parameters ()
		:precondition
		(and 
			(clear_b)
			(handempty)
			(on_b_d))
		:effect
		(and 
			(holding_b)
			(not (handempty))
		)
	)
	(:action unstack_b_c
		:parameters ()
		:precondition
		(and 
			(clear_b)
			(on_b_c)
			(handempty))
		:effect
		(and 
			(holding_b)
			(not (handempty))
		)
	)
	(:action unstack_b_a
		:parameters ()
		:precondition
		(and 
			(on_b_a)
			(handempty)
			(clear_b))
		:effect
		(and 
			(holding_b)
			(not (handempty))
		)
	)
	(:action unstack_d_b
		:parameters ()
		:precondition
		(and 
			(clear_d)
			(handempty)
			(on_d_b))
		:effect
		(and 
			(holding_d)
			(not (handempty))
		)
	)
	(:action unstack_d_d
		:parameters ()
		:precondition
		(and 
			(clear_d)
			(handempty)
			(on_d_d))
		:effect
		(and 
			(holding_d)
			(not (handempty))
		)
	)
	(:action unstack_d_c
		:parameters ()
		:precondition
		(and 
			(clear_d)
			(on_d_c)
			(handempty))
		:effect
		(and 
			(holding_d)
			(not (handempty))
		)
	)
	(:action unstack_d_a
		:parameters ()
		:precondition
		(and 
			(clear_d)
			(on_d_a)
			(handempty))
		:effect
		(and 
			(holding_d)
			(not (handempty))
		)
	)
	(:action unstack_c_b
		:parameters ()
		:precondition
		(and 
			(on_c_b)
			(handempty)
			(clear_c))
		:effect
		(and 
			(holding_c)
			(not (handempty))
		)
	)
	(:action unstack_c_d
		:parameters ()
		:precondition
		(and 
			(handempty)
			(clear_c)
			(on_c_d))
		:effect
		(and 
			(holding_c)
			(not (handempty))
		)
	)
	(:action unstack_c_c
		:parameters ()
		:precondition
		(and 
			(on_c_c)
			(handempty)
			(clear_c))
		:effect
		(and 
			(holding_c)
			(not (handempty))
		)
	)
	(:action unstack_c_a
		:parameters ()
		:precondition
		(and 
			(handempty)
			(on_c_a)
			(clear_c))
		:effect
		(and 
			(holding_c)
			(not (handempty))
		)
	)
	(:action unstack_a_b
		:parameters ()
		:precondition
		(and 
			(on_a_b)
			(handempty)
			(clear_a))
		:effect
		(and 
			(holding_a)
			(not (handempty))
		)
	)
	(:action unstack_a_d
		:parameters ()
		:precondition
		(and 
			(clear_a)
			(handempty)
			(on_a_d))
		:effect
		(and 
			(holding_a)
			(not (handempty))
		)
	)
	(:action unstack_a_c
		:parameters ()
		:precondition
		(and 
			(clear_a)
			(handempty)
			(on_a_c))
		:effect
		(and 
			(holding_a)
			(not (handempty))
		)
	)
	(:action unstack_a_a
		:parameters ()
		:precondition
		(and 
			(clear_a)
			(handempty)
			(on_a_a))
		:effect
		(and 
			(holding_a)
			(not (handempty))
		)
	)
	(:action pickup_b
		:parameters ()
		:precondition
		(and 
			(clear_b)
			(ontable_b)
			(handempty))
		:effect
		(and 
			
			(not (clear_b))
			(not (ontable_b))
		)
	)
	(:action pickup_d
		:parameters ()
		:precondition
		(and 
			(clear_d)
			(ontable_d)
			(handempty))
		:effect
		(and 
			
			(not (clear_d))
			(not (ontable_d))
		)
	)
	(:action pickup_c
		:parameters ()
		:precondition
		(and 
			(handempty)
			(clear_c)
			(ontable_c))
		:effect
		(and 
			
			(not (clear_c))
			(not (ontable_c))
		)
	)
	(:action pickup_a
		:parameters ()
		:precondition
		(and 
			(clear_a)
			(handempty)
			(ontable_a))
		:effect
		(and 
			
			(not (clear_a))
			(not (ontable_a))
		)
	)
	(:action putdown_b
		:parameters ()
		:precondition
		(and 
			)
		:effect
		(and 
			(clear_b)
			(ontable_b)
		)
	)
	(:action putdown_d
		:parameters ()
		:precondition
		(and 
			)
		:effect
		(and 
			(clear_d)
			(ontable_d)
		)
	)
	(:action putdown_c
		:parameters ()
		:precondition
		(and 
			)
		:effect
		(and 
			(clear_c)
			(ontable_c)
		)
	)
	(:action putdown_a
		:parameters ()
		:precondition
		(and 
			)
		:effect
		(and 
			(clear_a)
			(ontable_a)
		)
	)
	(:action stack_b_b
		:parameters ()
		:precondition
		(and 
			(clear_b)
			(holding_b))
		:effect
		(and 
			(on_b_b)
			(handempty)
		)
	)
	(:action stack_b_d
		:parameters ()
		:precondition
		(and 
			(clear_d)
			(holding_b))
		:effect
		(and 
			(handempty)
			(on_b_d)
		)
	)
	(:action stack_b_c
		:parameters ()
		:precondition
		(and 
			(holding_b)
			(clear_c))
		:effect
		(and 
			(on_b_c)
			(handempty)
		)
	)
	(:action stack_b_a
		:parameters ()
		:precondition
		(and 
			(clear_a)
			(holding_b))
		:effect
		(and 
			(on_b_a)
			(handempty)
		)
	)
	(:action stack_d_b
		:parameters ()
		:precondition
		(and 
			(clear_b)
			(holding_d))
		:effect
		(and 
			(handempty)
			(on_d_b)
		)
	)
	(:action stack_d_d
		:parameters ()
		:precondition
		(and 
			(clear_d)
			(holding_d))
		:effect
		(and 
			(handempty)
			(on_d_d)
		)
	)
	(:action stack_d_c
		:parameters ()
		:precondition
		(and 
			(holding_d)
			(clear_c))
		:effect
		(and 
			(on_d_c)
			(handempty)
		)
	)
	(:action stack_d_a
		:parameters ()
		:precondition
		(and 
			(clear_a)
			(holding_d))
		:effect
		(and 
			(on_d_a)
			(handempty)
		)
	)
	(:action stack_c_b
		:parameters ()
		:precondition
		(and 
			(holding_c)
			(clear_b))
		:effect
		(and 
			(on_c_b)
			(handempty)
		)
	)
	(:action stack_c_d
		:parameters ()
		:precondition
		(and 
			(clear_d)
			(holding_c))
		:effect
		(and 
			(handempty)
			(on_c_d)
		)
	)
	(:action stack_c_c
		:parameters ()
		:precondition
		(and 
			(holding_c)
			(clear_c))
		:effect
		(and 
			(on_c_c)
			(handempty)
		)
	)
	(:action stack_c_a
		:parameters ()
		:precondition
		(and 
			(holding_c)
			(clear_a))
		:effect
		(and 
			(handempty)
			(on_c_a)
		)
	)
	(:action stack_a_b
		:parameters ()
		:precondition
		(and 
			(clear_b)
			(holding_a))
		:effect
		(and 
			(on_a_b)
			(handempty)
		)
	)
	(:action stack_a_d
		:parameters ()
		:precondition
		(and 
			(clear_d)
			(holding_a))
		:effect
		(and 
			(handempty)
			(on_a_d)
		)
	)
	(:action stack_a_c
		:parameters ()
		:precondition
		(and 
			(holding_a)
			(clear_c))
		:effect
		(and 
			(handempty)
			(on_a_c)
		)
	)
	(:action stack_a_a
		:parameters ()
		:precondition
		(and 
			(clear_a)
			(holding_a))
		:effect
		(and 
			(handempty)
			(on_a_a)
		)
	)
)

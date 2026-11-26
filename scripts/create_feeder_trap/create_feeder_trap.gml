function create_feeder_trap(newType,newX,newY,newTarget){
// TYPES
// 0 - Feeder
// 1 - Trap
// newTarget: species the feeder or trap affects (see create_creature)
	return({
		myType : newType,
		myX : newX,
		myY : newY,
		myTarget : newTarget
	});
}
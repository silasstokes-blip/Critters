function create_feeder_trap(newType,newX,newY,newTarget){
// TYPES
// 0 - Rabbit
// 1 - Wolf

// STATES
// 0 - default
// 1 - hungry
// 2 - horny
	return({
		myType : newType,
		myX : newX,
		myY : newY,
		myTarget : newTarget
	});
}
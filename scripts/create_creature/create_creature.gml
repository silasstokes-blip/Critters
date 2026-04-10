function create_creature(newType,newX,newY){
// TYPES
// 0 - Rabbit
// 1 - Wolf

// STATES
// 0 - default
// 1 - hungry
// 2 - horny
var fm = (random_range(0.7,1.4) * random_range(0.7,1.4))
if (newType == 0) {
	return({
		myType : newType,
		myX : newX,
		myY : newY,
		myDir : irandom_range(0,3),
		myHunger : 0,
		myState : 0,
		childThreshold : creaChild[0] * random_range(0.75,1.25),
		deathThreshold : creaStarve[0] * random_range(0.75,1.25),
		feedMult : fm,
		eaten : false,
		age : 0
	});
}
if (newType == 1) {
	return({
		myType : newType,
		myX : newX,
		myY : newY,
		myDir : irandom_range(0,3),
		myHunger : 0,
		myState : 0,
		childThreshold : creaChild[1] * random_range(0.75,1.25),
		deathThreshold : creaStarve[1] * random_range(0.75,1.25),
		feedMult : fm,
		eaten : false,
		age : 0
	});
}
if (newType == 2) {
	return({
		myType : newType,
		myX : newX,
		myY : newY,
		myDir : irandom_range(0,3),
		myHunger : 0,
		myState : 0,
		childThreshold : creaChild[2] * random_range(0.75,1.25),
		deathThreshold : creaStarve[2] * random_range(0.75,1.25),
		feedMult : fm,
		eaten : false,
		age : 0
	});
}
if (newType == 3) {
	return({
		myType : newType,
		myX : newX,
		myY : newY,
		myDir : irandom_range(0,3),
		myHunger : 0,
		myState : 0,
		childThreshold : creaChild[3] * random_range(0.75,1.25),
		deathThreshold : creaStarve[3] * random_range(0.75,1.25),
		feedMult : fm,
		eaten : false,
		age : 0
	});
}
if (newType == 4) {
	return({
		myType : newType,
		myX : newX,
		myY : newY,
		myDir : irandom_range(0,3),
		myHunger : random_range(0,20),
		myState : 0,
		childThreshold : creaChild[4] * random_range(1,1.25),
		deathThreshold : creaStarve[4] * random_range(0.75,1.25),
		feedMult : fm,
		eaten : false,
		age : 0
	});
}
if (newType == 5) {
	return({
		myType : newType,
		myX : newX,
		myY : newY,
		myDir : irandom_range(0,3),
		myHunger : 0,
		myState : 0,
		childThreshold : creaChild[5] * random_range(0.75,1.25),
		deathThreshold : creaStarve[5] * random_range(0.75,1.25),
		feedMult : fm,
		eaten : false,
		age : 0
	});
}
}
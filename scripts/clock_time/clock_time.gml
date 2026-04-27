function clock_time(seconds){
	if(floor(seconds)%60 >= 10) {
		return(string(floor(seconds/60)) + ":" + string(floor(seconds)%60));
	} else {
		return(string(floor(seconds/60)) + ":0" + string(floor(seconds)%60));
	}
}
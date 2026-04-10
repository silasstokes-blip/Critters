function myMod(a,b){
	if(a >= 0) {
		return(a%b);
	} else {
		while(a < 0) {
			a += b;
		}
		return(a);
	}
}
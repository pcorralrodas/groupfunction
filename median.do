set more off
clear all

mata
function _fastpctile(real colvector X,real scalar p,|real colvector w) {
	rr = rows(X)
	if (args()==2) w = J(rr,1,1)	
	data = X, w
	_sort(data,(1,2))
	n=quadsum(data[.,2])
	nq0 = (n*p)/100
	data=data,quadrunningsum(data[.,2])
	
	for (i=1;i<rr;++i){	
		if (data[i,3]>nq0){
			break
			}
	}
	
	if (i==1){
		perc = data[i,1]
	}
	else if (data[i-1,3]==nq0){
		perc = (data[i-1,1]+data[i,1])/2
	}
	else {
		perc = data[i,1]
	}

	return(perc)
}
end

sysuse auto,clear


putmata X=price,replace
putmata wW=weight,replace

*putmata X=price,replace
*putmata w=weight,replace
mata
for (i=1;i<100;++i){
	p=_fastpctile(X,i)
	p
	}
end

sum price [aw=weight], d



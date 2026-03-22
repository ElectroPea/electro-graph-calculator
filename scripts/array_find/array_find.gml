/// @function array_find(_array, _name)
/// @description Returns string index inside of array

function array_find(_array, _name){
	for(var ID=0;ID<array_length(_array);ID++) {
		if _array[ID] == _name { 
			return ID	
		}
	}
	return -1
}


function array_count(_array, _name){ var count = 0;
	for (var i = 0; i < array_length(_array); i++) {
	    if (_array[i] == _name) {
	        count++;
	    }
	}
	return count;
}
function add_implicit_multiplication(s) {
	var word = "";
	var chars = [];
    for (var i = 0; i < string_length(s); i++) chars[i] = string_char_at(s, i+1);
	for (var i = 0; i < array_length(chars); i++) {
		try {
			var char_prev = "";
			if (i > 0)
				char_prev = chars[i-1];
			var char = chars[i];
			var char_next = chars[i+1];
			
			// finding functions like sqrt and etc.
			if (word != "") {	
				if (char != "(") {
					word += char;
				}
			}
			if (char_prev == "\\")
				word += char;
			
			var res = false;
			for(var _INDEX = 0; _INDEX < array_length(math_functions()) +1; _INDEX++)
				if ( word == math_functions()[_INDEX]) {
					res = true; break;
				}
			if (char == "(" and res == false)
			{
				if (char_prev >= "a" && char_prev <= "z") || char_prev == ")" ||(char_prev >= "A" && char_prev <= "Z") || (char_prev == "_") || (char_prev >= "0" && char_prev <= "9")
				{
					array_insert(chars, i, "*");
					i++;
				}
			}
			else if (char == ")" and res == false)
			{
				if (char_next >= "a" && char_next <= "z")  || char_next == "(" || (char_next >= "A" && char_next <= "Z") || (char_next == "_") || (char_next >= "0" && char_next <= "9")
				{
					array_insert(chars, i+1, "*");
					i++;
				}
			}
			if (word != "") {	
				if (char == "(") {
					word = "";
				}
			}
		} catch (er) {}
	}
	
    var res = "";
	for(var i = 0; i < array_length(chars); i++) res += chars[i];
    return res;
}
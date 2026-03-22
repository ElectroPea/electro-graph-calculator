function math_functions()
{
	return [
		"sqrt", "abs", // math standart functions
		"sin", "cos", "tan", "csc", "sec", "cot",
		"min", "max"
	];
}

function word_from_mathfs(val)
{
	for(var i = 0; i < array_length(math_functions()); i++)
	{
		if (val == math_functions()[i]) return true;	
	}
	return false;
}

/// @desc Returns the value of a function given its name and parameters
function math_f_proceed(name, pars)
{
	var RETURN_RESULT = {
		answer: 0,
		error: false
	}
	switch(name)
	{
		case "sqrt":
		{	
			if (real(pars[0]) >= 0)
			{
				RETURN_RESULT.answer = sqrt(real(pars[0]));
				return RETURN_RESULT;
			} else {
				RETURN_RESULT.error = true;
			}
			return RETURN_RESULT;
		}
		case "sin":
		{
			RETURN_RESULT.answer = sin(real(pars[0]));
			return RETURN_RESULT;
		}
		case "cos":
			{
				RETURN_RESULT.answer = cos(real(pars[0])); 
				return RETURN_RESULT;
			}
		case "abs":
			{
				RETURN_RESULT.answer = abs(real(pars[0])); 
				return RETURN_RESULT;
			}
		case "tan":
			{
				RETURN_RESULT.answer = tan(real(pars[0])); 
				return RETURN_RESULT;
			}
		case "cot":
			{
				RETURN_RESULT.answer = 1 / tan(real(pars[0])); 
				return RETURN_RESULT;
			}
		case "csc":
			{
				RETURN_RESULT.answer = 1 / sin(real(pars[0])); 
				return RETURN_RESULT;
			}
		case "sec":
			{
				RETURN_RESULT.answer = 1 / cos(real(pars[0])); 
				return RETURN_RESULT;
			}
		case "min":
			{
				if (array_length(pars) > 0) {
					var minv = real(pars[0]);
					for (var i = 1; i < array_length(pars); i++) {
					    minv = min(minv, real(pars[i]));
					}
					RETURN_RESULT.answer = minv;
					return RETURN_RESULT;
				}
			}
		case "max":
			{
				if (array_length(pars) > 0) {
					var maxv = real(pars[0]);
					for (var i = 1; i < array_length(pars); i++) {
					    maxv = max(maxv, real(pars[i]));
					}
					RETURN_RESULT.answer = maxv;
					return RETURN_RESULT;
				}
			}
			
	}
	return RETURN_RESULT;
}



















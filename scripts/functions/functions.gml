function BracketIndexs(pos_1, pos_2) constructor {
	opened_b = pos_1;
	closed_b = pos_2;
}

function Point(_X, _Y, _ERROR = false) constructor {
	_x = _X;  _y = _Y; _error = _ERROR;
	static add = function(_X=0, _Y=0) {
		_x += _X;
		_y += _Y;
	};
	
	static mult = function(_X=0, _Y=0) {
		_x *= _X;
		_x *= _Y;
	};
	
	static GetX = function() { return _x; }
	static GetY = function() { return _y; }
	
	static PrintPoint = function()
	{
		Print(string("x:{0}, y:{1}", _x, _y));	
	}
}

function BracketIndexs_find(array, pos_1 = -1, pos_2 = -1)
{
	for (var j = 0; j < array_length(array); j++)
	{
		var ID = array[j]
		if (ID.opened_b == pos_1 || ID.closed_b == pos_2) return true;
	}
	return false;
}

function str_count(str)
{
	return {
		plus: string_count("+", str),
		minus: string_count("-", str),
		mult: string_count("*", str),
		divide: string_count("/", str),
		expo: string_count("^", str)
	}
	
}

/// @desc This function will return a mathematical result, based on a given string.
function return_expression_result(string_expression, variables = {})
{
	string_expression = string_replace_all(string_expression, " ", "");
	string_expression = add_implicit_multiplication(string_expression);
	var steps = array_create(0, "");
	
	var declared_string_expression = string_expression;
	var variable_expression = "";
	if (string_pos("=", string_expression)>0)
	{
		variable_expression = string_copy(string_expression, 1, string_pos("=",string_expression));
		declared_string_expression = string_copy(string_expression, string_pos("=",string_expression)+1, string_length(string_expression));
		
		string_expression = variable_expression + add_parentheses(declared_string_expression);
	} else {
		string_expression = add_parentheses(string_expression);
	}

	var brackets_indexs = array_create(0);
	var stack = array_create(0);

	for (var i = 1; i <= string_length(string_expression); i++) {
	    var char = string_char_at(string_expression, i);
    
	    if (char == "(") {
	        array_push(stack, i); 
	    } 
	    else if (char == ")") {
	        if (array_length(stack) > 0) {
	            var start_pos = array_pop(stack);
	            array_push(brackets_indexs, new BracketIndexs(start_pos - 1, i - 1));
	        }
	    }
	}

	// putting brackets steps
	for(var i = 0; i < array_length(brackets_indexs); i++)
		array_push(steps, string_cooler_copy(string_expression,
			brackets_indexs[i].opened_b,
			brackets_indexs[i].closed_b)); 

	if !BracketIndexs_find(brackets_indexs, 0,string_length(string_expression)+1)
		array_push(steps, declared_string_expression)	
		
	// erasing unusual brackets
	for(var i = 0; i < array_length(steps); i++)
	{
		if (string_count("(",steps[i]) == string_count(")",steps[i]) && string_starts_with(steps[i],"(") && string_ends_with(steps[i],")"))
		{
			steps[i] = string_cooler_copy(steps[i], 1, string_length(steps[i])-2);
		}
		if (string_count("(",steps[i]) > string_count(")",steps[i]) && string_starts_with(steps[i],"(") && !string_starts_with(steps[i],"\\"))
		{
			steps[i] = string_cooler_copy(steps[i], 1, string_length(steps[i])-1);
		}
		if (string_count("(",steps[i]) < string_count(")",steps[i]) && string_ends_with(steps[i],")"))
		{
			steps[i] = string_cooler_copy(steps[i], 0, string_length(steps[i])-2);
		}
		if (string_count("--",steps[i])>0)
		{
			while(string_count("--",steps[i]) > 0)
				steps[i] = string_replace_all(steps[i], "--", "+");
		}
		if (string_count("()",steps[i])>0)
		{
			while(string_count("()",steps[i]) > 0)
				steps[i] = string_replace_all(steps[i], "()", "");
			if (steps[i] == "")
			{
				array_delete(steps, i, 1);
				i--;
			}
		}
	}
	//// messing with ","
	for (var i = 0; i < array_length(steps); i++) {
	    var step = steps[i];
	    if (string_count(",", step) > 0 && string_pos("(", step) == 0) {
	        var str = string_split(step, ",", true);
	        for (var K = array_length(str) - 1; K >= 0; K--) {
				if (array_count(steps, str[K]) == 0)
					array_insert(steps, i + 1, str[K]);
	        }
	        array_delete(steps, i, 1); 
	        i += array_length(str) - 1;
	    }
	}
	
	//Print("[Step2]");
	// 2) transformating to [n] brackets
	for (var i = 0; i < array_length(steps); i++)
	{
		for(var k = 0; k < i; k++)
		{
			if (string_pos(steps[k], steps[i]) != 0 && string_replace_all(steps[k], " ", "") != "") 
			{
				//show_debug_message("\"{0},{1}\"", steps[k], steps[i])
				// math functions thing
				var pos_parenth = string_pos(string_concat("(", steps[k], ")"), steps[i]);
				var pos_backslash = 0;
				for (var z = pos_parenth - 1; z > 0; z--) {
				    if (string_copy(steps[i], z, 1) == "\\") {
				        pos_backslash = z;
				        break;
				    }
				}
				var word = string_copy(steps[i], pos_backslash+1, pos_parenth - pos_backslash -1);
				if (!word_from_mathfs(word))
				{
					//steps[i] = string_replace_all(steps[i], string_concat("(", steps[k], ")"), string_concat(OPENED_BRACKET, k, CLOSED_BRACKET));
					var str = steps[i];
					var substr = string_concat("(", steps[k], ")");
					var newstr = string_concat(OPENED_BRACKET, k, CLOSED_BRACKET);
					steps[i] = string_replace_all_limit(str, substr, newstr, 
						function(_INDEX, _STR, _SUBSTR, _NEWSTR) {
							var lchar = string_char_at(_STR, _INDEX-1);
							var rchar = string_char_at(_STR, _INDEX + string_length(_SUBSTR));
							return (!check_ord_char(lchar) && !check_ord_char(rchar));
						}
					);
				} else {
					var str = steps[i];
					var substr = string_concat("(", steps[k], ")");
					var newstr = string_concat(string_concat(OPENED_BRACKET, k, CLOSED_BRACKET));
					//var newstr = string_concat("(",string_concat(OPENED_BRACKET, k, CLOSED_BRACKET),")");
					steps[i] = string_replace_all_limit(str, substr, newstr, 
						function(_INDEX, _STR, _SUBSTR, _NEWSTR) {
							var lchar = string_char_at(_STR, _INDEX - 1);
							var rchar = string_char_at(_STR, _INDEX + string_length(_SUBSTR));	
							return (!check_ord_char(lchar) && !check_ord_char(rchar));
						}
					);
				}
			}
		}
	}
	var ARRAY_BEFORE_VARS = array_create(array_length(steps));
	for (var i = 0; i < array_length(steps); i++) {
	    ARRAY_BEFORE_VARS[i] = steps[i];
	}
	
	//// declaring variables
	if (string_pos("=",string_expression ) == 0) // if not found, something like easy math question == (a-5)
	{
		steps = ReplaceAllReferences(steps, variables).GET_STEPS;
	} else {
		var string_result = string_copy(string_expression, 
			string_pos("=", string_expression)+1, 
			string_length(string_expression));
		var struct = {};
		var result_struct = return_expression_result(string_result, variables);
		if (result_struct.type == EXPRESSION_TYPES.error_none)
		{
			return {
				array_steps: ARRAY_BEFORE_VARS,
				type: EXPRESSION_TYPES.error_none	
			}
		}
		struct = {
			array_steps: ARRAY_BEFORE_VARS,
			result_total: real(result_struct.result_total),	
			type: EXPRESSION_TYPES.movable
		};
		if (string_count_ext("+-*/^",string_result) + string_count("\\",string_result) > (
				string_starts_with(string_result,"-") || 
				string_starts_with(string_replace_all(string_replace_all(string_result, "(", ""), ")", ""),"-")
			) ? 1 : 0)
		{	
			for(var z = 0; z < string_length(string_result); z++)
			{
				if (string_count_ext("+-*/^=",string_char_at(string_result, z+1)) > 0)
				{
					struct.type = EXPRESSION_TYPES.standard;
					break;	
				}
				if (string_count("\\",string_concat(string_result,z+1,z+3)) > 0)
				{
					struct.type = EXPRESSION_TYPES.standard;
					break;	
				}
			}
		}
		return struct;
	}
	//show_debug_message(steps)
	/// math
	var t = EXPRESSION_TYPES.error_none;
	for(var i = 0; i < array_length(steps); i++)
	{
		if (string_count(OPENED_BRACKET,steps[i])+string_count(CLOSED_BRACKET,steps[i])>0)
		{
			for(var j = 0; j < i; j++)
			{
				if (string_count(string_concat(OPENED_BRACKET, j, CLOSED_BRACKET),steps[i])>0)
				{
					steps[i] = string_replace_all(steps[i], string_concat(OPENED_BRACKET, j, CLOSED_BRACKET), string_concat("",steps[j],""));
				}
			}
		}
		//steps[i] = solve_simple_expression(steps[i]);
		var SS = solve_simple_expression(steps[i]);
		if (SS.error == false)
		{
			steps[i] = SS.answer;
		} else {
			return {
				array_steps: ARRAY_BEFORE_VARS,
				result_total: array_length(steps) > 0 ? steps[array_length(steps)-1] : 0,
				type: EXPRESSION_TYPES.error_none
			};
		}
	}
	return {
		array_steps: ARRAY_BEFORE_VARS,
		result_total: array_length(steps) > 0 ? steps[array_length(steps)-1] : 0,
		type: EXPRESSION_TYPES.standard
	};
}

function check_ord_char(_char) {
	if (_char == "") return false;
	var _ord = ord(_char);
	return (
		(_ord >= 48 && _ord <= 57)  ||
		(_ord >= 65 && _ord <= 90)  ||
		(_ord >= 97 && _ord <= 122) ||
		(_ord == 95) ||
		(_char == "\\")
	);
};

function fast_expression(first, second, operator)
{
		switch(operator)
		{
			case "+": {
				first = first + second;
				break;	
			}
			case "-": {
				first = first - second;
				break;	
			}
			case "*": {
				first = first * second;
				break;
			}
			case "/": {
				first = first / second;
				break;
			}
			case "^": {
				first = power(first, second);
				break;
			}
		}
		return first;
}

function find_all_variables_setup()
{
	for(var i = 0; i < array_length(global.expressions_table); i++)
	{
		var exp_ = global.expressions_table[i].string_expression;
		if (string_pos("=", exp_)>0)
		{
			var char = string_copy(
				exp_,
				0, 
				string_pos("=", exp_)-1
			);
			var string_result = string_copy(exp_, 
				string_pos("=", exp_)+1, 
				string_length(exp_));
			var struct = return_expression_result(string_result);
			//if (char != "y")
			//{
				if (string_replace(char, " ", "") != "") {
					global.variables_set[$ char] = struct.result_total;
					global.expressions_table[i].variable_name = char;
					global.expressions_table[i].variable_value = struct.result_total;
				}
			//}
		}
	}
}

function draw_function(i, char, struct)
{
	var VARIABLE = char;
	var found_any_var = false;
	var found_any_equation = false;
	if (VARIABLE == "y")
	{
		var STEPS_NO_VARS = array_create(array_length(struct.array_steps));
						
		var deltax = global.preferences[$"POINTS_INCREASE_V"]; var MIN_x = -16; var MAX_x = 16;
		for(var index = MIN_x; index <= MAX_x; index+=deltax)
		{
			// vars
			var variables = {
				"x":index
			};
			var push = true;
						
			for(var A = 0; A < array_length(struct.array_steps); A++)
				STEPS_NO_VARS[A] = struct.array_steps[A];
						
			var p = ReplaceAllReferences(STEPS_NO_VARS, variables);
			STEPS_NO_VARS = p.GET_STEPS;
			if (p.GET_FOUND_VAR == true)
				found_any_var = true;
			for(var Z = 0; Z < array_length(STEPS_NO_VARS); Z++)
			{
				var _S = string_replace_all(string_replace_all(STEPS_NO_VARS[Z], ")", ""), "(", "");
				try {
					_S = real(_S);
				} catch(ex) {
					found_any_equation = true;
					break;
				}
			}
			// MATH
			for(var Z = 0; Z < array_length(STEPS_NO_VARS); Z++)
			{
				if (string_count(OPENED_BRACKET, STEPS_NO_VARS[Z]) + string_count(CLOSED_BRACKET, STEPS_NO_VARS[Z]) > 0)
				{
					for(var ZZ = 0; ZZ < Z+1; ZZ++)
					{
						var token = string_concat(OPENED_BRACKET, ZZ, CLOSED_BRACKET);
						if (string_count(token, STEPS_NO_VARS[Z]) > 0)
						{
							STEPS_NO_VARS[Z] = string_replace_all(STEPS_NO_VARS[Z], token, string_concat("", STEPS_NO_VARS[ZZ], ""));
						}
					}
				}
				//show_debug_message(STEPS_NO_VARS[Z]);
				var s = solve_simple_expression(STEPS_NO_VARS[Z]);
				if (s.error == false)
				{
					STEPS_NO_VARS[Z] = s.answer;
				} else {
					push = false; break;
				}
			}
						
			// point
			if (push) {
				array_push(global.expressions_table[i].graph_table, 
					new Point(index, array_length(STEPS_NO_VARS)>0 ? STEPS_NO_VARS[array_length(STEPS_NO_VARS)-1] : 0)
				);
			} else {
				array_push(global.expressions_table[i].graph_table, new Point(0,0,true));
			}
						
			for(var A = 0; A < array_length(struct.array_steps); A++)
				STEPS_NO_VARS[A] = struct.array_steps[A];
		}
		if (found_any_equation || found_any_var)
			global.expressions_table[i].expression_type = EXPRESSION_TYPES.draw_graphic;
	}	
}


/// @desc draw all functions, not a specific one
function draw_functions()
{
	for(var i = 0; i < array_length(global.expressions_table); i++)
	{
		var exp_ = global.expressions_table[i].string_expression;
		if (string_pos("=", exp_)>0)
		{
			var char = string_copy(
				exp_,
				0, 
				string_pos("=", exp_)-1
			);
			var string_result = string_copy(exp_, 
				string_pos("=", exp_)+1, 
				string_length(exp_));
			var struct = return_expression_result(string_result);
			if (char == "y")
			{
				draw_function(i, char, struct);
			}
		}
	}
}

function UpdateResults()
{
	global.variables_set = {};
	global.a = [];
	for(var i = 0; i < array_length(global.expressions_table); i++)
	{
		global.expressions_table[i].Reset();
	}	
	find_all_variables_setup();
	draw_functions();
	var array_string = struct_get_names(global.variables_set);
	var variables = "";
	
	for(var i = 0; i < array_length(global.expressions_table); i++)
	{
		var struct = return_expression_result(global.expressions_table[i].string_expression);
		if (global.expressions_table[i].expression_type != EXPRESSION_TYPES.draw_graphic)
		{
			if (struct.type == EXPRESSION_TYPES.movable
			|| struct.type == EXPRESSION_TYPES.standard)
			{
				global.expressions_table[i].result = struct.result_total;
				global.expressions_table[i].expression_type = struct.type;
			}
		}
	}	
}

function GetGlobalVariable(val)
{
	try {
		return real(struct_get(global.variables_set, val));	
	} catch(exp) {
		array_insert(global.expressions_table, 0, new Expression(string_concat(val, "=", 0)));
		UpdateResults();
		return GetGlobalVariable(val);
	};
}



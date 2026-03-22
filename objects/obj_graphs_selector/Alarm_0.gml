/// @description Change
if (!global.preferences[$"AUTORELOAD"]) return;

var expression = global.expressions_table[selected_expression];
var exp_ = expression.string_expression;
var res = false;
if (expression.expression_type == EXPRESSION_TYPES.draw_graphic)
{
	global.expressions_table[selected_expression].graph_table = [];
	global.expressions_table[selected_expression].result=0;
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
		if (string_result != "")
		{
			if (char == "x" or char == "y")
			{
				draw_function(selected_expression, char, struct);
				res = true;
			}
		}
	}
	
}
if (res == false) {
	UpdateResults();
}
flash_text = FLASH_TEXT_MAX;
draw_loadbg = false;
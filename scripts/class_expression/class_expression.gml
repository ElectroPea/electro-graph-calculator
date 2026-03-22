function Expression(str_exp = "") constructor {
	string_expression = str_exp;
	result = 0;
	expression_type = EXPRESSION_TYPES.standard;
	
	variable_name = "";
	variable_value = 0;
	min_move = -10;
	max_move = 10;
	step_move = 1; step_counter = 0; step_resetcounter = 16; step_launched = false;
	
	values = {}; show_graphic = true;
	graph_table = array_create(0, new Point(0, 0));
	color = HexcodeToColor("#0000ff");
	
	function Reset() {
		result = 0;
		expression_type = EXPRESSION_TYPES.standard;
	
		variable_name = "";
		variable_value = 0;
	
		values = {}; show_graphic = true;
		graph_table = array_create(0, new Point(0, 0));	
	}
}
// changing string
with(obj_popup) return;
var found_cursor = (mouse_x - x < 4 && mouse_x - x > -4);
if (STRETCH_PAR == false)
{
	if (found_cursor)
	{
		if (mouse_check_button_pressed(mb_left))
		{
			STRETCH_PAR = true;	
		}	
	}
} else {
	x = mouse_x;
	window_set_cursor(cr_size_we);
	if (mouse_check_button_released(mb_left))
	{
		STRETCH_PAR = false;	
	}
}
if (found_cursor)
{
	window_set_cursor(cr_size_we);
} else {
	if (window_get_cursor() == cr_size_we && STRETCH_PAR == false)
	{
		window_set_cursor(cr_default);
	}
}



if (array_length(global.expressions_table)==0) return;
var expression = global.expressions_table[selected_expression];
if (keyboard_check_pressed(lastkey_to_virt(keyboard_lastkey)) && lastkey_to_virt(keyboard_lastkey) != vk_shift)
{
	if (!keyboard_check(vk_control) && !keyboard_check(vk_alt))
	{
		key_pressed = 1;
		if (keyboard_lastkey == vk_backspace)
		{
			expression.string_expression = string_copy(expression.string_expression, 0, string_length(expression.string_expression)-1);
		} else {
			expression.string_expression = expression.string_expression + keyboard_lastchar;
		}
		//expression.variable_value = 0; expression.variable_name = "";
	}
}
if (keyboard_check_released(vk_anykey))
{
	if (!keyboard_check(vk_control) && !keyboard_check(vk_alt) && lastkey_to_virt(keyboard_lastkey) != vk_control && lastkey_to_virt(keyboard_lastkey) != vk_alt) {
		key_pressed = 0;
		alarm[0] = 2;
	}
}
if (alarm[0] == 1) draw_loadbg = true;

flash_text--; if (flash_text <= 0) flash_text = FLASH_TEXT_MAX;

for(var INDEX = 0; INDEX < array_length(global.expressions_table); INDEX++)
{
	if point_in_rectangle(mouse_x, mouse_y, x+5, y+INDEX*PREFERENCES.BUTTON_HEIGHT + 5, room_width-5, y+(INDEX+1)*PREFERENCES.BUTTON_HEIGHT)
	{
		if (mouse_check_button_pressed(mb_left))
		{
			selected_expression = INDEX;
		}
		if (mouse_check_button_released(mb_middle))
		{
			selected_expression = max(0, INDEX-1);
			array_delete(global.expressions_table, INDEX, 1);
			if (array_length(global.expressions_table)==0) return;
			key_pressed = 0;
			alarm[0] = 2;
		}
		if (mouse_check_button_pressed(mb_right))
		{
			selected_expression = INDEX;
			with(obj_menu_dropmenu)
				instance_destroy();
			if (global.expressions_table[selected_expression].expression_type == EXPRESSION_TYPES.movable)
			{
				with(instance_create_depth(mouse_x, mouse_y, -999, obj_menu_dropmenu))
				{
					name = "_graph_popup";
					prev_id = 0;
				}
			} 
			else if (global.expressions_table[selected_expression].expression_type == EXPRESSION_TYPES.draw_graphic)
			{
				with(instance_create_depth(mouse_x, mouse_y, -999, obj_menu_dropmenu))
				{
					name = "_graphic_popup";
					prev_id = 0;
				}
			}
		}
	}
}

// for variables launch

for(var INDEX = 0; INDEX < array_length(global.expressions_table); INDEX++)
{
	var _exp = global.expressions_table[INDEX];
	if (_exp.expression_type == EXPRESSION_TYPES.movable)
	{
		if (_exp.step_launched)
		{
			_exp.step_counter += 1;
			if (_exp.step_resetcounter == _exp.step_counter)
			{
				_exp.step_counter = 0;
				_exp.variable_value = max(_exp.min_move, min(_exp.variable_value + _exp.step_move, _exp.max_move));
				if (_exp.variable_value == _exp.max_move || _exp.variable_value == _exp.min_move)
					_exp.step_move *= -1;
				_exp.string_expression = string_concat(_exp.variable_name, "=", _exp.variable_value);
				UpdateResults();
			}
		}
	}
}
if (array_length(global.expressions_table) > 0)
{
	var _s_exp = global.expressions_table[selected_expression];
	if (_s_exp.expression_type == EXPRESSION_TYPES.movable)
	{
		if (!_s_exp.step_launched)
		{
			var MIN = _s_exp.min_move; var MAX = _s_exp.max_move;
			var x0 = (x+28 + string_width(string(MIN)));
			var x1 = (x+7+ (room_width-x-10)-2 - string_width(string(MAX)));
			var Y = y + selected_expression*PREFERENCES.BUTTON_HEIGHT + (PREFERENCES.BUTTON_HEIGHT - 16) -2;
			if (mouse_check_button(mb_left) && mouse_y <= Y+12+8 && mouse_y >= Y+12-8)
			{
				var percent = (mouse_x - x0) / (x1 - x0);
				_s_exp.variable_value = ((MAX - MIN) * percent) + MIN;
				if (_s_exp.variable_value >= 0) {
					_s_exp.variable_value = round(_s_exp.variable_value / _s_exp.step_move) * _s_exp.step_move;
				} else {
					_s_exp.variable_value = -round(abs(_s_exp.variable_value) / _s_exp.step_move) * _s_exp.step_move;
				}
				if (_s_exp.variable_value < MIN)
					_s_exp.variable_value = MIN;
				if (_s_exp.variable_value > MAX)
					_s_exp.variable_value = MAX;
				_s_exp.string_expression = string_concat(_s_exp.variable_name, "=", _s_exp.variable_value);
				UpdateResults();
			}
		}
	}
}
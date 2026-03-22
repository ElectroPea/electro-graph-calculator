draw_reset()
var found_cursor = (mouse_x - x < 8 && mouse_x - x > -8);
draw_set_color(found_cursor ? 
HexcodeToColor(global.colors.RIGHTMENU.dragoutl)
: HexcodeToColor(global.colors.RIGHTMENU.outline)
);
draw_rectangle(x-2, y, room_width, room_height, false);
draw_set_color(HexcodeToColor(global.colors.RIGHTMENU.bg));
draw_rectangle(x, y, room_width, room_height, false);
if (array_length(global.expressions_table) > 0)
{
	for(var INDEX = 0; INDEX < array_length(global.expressions_table); INDEX++)
	{
		if (point_in_rectangle(mouse_x, mouse_y, x+5, y+INDEX * PREFERENCES.BUTTON_HEIGHT + 5, room_width-5, y+(INDEX+1)*PREFERENCES.BUTTON_HEIGHT)) {
			draw_set_color(selected_expression == INDEX ? 
			HexcodeToColor(global.colors.RIGHTMENU.SELECTED.bghover)
			: HexcodeToColor(global.colors.RIGHTMENU.STATIC.bghover));
		} else {
			draw_set_color(selected_expression == INDEX ? 
			HexcodeToColor(global.colors.RIGHTMENU.SELECTED.bgnone)
			: HexcodeToColor(global.colors.RIGHTMENU.STATIC.bgnone));
		}
		draw_rectangle(x+5, y+INDEX*PREFERENCES.BUTTON_HEIGHT + 5, room_width-5, y+(INDEX+1)*PREFERENCES.BUTTON_HEIGHT, false);
		draw_set_color(HexcodeToColor(global.colors.RIGHTMENU.outline));
		draw_rectangle(x+5, y+INDEX*PREFERENCES.BUTTON_HEIGHT + 5, room_width-5, y+(INDEX+1)*PREFERENCES.BUTTON_HEIGHT, true);
		
		if (global.expressions_table[INDEX].expression_type == EXPRESSION_TYPES.draw_graphic)
		{
			draw_set_color(selected_expression == INDEX ? 
			HexcodeToColor(struct_get(global.colors.RIGHTMENU.SELECTED, "type.graphic"))
			: HexcodeToColor(struct_get(global.colors.RIGHTMENU.STATIC, "type.graphic")));
		} else if (global.expressions_table[INDEX].expression_type == EXPRESSION_TYPES.error_none)
		{
			draw_set_color(selected_expression == INDEX ? 
			HexcodeToColor(struct_get(global.colors.RIGHTMENU.SELECTED, "type.error"))
			: HexcodeToColor(struct_get(global.colors.RIGHTMENU.STATIC, "type.error")));
		} else {
			draw_set_color(selected_expression == INDEX ? 
			HexcodeToColor(struct_get(global.colors.RIGHTMENU.SELECTED, "type.other"))
			: HexcodeToColor(struct_get(global.colors.RIGHTMENU.STATIC, "type.other")));
		}
	
		draw_rectangle(x+5, y+INDEX*PREFERENCES.BUTTON_HEIGHT+5, x+5+17, y+(INDEX+1)*PREFERENCES.BUTTON_HEIGHT, false);
		draw_set_color(HexcodeToColor(global.colors.RIGHTMENU.outline));
		draw_rectangle(x+5, y+INDEX*PREFERENCES.BUTTON_HEIGHT+5, x+5+17, y+(INDEX+1)*PREFERENCES.BUTTON_HEIGHT, true);
		
		draw_set_font(font_arial);
		draw_set_halign(fa_center);
		draw_set_color(HexcodeToColor(global.colors.RIGHTMENU.bgtext));
		draw_text(x+15, y+INDEX*PREFERENCES.BUTTON_HEIGHT+10, INDEX+1);
		
		draw_set_font(font_types);
		draw_set_halign(fa_left);
		draw_set_color(HexcodeToColor(global.colors.RIGHTMENU.expressioncolor));
		draw_text(x+7 + 20, y+INDEX*PREFERENCES.BUTTON_HEIGHT+7,  string_concat(
			global.expressions_table[INDEX].string_expression,
				(flash_text < FLASH_TEXT_MAX/2 && selected_expression == INDEX) ? "|" : ""
		));
	
		if (global.expressions_table[INDEX].expression_type == EXPRESSION_TYPES.standard)
		{
			draw_set_halign(fa_right);
			draw_set_color(HexcodeToColor(global.colors.RIGHTMENU.answercolor));
			draw_text(x+7 + (room_width-x-10)-2, y + INDEX*PREFERENCES.BUTTON_HEIGHT + (PREFERENCES.BUTTON_HEIGHT - 16) -2, string_concat(
				"=",
				string(global.expressions_table[INDEX].result)
			));
		} else if (global.expressions_table[INDEX].expression_type == EXPRESSION_TYPES.movable)
		{
			var Y = y + INDEX*PREFERENCES.BUTTON_HEIGHT + (PREFERENCES.BUTTON_HEIGHT - 16) -2;
			var MIN = global.expressions_table[INDEX].min_move;
			var MAX = global.expressions_table[INDEX].max_move;
			draw_set_color(HexcodeToColor(global.colors.RIGHTMENU.answercolor));
			draw_set_halign(fa_left);
			draw_text(x+28, Y,
				string(global.expressions_table[INDEX].min_move)
			);
			draw_set_halign(fa_right);
			draw_text(x+7+ (room_width-x-10)-2, Y,
				string(global.expressions_table[INDEX].max_move)
			);
			
			draw_set_color(HexcodeToColor(global.colors.RIGHTMENU.rectmove));
			draw_set_halign(fa_left);
			draw_rectangle(x+28 + string_width(string(MIN))+4, Y-2 + 10, x + (room_width-x-10)+1 - string_width(string(MAX)), Y+2 + 10, false);
			
			/// sprite_drawing
			
			draw_set_halign(fa_left);
			var percent = ((global.expressions_table[INDEX].variable_value-MIN) / (MAX-MIN));
			//draw_text(x+32, Y-16, percent);
			
			var x0 = (x+7+ (room_width-x-10)-2 - string_width(string(MAX)));
			var x1 = (x+28 + string_width(string(MIN)));
			var delta =	x0 - x1;
			
			//draw_sprite(spr_variables_holder, -1, 
			//	x1 + delta*percent, Y+10
			//);
			draw_sprite_ext(spr_variables_holder, -1, x1 + delta*percent, Y+10, 1, 1, 0, 
				HexcodeToColor(global.colors.RIGHTMENU.rectmove)
			, 1)
		} else if (global.expressions_table[INDEX].expression_type == EXPRESSION_TYPES.draw_graphic)
		{
			if (global.expressions_table[INDEX].show_graphic == false)
			{
				var Y = y + INDEX*PREFERENCES.BUTTON_HEIGHT + (PREFERENCES.BUTTON_HEIGHT - 16) -2;
				draw_sprite(spr_eye, -1, x+7 + 2 + 5, Y + 10);
			}
		}
	}
}

//if (draw_loadbg)
//{
//	draw_set_alpha(0.5);
//	draw_set_color(#000000);
//	draw_set_halign(fa_left);
//	draw_text(4, 600-16, "LOADING..");
//	draw_set_alpha(1); draw_set_color(#ffffff);
//}


//draw_set_color(#FF0000)
//draw_set_halign(fa_left);
//draw_text(4, 4, string(global.variables_set));
//draw_text(4, 4+16*1, string(alarm[0]));
//draw_text(4, 4+16*2, string(flash_text));
//drawing bg
draw_reset()
draw_set_color(HexcodeToColor(global.colors.BOARD.bg));
draw_rectangle(x, y, board_width, board_height, false);

// drawing grid
var temp_offset_x = offset_x;
var temp_offset_y = offset_y;

if (curstate == STATES.STATE_MOVING)
{
	temp_offset_x = offset_x + (mouse_x - mouse_prevpos_x);
	temp_offset_y = offset_y + (mouse_y - mouse_prevpos_y);
}
var GRIDX = global.preferences[$"BOARD.PX"];
var GRIDY = global.preferences[$"BOARD.PY"];

if (global.preferences[$ "GRID"] == true)
{
	draw_set_color(HexcodeToColor(global.colors.BOARD.grid));
	draw_grid_box(board_step_x, temp_offset_x, board_center_x, board_height, true);
	draw_grid_box(-board_step_x, temp_offset_x, board_center_x, board_height, true);
	draw_grid_box(board_step_y, temp_offset_y, board_center_y, board_width, false);
	draw_grid_box(-board_step_y, temp_offset_y, board_center_y, board_width, false);

	draw_set_color(HexcodeToColor(global.colors.BOARD.griddark));
	draw_grid_box(board_step_x * GRIDX, temp_offset_x, board_center_x, board_height, true);
	draw_grid_box(-board_step_x * GRIDX, temp_offset_x, board_center_x, board_height, true);
	draw_grid_box(board_step_y * GRIDY, temp_offset_y, board_center_y, board_width, false);
	draw_grid_box(-board_step_y * GRIDY, temp_offset_y, board_center_y, board_width, false);
	
	draw_line(board_center_x + temp_offset_x, 0, board_center_x + temp_offset_x, board_height);
	draw_line(0, board_center_y + temp_offset_y, board_width, board_center_y + temp_offset_y);
	
}
//base
if (board_center_x + temp_offset_x <= board_width && board_center_x + temp_offset_x >= 0)
{
	if (global.preferences[$ "AXIS.y"]) 
	{
		draw_set_color(HexcodeToColor(global.colors.BOARD.basegrid));
		draw_line(board_center_x + temp_offset_x, 0, board_center_x + temp_offset_x, board_height);
		
		//draw_sprite(spr_arrow, -1, board_center_x + temp_offset_x, 0);
		//draw_tra
		//draw_sprite(spr_arrow, -1, board_center_x + temp_offset_x, board_height);
		
		if (global.preferences[$ "ARROWS"]) {
			draw_sprite_ext(spr_arrow, -1, 
				board_center_x + temp_offset_x, 
				16 + sprite_get_height(spr_arrow),
			1,1,0,#ffffff,1);
			draw_sprite_ext(spr_arrow, -1, 
				board_center_x + temp_offset_x,
				board_height - sprite_get_height(spr_arrow), 
			1,1,180,#ffffff,1);
		}
	}
}
if (board_center_y + temp_offset_y <= board_height && board_center_y + temp_offset_y >= 0)
{
	if (global.preferences[$ "AXIS.x"]) 
	{
		draw_set_color(HexcodeToColor(global.colors.BOARD.basegrid));
		draw_line(0, board_center_y + temp_offset_y, board_width, board_center_y + temp_offset_y);
		
		//if (global.preferences[$ "ARROWS"]) {
		//	draw_sprite_ext(spr_arrow, -1, 0, board_center_y + temp_offset_y, 1,1,-90,#ffffff,1);
		//	draw_sprite_ext(spr_arrow, -1, board_width, board_center_y + temp_offset_y, 1,1,90,#ffffff,1);
		//}
		
		if (global.preferences[$ "ARROWS"]) {
			draw_sprite_ext(spr_arrow, -1, 
				0+sprite_get_width(spr_arrow), 
				board_center_y + temp_offset_y,
			1,1,90,#ffffff,1);
			draw_sprite_ext(spr_arrow, -1, 
				obj_graphs_selector.x-sprite_get_width(spr_arrow), 
				board_center_y + temp_offset_y,
			1,1,-90,#ffffff,1);
		}
	}
}
draw_set_color(HexcodeToColor(global.colors.BOARD.basegrid));
draw_set_font(font_arial);

var max_x = floor(board_width div board_step_x / GRIDX);
var center_x = floor(temp_offset_x div board_step_x / GRIDX);

for(var 
	gridX = -floor((board_center_x+temp_offset_x) div board_step_x / GRIDX);
	gridX < floor((board_center_x-temp_offset_x) div board_step_x / GRIDX)+1;
	gridX ++)
if (board_center_y + temp_offset_y <= board_height && board_center_y + temp_offset_y >= 0 && global.preferences[$ "AXIS.x"])
	draw_text(board_center_x + temp_offset_x + board_step_x*GRIDX*gridX - board_step_x, board_center_y + temp_offset_y, string(gridX));

for(var 
	gridY = -floor((board_center_y+temp_offset_y) div board_step_y / GRIDY);
	gridY < floor((board_center_y-temp_offset_y) div board_step_y / GRIDY)+1;
	gridY ++)
if (board_center_x + temp_offset_x <= board_width && board_center_x + temp_offset_x >= 0 && global.preferences[$ "AXIS.y"])
	draw_text(board_center_x + temp_offset_x - board_step_y, board_center_y + temp_offset_y + board_step_y*5*gridY, string(-gridY));


for(var i = 0; i < array_length(global.expressions_table); i++)
{
    var _exp = global.expressions_table[i];
	draw_set_color(_exp.color);
    if (array_length(_exp.graph_table) > 0 && _exp.show_graphic)
    {
        for(var index = 0; index < array_length(_exp.graph_table)-1; index++)
        {
			if (_exp.graph_table[index+1]._error) continue;
            var _X = _exp.graph_table[index].GetX();
            var _Y = _exp.graph_table[index].GetY();
            var _X1 = _exp.graph_table[index+1].GetX();
            var _Y1 = _exp.graph_table[index+1].GetY();
			var size_line = 10;
			for(var x_S = max(-1,round(-board_step_x/size_line)); x_S < max(1,round(board_step_x/size_line)); x_S++)
			{
				for(var y_S = max(-1,round(-board_step_y/size_line)); y_S <  max(1,round(board_step_y/size_line)); y_S++)
				{
					draw_line(
						board_center_x + board_step_x*5*_X + temp_offset_x + x_S,
						board_center_y - board_step_y*5*_Y + temp_offset_y + y_S,
						board_center_x + board_step_x*5*_X1 + temp_offset_x + x_S,
						board_center_y - board_step_y*5*_Y1 + temp_offset_y + y_S
					);	
				}
			}
        }
    }
}





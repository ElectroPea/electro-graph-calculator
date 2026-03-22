with(obj_popup) return;
var hovermenus = false;
with(obj_menu_dropmenu)
	if (chosenel != -1) { hovermenus = true; break; }
if (mouse_y <= 16) hovermenus = true;
with(obj_graphs_selector)
	if (x <= mouse_x) { hovermenus = true; break; }
				
switch(curstate)
{
	case STATES.STATE_NONE:
	{
		if (mouse_check_button_pressed(mb_left) && hovermenus == false)
		{
			with(obj_menu_dropmenu)
				instance_destroy()
			mouse_prevpos_x = mouse_x;
			mouse_prevpos_y = mouse_y;
			curstate = STATES.STATE_MOVING;	
		}
		
		break;	
	}
	case STATES.STATE_MOVING:
	{
		if (mouse_check_button_released(mb_left))
		{
			offset_x += (mouse_x - mouse_prevpos_x)
			offset_y += (mouse_y - mouse_prevpos_y)
			curstate = STATES.STATE_NONE;	
		}
		break;	
	}
}
var w = mouse_wheel_up() - mouse_wheel_down();
var wheel = (w > 0) ? 1.1 : ((w < 0) ? 0.9 : 0);
if (wheel != 0)
{
    if (keyboard_check(vk_shift) && keyboard_check(vk_control))
    {
        board_step_y = max(4, min(24, board_step_y * wheel));
    }
    else if (keyboard_check(vk_shift))
    {
        board_step_x = max(4, min(24, board_step_x * wheel));
    }
    else
    {
        board_step_x = max(4, min(24, board_step_x * wheel));
        board_step_y = max(4, min(24, board_step_y * wheel));
    }
}


//if (instance_find(obj_graphs_selector, 1) != -4)
//{
//	Print("yeah")
//	board_width = obj_graphs_selector.x;
//}
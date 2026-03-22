//with(obj_popup) return;
var pressed = point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom) && mouse_check_button(mb_left)
sprite_index = sprite_indexs.stat;
if (pressed) sprite_index = sprite_indexs.pres;

if (point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom) && mouse_check_button_released(mb_left))
{
	sprite_index = sprite_indexs.stat;
	OnPress(POPUP_ID, NEXT_FUNCTION);
}
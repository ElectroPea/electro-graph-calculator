
var struct_total = struct_get(global.menu, name);
var _MAX_L = 0; var _MAX_W = 0;


var keys_comb = [];
for(var i = 0; i < array_length(struct_total.buttons); i++) {
	var c = struct_total.buttons[i];
	var text = "";
	for(var K = 0; K < array_length(c._comb); K++)
	{
		text += key_to_string(c._comb[K]);
		if (K < array_length(c._comb)-1) text += "+";
	}
	array_push(keys_comb, text);
};


for(var i = 0; i < array_length(struct_total.buttons); i++)
{
	var curb = struct_total.buttons[i];
	var TEXT = string_concat(curb._name, string_repeat(" ", keys_comb[i] != "" ? 1 : 0), keys_comb[i]);
	_MAX_W = max(_MAX_W, string_width(TEXT));
	_MAX_L = max(_MAX_L, string_length(TEXT));
}

chosenel = -1;
for(var i = 0; i < array_length(struct_total.buttons); i++)
{
	var curb = struct_total.buttons[i];
	var hitbox = {
		x0: x+2, 
		y0: y+(i)*18,
		w: _MAX_W,
		h: string_height("A")
	};
	var mouse_contains = point_in_rectangle(mouse_x, mouse_y, hitbox.x0, hitbox.y0, hitbox.x0 + hitbox.w, hitbox.y0 + hitbox.h);
	if (mouse_contains)
	{
		chosenel = i;
		break;
	}
}
if (chosenel != -1)
{
	var curb = struct_total.buttons[chosenel];
	if (mouse_check_button_pressed(mb_left))
	{
		with(obj_popup) return;
		with(obj_menu_dropmenu)
		{
			if (other.prev_id+1<=prev_id)
				instance_destroy()
		}
		if (curb._ptrnewDropMenu != "")
		{
			with(instance_create_depth(x + _MAX_W + 4 + (keys_comb[chosenel] == "" ? 4 : 0), y+(chosenel)*18, -999, obj_menu_dropmenu))
			{
				name = curb._ptrnewDropMenu;
				prev_id = other.prev_id + 1;
			}
		} else {
			curb._func();
		}
	}
	if (mouse_check_button_released(mb_left))
	{
		if (curb._ptrnewDropMenu == ""){
			with(obj_menu_dropmenu)
				instance_destroy();
		}
	}
}
draw_self();
var struct_total = struct_get(global.menu, name);
draw_set_color(#000000); draw_set_halign(fa_left); draw_set_valign(fa_top);
draw_set_font(font_options);
// max length

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


var max_stringlength_id = 0;
for(var i = 0; i < array_length(struct_total.buttons); i++)
{
	var f0 = struct_total.buttons[max_stringlength_id]; var f1 = struct_total.buttons[i];
	if (string_length(f1._name) < string_length(f0._name))
		max_stringlength_id = i;
}

///////
var _MAX_L = 0; var _MAX_W = 0;
for(var i = 0; i < array_length(struct_total.buttons); i++)
{
	var curb = struct_total.buttons[i];
	var TEXT = string_concat(curb._name, string_repeat(" ", keys_comb[i] != "" ? 1 : 0), keys_comb[i]);
	_MAX_W = max(_MAX_W, string_width(TEXT));
	_MAX_L = max(_MAX_L, string_length(TEXT));
}

draw_set_color(HexcodeToColor(global.colors.UPPERMENU.outline));
draw_rectangle(x-2, y-2, x+2 + _MAX_W + 4, y+2 + array_length(struct_total.buttons) * 18, false);
draw_set_color(HexcodeToColor(global.colors.UPPERMENU.bg));
draw_rectangle(x, y, x + _MAX_W + 4, y + array_length(struct_total.buttons) * 18, false);

for(var i = 0; i < array_length(struct_total.buttons); i++)
{
	draw_set_valign(fa_bottom);
	var curb = struct_total.buttons[i];
	var maxb = struct_total.buttons[max_stringlength_id];
	if (curb._name != "")
	{
		if (chosenel == i) // chosen one
		{
			draw_set_color(mouse_check_button(mb_left) ? 
			HexcodeToColor(global.colors.UPPERMENU.buttons.PRESSED.bg) : 
			HexcodeToColor(global.colors.UPPERMENU.buttons.HOVER.bg));
			var y0 = y+(i+1)*18+2;
			draw_rectangle(x, y0 - string_height(curb._name)-1, x +_MAX_W + 4, y0-2, false);
			draw_set_color(mouse_check_button(mb_left) ? 
			HexcodeToColor(global.colors.UPPERMENU.buttons.PRESSED.textcolor) : 
			HexcodeToColor(global.colors.UPPERMENU.buttons.HOVER.textcolor));
		} else {
			draw_set_color(HexcodeToColor(global.colors.UPPERMENU.buttons.STATIC.textcolor));
		}
		draw_set_halign(fa_left);
		draw_text(x+2, y+2+(i+1)*18, curb._name);
		if (chosenel == i)
		{
			draw_set_color(mouse_check_button(mb_left) ? 
			HexcodeToColor(global.colors.UPPERMENU.buttons.PRESSED.texthint) : 
			HexcodeToColor(global.colors.UPPERMENU.buttons.HOVER.texthint));
		} else {
			draw_set_color(HexcodeToColor(global.colors.UPPERMENU.buttons.STATIC.texthint));
		}
		draw_set_halign(fa_right);
		draw_text(x+2 + _MAX_W, y+2+(i+1)*18, keys_comb[i]);
	} else {
		draw_set_halign(fa_left);
		draw_set_color(HexcodeToColor(global.colors.UPPERMENU.buttons.STATIC.texthint));
		draw_text(x+2, y+2+(i+1)*18, string_repeat("-", _MAX_L));
	}
}
draw_set_valign(fa_top); draw_set_halign(fa_left);





// drawing grid
var tx = offset_x;
var ty = offset_y;

if (curstate == STATES.STATE_MOVING)
{
	tx = offset_x + (mouse_x - mouse_prevpos_x);
	ty = offset_y + (mouse_y - mouse_prevpos_y);
}

draw_sprite_ext(spr_popup_window, -1, x+tx, y+ty, 
	size.GetX() / sprite_get_width(spr_popup_window)
	, 
	size.GetY() / sprite_get_height(spr_popup_window)
	, 0, #ffffff, 1);
	
draw_set_font(font_options); draw_set_halign(fa_left); draw_set_valign(fa_top); draw_set_color(c_black);

draw_sprite(
	spr_popup_icon, 
	icontype,
x+tx+4, y+ty+3)
draw_text(x+tx+4 + 14, y+ty-2, title);

var _x=x+tx+size._x-sprite_get_width(spr_popup_close)-4; var _y=y+ty+4;
var close = point_in_rectangle(mouse_x, mouse_y, _x,_y, _x+sprite_get_width(spr_popup_close),_y+sprite_get_height(spr_popup_close));
var index = 0;
if (close)
{
	index = 1;
	if (mouse_check_button(mb_left))
		index = 2;
}

draw_sprite(spr_popup_close, index, _x, _y);

for(var i = 0; i < array_length(content); i++)
{
	var CONTENTDIV = content[i];
	var pos = CONTENTDIV._pos;
	switch(CONTENTDIV._type)
	{
		case CONTENT_TYPE.sampletext:
		{
			draw_text(x+tx + 2 + pos._x, y+ty + 17 + pos._y, CONTENTDIV._content.text);
			break;	
		}
		case CONTENT_TYPE.typable:
		{
			var px = x+tx + 2 + pos._x; var py = y+ty + 17 + pos._y + 2;
			var px1 = px + CONTENTDIV._content.maxw; var py1 = py + 12;
			
			draw_set_color(chosen_textdiv == i ? #4f5366 : #1e212e);
			draw_rectangle(px-2,py-2,px1+2,py1+4,false);
			draw_set_color(#eae5ff);
			draw_rectangle(px,py,px1,py1,false);
			
			draw_set_color(c_black);
			draw_text(px + 2, py - 4, string_concat(CONTENTDIV._content.text,
				(t < 30 && chosen_textdiv == i) ? "|" : ""
			));
			break;
		}
		case CONTENT_TYPE.photo:
		{
			var px = x+tx + 2 + pos._x; var py = y+ty + 17 + pos._y + 2;
			draw_sprite(CONTENTDIV._content.sprite, -1, px, py);
			break;	
		}
		case CONTENT_TYPE.space:
		{
			var px = x+tx + 2 + pos._x; var py = x+ty + 17 + pos._y + 2;
			draw_set_color(#525169); 
			draw_text(px, py, string_repeat("-", (size._x/string_width("-"))-1));
		}
	}
}
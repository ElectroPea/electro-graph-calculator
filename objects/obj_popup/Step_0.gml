switch(curstate)
{
	case STATES.STATE_NONE:
	{
		var px = x + offset_x; var py = y + offset_y;
		var px1 = px + size._x; var py1 = py + size._y;
		if (mouse_check_button_pressed(mb_left) &&
			point_in_rectangle(mouse_x, mouse_y, px, py, px1, py + 16)
		)
		{
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

// close button
var _x=x+offset_x+size._x-sprite_get_width(spr_popup_close)-4; var _y=y+offset_y+4;
var close = point_in_rectangle(mouse_x, mouse_y, _x,_y, _x+sprite_get_width(spr_popup_close),_y+sprite_get_height(spr_popup_close));
if ((close and mouse_check_button_released(mb_left)) || keyboard_check_pressed(vk_escape))
{
	f_close();
	return;
}

for(var i = 0; i < array_length(content); i++)
{
	var CONTENTDIV = content[i];
	var pos = CONTENTDIV._pos;
	
	if (CONTENTDIV._type == CONTENT_TYPE.typable)
	{
		var px = x+offset_x + 2 + pos._x; var py = y+offset_y + 17 + pos._y + 2;
		var px1 = px + CONTENTDIV._content.maxw; var py1 = py + 12;
		var inbox = point_in_rectangle(mouse_x, mouse_y, px,py,px1,py1);
		if (inbox && mouse_check_button_pressed(mb_left))
		{
			chosen_textdiv = i;
		}
	}
	else if (CONTENTDIV._type = CONTENT_TYPE.obj)
	{
		var ID = CONTENTDIV._content.objid;
		if (ID != -4)
		{
			if (!struct_exists(CONTENTDIV._content, "deltapos"))
			{
				struct_set(CONTENTDIV._content, "deltapos", 
					new Point(
						x + CONTENTDIV._pos._x, 
						y + CONTENTDIV._pos._y
					)
				);
			}
			var dp = struct_get(CONTENTDIV._content, "deltapos")
			var tx = offset_x;
			var ty = offset_y;

			if (curstate == STATES.STATE_MOVING)
			{
				tx = offset_x + (mouse_x - mouse_prevpos_x);
				ty = offset_y + (mouse_y - mouse_prevpos_y);
			}

			ID.x = dp._x + tx;
			ID.y = dp._y + ty;
			
			ID.x += ID.image_xscale/2*sprite_get_width(ID.sprite_indexs.stat);
			ID.y += ID.image_yscale/2*sprite_get_height(ID.sprite_indexs.stat);
		}
	}
}
if (chosen_textdiv != -1)
{
	var CONTENTDIV = content[chosen_textdiv];
	t --; if (t < 0) t = 60;
	
	if (keyboard_check_pressed(lastkey_to_virt(keyboard_lastkey)) && lastkey_to_virt(keyboard_lastkey) != vk_shift) {
		if (!keyboard_check(vk_control) && !keyboard_check(vk_alt)) {
			var prev = CONTENTDIV._content.text;
			if (keyboard_lastkey == vk_backspace) {
				CONTENTDIV._content.text = string_copy(CONTENTDIV._content.text, 0, string_length(CONTENTDIV._content.text)-1);
			} else {
				CONTENTDIV._content.text = CONTENTDIV._content.text + keyboard_lastchar;
			}
			if (prev != CONTENTDIV._content.text) CONTENTDIV._content.OnChanged(CONTENTDIV._content.text);
		}
	}
}





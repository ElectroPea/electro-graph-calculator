//for(var i = 0; i < 
with(obj_popup) return;
if (keyboard_check_pressed(vk_anykey))
{
	var LASTKEY_ID = -1;
	var BREAK = false;
	var keys = struct_get_names(global.menu);
	for(var i = 0; i < array_length(keys); i++)
	{
		var j = struct_get(global.menu, keys[i]);
		if (BREAK) break;
		for(var button_ID = 0; button_ID < array_length(j.buttons); button_ID++)
		{
			var KEYS_COMB = j.buttons[button_ID]._comb;
			if (BREAK) break;
			if (array_length(KEYS_COMB) > 0)
			{
				for(var lastKey = 0; lastKey < array_length(KEYS_COMB); lastKey++)
				{
					if (array_length(keys_total_comb) < array_length(KEYS_COMB))
					{
						if (KEYS_COMB[array_length(keys_total_comb)] == lastkey_to_virt(keyboard_lastkey))
						{
							LASTKEY_ID = KEYS_COMB[array_length(keys_total_comb)];
							if (LASTKEY_ID == KEYS_COMB[array_length(KEYS_COMB)-1])
							{
								j.buttons[button_ID]._func();
								LASTKEY_ID=-1;
							}
							BREAK = true; break;
						}	
					}
				}
			}
		}
	}
	if (LASTKEY_ID != -1)
		array_push(keys_total_comb, LASTKEY_ID);
}

if (array_length(keys_total_comb)>0)
for(var i =0; i<array_length(keys_total_comb);i++)
	if (!keyboard_check(keys_total_comb[i])) array_delete(keys_total_comb, i, 1);
function key_to_string(k) {
	switch(k)
	{
		case vk_tab: return "Tab";
		case vk_control: return "Ctrl";
		case vk_alt: return "Alt";
		case vk_shift: return "Shift";
		case vk_space: return "Space";
	}
	if (k >= 97 -(97-65) && k <= 122-(97-65)) return string_upper(chr(k));	
}

function lastkey_to_virt(n)
{
	switch(n)
	{
		case 162: return vk_control;
		case 164: return vk_alt;
		case 16: return vk_shift;
		case 9: return vk_tab;
	}
	return keyboard_lastkey;
}
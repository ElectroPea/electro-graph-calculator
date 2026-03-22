function HexcodeToColor(_hexcodeString, _default = c_black)
{
    if (not is_string(_hexcodeString))
    {
        return is_numeric(_hexcodeString)? _hexcodeString : _default;
    }

    try
    {
        var _color = int64(ptr(string_replace(_hexcodeString, "#", "")));
        _color = ((_color & 0xFF0000) >> 16) | (_color & 0x00FF00) | ((_color & 0x0000FF) << 16);
        return _color;
    }
    catch(_exception)
    {
        return _default;
    }
}

function ColorToHex(col) 
{
    var r = color_get_red(col);
    var g = color_get_green(col);
    var b = color_get_blue(col);
	
    var hex = "#" + 
              byte_to_hex(r) + 
              byte_to_hex(g) + 
              byte_to_hex(b);
              
    return hex;
}
function byte_to_hex(byte) 
{
    var hex_digits = "0123456789ABCDEF";
    var high = (byte div 16) + 1;
    var low = (byte mod 16) + 1;
    
    return string_char_at(hex_digits, high) + string_char_at(hex_digits, low);
}






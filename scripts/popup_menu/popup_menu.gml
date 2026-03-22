function popup_save() {
	var text = "";
	for(var i = 0; i < array_length(global.expressions_table); i++)
		text += global.expressions_table[i].string_expression + (i < array_length(global.expressions_table) ? "\n" : "");
		
	var fn = get_save_filename("Text Files (*.txt)|*.txt", "*.txt"); 
	if (fn != "") {
		try
		{
			var file = file_text_open_write(fn); 
			file_text_write_string(file, text); 
			file_text_close(file);
		}
	}
}

/// @desc Warning to save a file.
function popup_savewarning(NEXTFUNCTION = function() {})
{
	var popupid = noone; var s = new Point(200, 92);
	with(instance_create_depth(window_get_width()/2 - s._x/2, window_get_height()/2 - s._y/2, -10, obj_popup))
	{
		size = s;
		icontype = WINDOW_ICON.warning;
		title = "Warning";
		content = [
			new ContentDiv(CONTENT_TYPE.sampletext, new Point(8, 8), "Want to save your changes?")
		];
		popupid = id;
		
		
		#region YES Button
			var b1 = instance_create_depth(
				window_get_width()/2 - s._x/2 +8 + 32/2*3, 
				window_get_height()/2 - s._y/2 +8 + 40 + 32/2*1, -11, obj_button); 
			b1.POPUP_ID = popupid; b1.NEXT_FUNCTION = NEXTFUNCTION;
			b1.OnPress = function(POPUPID, NEXTF) { 
				popup_save(); 
				POPUPID.f_close();
				NEXTF();
			};
			with(b1) {
				text = "Yes";
				image_xscale = 3; 
				image_yscale = 1;
			};
			array_push(content, new ContentDiv(CONTENT_TYPE.obj, new Point(8, 8 + 40), b1));
		#endregion
		
		#region NO Button
			var b2 = instance_create_depth(
				window_get_width()/2 - s._x/2  + (8+32*3+8) + 32/2*2, 
				window_get_height()/2 - s._y/2 + (8 + 40) + 32/2*1, -11, obj_button); 
			b2.POPUP_ID = popupid; b2.NEXT_FUNCTION = NEXTFUNCTION;
			b2.OnPress = function(POPUPID, NEXTF) { 
				POPUPID.f_close();
				NEXTF();
			};
			with(b2) {
				text = "No";
				image_xscale = 2;
				image_yscale = 1;
			};
			array_push(content, new ContentDiv(CONTENT_TYPE.obj, new Point(8+32*3+8, 8 + 40), b2));
		#endregion
	}
}

function popup_fastchange_variable(VARIABLE_V, TITLE, DESC)
{
	var WIDTH = 150;
	with(instance_create_depth(800/2 - WIDTH, 130, -10, obj_popup))
	{
		size = new Point(WIDTH, 116);
		icontype = WINDOW_ICON.info;
		title = TITLE;
		content = [
			new ContentDiv(CONTENT_TYPE.sampletext, new Point(4, 0), DESC),
		];
		global.tempvar1 = VARIABLE_V;
		array_push(content,
			new ContentDiv(CONTENT_TYPE.typable, new Point(4, 24), 
			WIDTH - (4 + 4) - 12,
			string(global.preferences[$VARIABLE_V]), 
			3,
				function(v) {
					var t = return_expression_result(v, {}).result_total
					var temp = global.preferences[$ global.tempvar1]
					try {
							if (string_replace_all(v, " ", "") != "")
							global.preferences[$ global.tempvar1] = return_expression_result(v, {}).result_total;
					} catch(ex) {
						global.preferences[$ global.tempvar1] = temp;
					}
				}
			)
		);
		var b1 = instance_create_depth(0, 0, -11, obj_button); with(b1) {
			text = "Close";
			image_xscale = 4;
			image_yscale = 1;
		}
		b1.POPUP_ID = id;
		b1.OnPress = function(POPUPID, NEXTF) { 
			POPUPID.f_close();
			UpdateResults();
		};
		array_push(content, new ContentDiv(CONTENT_TYPE.obj, new Point(8, 8 + 60), b1));
	}	
}

function popup_color_change()
{
	with(instance_create_depth(130, 130, -10, obj_popup))
	{
		size = new Point(184, 78);
		icontype = WINDOW_ICON.info;
		title = "Function's Color";
		content = [
			new ContentDiv(CONTENT_TYPE.sampletext, new Point(4, 4), "HEXCODE ( \"#0000ff\" )")
		];
		array_push(content,
			new ContentDiv(CONTENT_TYPE.typable, new Point(4, 24), 
			78,
			returnselcolor(), 
			7,
				function(v) {
					with(obj_graphs_selector)
					{
						global.expressions_table[selected_expression].color = HexcodeToColor(v, c_blue);
					}
				}
			)
		);
	}
}

function returnselcolor()
{
	with(obj_graphs_selector) { 
		return ColorToHex(global.expressions_table[selected_expression].color);
	}
}

function popup_load() {
	var fn = get_open_filename("Text Files (*.txt)|*.txt", "");
	if (fn != "") {
		try
		{
			var file = file_text_open_read(fn); 
			var table = array_create(0);
			while (!file_text_eof(file)) {
				array_push(table, string_replace_all(string_replace_all(file_text_readln(file), "\n", ""), "\r", ""));
			}
			file_text_close(file);
			global.expressions_table = array_create(0);
			for(var i = 0; i < array_length(table); i++)
				array_push(global.expressions_table, new Expression(table[i]));
			UpdateResults();
		}
	}
	
}
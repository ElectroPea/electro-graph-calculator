function DropMenuButton(name="", comb=[], ptrnewDropMenu="", func=function(){}) constructor {
	_name = name;
	_comb = comb;
	_ptrnewDropMenu = ptrnewDropMenu;
	_gap = (name == "");
	_func = func;
}

#region Old Code
//global.menu = {
//	"_ex1" : {
//		show: true,
//		name: "Example 1",
//		buttons: [
//			new DropMenuButton("Close", 
//				[vk_control, vk_alt, vk_shift, vk_space, ord("x")]
//			),
//			new DropMenuButton("Close All", 
//				[vk_control, vk_shift, ord("w")]
//			)
//		]
//	},
//	"_ex2" : {
//		show: true,
//		name: "Example 2",
//		buttons: [
//			new DropMenuButton("Close All", 
//				[vk_control, vk_alt, vk_shift, vk_space, ord("x")]
//			),
//			new DropMenuButton("Close", 
//				[vk_control, ord("w")]
//			)
//		]
//	},
//	"_file" : {
//		show : false,
//		name: "File",
//		buttons : [
//			new DropMenuButton("Button A", [vk_control, ord("n"), ord("z"), ord("a")], "", 
//			function() {
//				show_message("Hi! :D");
//			}),
//			new DropMenuButton("Button B"),
//			new DropMenuButton(),
//			new DropMenuButton("Button C", [vk_control, ord("s")], "_extra"),
//			new DropMenuButton("Button D", [], "_file"),
//		]
//	},
//	"_menu2" : {
//		show: true,
//		name: "Menu2",
//		buttons: [
//			new DropMenuButton("text", [vk_control, ord("x")]),
//			new DropMenuButton("coolertext", [vk_control, ord("x"), ord("c")]),
//			new DropMenuButton("abcd", [vk_control, ord("x"), vk_f2]),
//			new DropMenuButton("coolertext", [vk_control, ord("x"), vk_f2]),
//		]
//	},
//	"_extra" : {
//		show: false,
//		name: "",
//		buttons : [
//			new DropMenuButton("Button C1", [vk_control, vk_alt, ord("s")]),
//			new DropMenuButton("Button C2")
//		]
//	}
//};
#endregion

global.menu = {
	"_file" : {
		show: true,
		name: "File",
		buttons: [
			new DropMenuButton("New", [vk_control, ord("N")], "", function() {
				popup_savewarning(
				function() {
					 global.expressions_table = array_create(0);
					 UpdateResults();
				});		
			}),
			new DropMenuButton("Open", [vk_control, ord("O")], "", function() {
				popup_savewarning(
				function() {
					 popup_load();	
				});	
			}),
			new DropMenuButton("Reload", [vk_control, ord("R")], "", function() {
				UpdateResults();
			}),
			new DropMenuButton("Save", [vk_control, ord("S")], "", function() {
				popup_save();	
			}),
			new DropMenuButton(""),
			new DropMenuButton("Exit", [vk_control, ord("Q")], "", function() {
				popup_savewarning(
				function() {
					 game_end();
				});	
			}),
		]
	},
	"_pref" : {
		show: true,
		name: "Preferences",
		buttons: [
			new DropMenuButton("Grid", [vk_control, vk_alt, ord("S")], "", function() {global.preferences[$ "GRID"] = !global.preferences[$ "GRID"];} ),
			new DropMenuButton("Arrows", [vk_control, vk_alt, ord("A")], "", function() {global.preferences[$ "ARROWS"] = !global.preferences[$ "ARROWS"];} ),
			new DropMenuButton(""),
			new DropMenuButton("X Axis", [vk_control, vk_alt, ord("Z")], "", function() {global.preferences[$ "AXIS.x"] = !global.preferences[$ "AXIS.x"];} ),
			new DropMenuButton("Y Axis", [vk_control, vk_alt, ord("X")], "", function() {global.preferences[$ "AXIS.y"] = !global.preferences[$ "AXIS.y"];} ),
			new DropMenuButton(""),
			new DropMenuButton("Save Skin", [vk_control, vk_alt, ord("C")], "",  function() {
				var json_string = json_stringify(global.colors);
				var fn = get_save_filename("", ""); 
				if (fn != "") {
					try
					{
						var file = file_text_open_write(fn); 
						file_text_write_string(file, json_string); 
						file_text_close(file);	
						//show_message("Skin was saved!");
					} catch(exp) {
						show_message("Error.");
					}
				}
			}),
			new DropMenuButton("Load Skin", [vk_control, vk_alt, ord("V")], "", function() {
				var fn = get_open_filename("","");
				if (fn != "") {
					try {
					var file = file_text_open_read(fn); 
					var json_string = file_text_read_string(file); 
					file_text_close(file);
					global.colors = json_parse(json_string);
					//show_message("New skin was loaded!");
					}  catch(exp) {
						show_message("Error.");
					}
					
					
				}
			}),
			new DropMenuButton(),
			new DropMenuButton("Board Settings", [], "_board.cells", function(){})
		]
	},
	"_board.cells":{
		show: false,
		name: "",
		buttons: [
			new DropMenuButton("Axis X", [], "", function() {
				popup_fastchange_variable("BOARD.PX", "Change XCells", "(1x1 -> 5 cells)");
			}),
			new DropMenuButton("Axis Y", [], "", function() {
				popup_fastchange_variable("BOARD.PY", "Change YCells", "(1x1 -> 5 cells)");
			}),
			new DropMenuButton("Points", [], "", function() {
				popup_fastchange_variable("POINTS_INCREASE_V", "Increasing points", "");
			}),
		]
	},
	"_btn_ex": {
		show: true,
		name: "Button Examples",
		buttons: [
			new DropMenuButton("Example1", [], "", function() {
				with(instance_create_depth(130, 130, -10, obj_popup))
				{
				    size = new Point(450, 158);
				    icontype = WINDOW_ICON.warning;
				    title = "Test popup";
				    content = [
				        new ContentDiv(CONTENT_TYPE.sampletext, new Point(4, 4), "Hello there! This is a test."),
				        new ContentDiv(CONTENT_TYPE.sampletext, new Point(4, 4 + string_height("A")), "Hello there! This is a test."),
						new ContentDiv(CONTENT_TYPE.photo, new Point(4, 4 + string_height("A")*2 + 4), spr_samplephoto),
				        new ContentDiv(CONTENT_TYPE.sampletext, new Point(4 + sprite_get_width(spr_samplephoto) + 4, 4 + string_height("A")*2),
						"<- Cool image! :D"),
				        new ContentDiv(CONTENT_TYPE.sampletext, new Point(4 + sprite_get_width(spr_samplephoto) + 4, 4 + string_height("A")*3-2),
						"<- Cool image!!!!"),
						new ContentDiv(CONTENT_TYPE.space, new Point(4, 4 + string_height("A")*4))
				    ];
				    var str = string_width(content[0]._content.text);
				    array_push(content,
				        new ContentDiv(CONTENT_TYPE.typable, new Point(4 + str + 4, 4), 
				        450 - (4 + str + 4) - 12,
				        "Sample text", 
				        999,
							function(v) {
								window_set_caption("Electro's Graph Calculator - " + v)
							}
						)
				    );
					var b1 = instance_create_depth(0, 0, -11, obj_button); with(b1) {
						text = "Button";
						OnPress = function() {
							show_message("testmessage")	
						};
						image_xscale = 4;
						image_yscale = 1;
					}
					array_push(content,
				        new ContentDiv(CONTENT_TYPE.obj, new Point(8, 8 + 108), b1));
				}
			})
		]
	},
	"_graph_popup" : {
		show: false,
		name: "",
		buttons: [
			new DropMenuButton("Launch", [], "", function() {
				with(obj_graphs_selector)
				{
					global.expressions_table[selected_expression].step_launched = !(global.expressions_table[selected_expression].step_launched);
				}
			})
		]
	},
	"_graphic_popup" : {
		show: false,
		name: "",
		buttons: [
			new DropMenuButton("Show / Hide", [], "", function() {
				with(obj_graphs_selector)
				{
					global.expressions_table[selected_expression].show_graphic = !(global.expressions_table[selected_expression].show_graphic);
				}
			}),
			new DropMenuButton("Color", [], "", function() {
				with(obj_graphs_selector)
				{
					popup_color_change(global.expressions_table[selected_expression]);
				}
			})
		]
	}
};

global.menu_order = ["_file","_pref", "_btn_ex", "_graph_popup", "_graphic_popup"]


////show_debug_message(key_to_string(vk_control));

chosen_table = {
	name: "",
	_id: 0,
	_x: 0
};
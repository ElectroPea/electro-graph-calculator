#macro OPENED_BRACKET "{"
#macro CLOSED_BRACKET "}"


enum EXPRESSION_TYPES {
	error_none,
	draw_graphic,
	standard,
	movable
}

global.expressions_table = array_create(0);
global.variables_set = {};

//var test1 = ["sin", "cos", "tan", "csc", "sec", "cot"]

//for(var i = 0; i<array_length(test1); i++)
//{
//	array_push(global.expressions_table, new Expression(
//		string_concat("y=\\", test1[i], "(x)")
//	));	
//}

//var my_string = "Helld Worllo!";
//var new_string = string_replace_all_limit(my_string, "ll", "wwww", function(index, str) {
//	var rchar = string_char_at(str, index + string_length("ll"));
//	//show_debug_message(rchar);
//	if (rchar == "d") return false;
//	return true;
//});
//show_message(new_string);

// cool graphic example

global.preferences = {
	"GRID" : true, // Grid in the board
	"ARROWS": false, // Arrows from axis in the board
	"AXIS.x": true, // X axis
	"AXIS.y": true, // Y axis
	"BOARD.PX":5,
	"BOARD.PY":5,
	"POINTS_INCREASE_V":0.1,
	"AUTORELOAD":false
}

global.colors = 
{
	BOARD: {
		bg: "#ffffff",
		grid: "#dedee8",
		griddark: "#b2b1b7",
		basegrid: "#595959"
	},
	BUTTON: "#ffffff",
	BUTTONTEXT: "#000000",
	UPPERMENU: {
		bg: "#cac6f7",
		outline: "#000000",
		buttons: {
			STATIC: {
				bg: "#cac6f7",
				textcolor: "#000000",
				texthint: "#525169"
			},
			HOVER: {
				bg: "#ffebb6",
				textcolor: "#000000",
				texthint: "#525169"
			},
			PRESSED: {
				bg: "#7c909f",
				textcolor: "#ffffff",
				texthint: "#c4cdd4"
			}
		},
		fpscolor: "#000000"
	},
	RIGHTMENU: {
		bg: "#cac6f7",
		outline: "#000000",
		dragoutl: "#ff00b3",
		STATIC: {
			bgnone: "#9ea2b5",
			bghover: "#c1c4d6",
			"type.graphic": "#a6bfae",
			"type.error_none": "#bf8888",
			"type.other": "#a6abbf"
		},
		SELECTED: {
			bgnone: "#757399",
			bghover: "#8381a3",
			"type.graphic": "#679c6c",
			"type.error_none": "#be6464",
			"type.other": "#67719c"
		},
		bgtext: "#ffffff",
		expressioncolor: "#000000",
		answercolor: "#322f40",
		rectmove: "#565479"
	}
}

UpdateResults();
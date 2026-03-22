enum CONTENT_TYPE {
	space,
	sampletext,
	typable,
	photo,
	obj
};

enum WINDOW_ICON {
	info = 0,
	warning = 1,
	error = 2
}

function f_close()
{
	for(var i = 0; i < array_length(content); i++)
	{
		if (content[i]._type = CONTENT_TYPE.obj)
			with(content[i]._content.objid) instance_destroy();
	}
	instance_destroy();
}

function ContentDiv(ptype, pos) constructor
{
	_type = ptype;
	_pos = pos;
	_content = {};
	switch(ptype) {
		case CONTENT_TYPE.sampletext: {
			_content = {
				text: argument[2]	
			};
			break;
		}
		case CONTENT_TYPE.typable: {
			_content = {
				maxw: argument[2],
				text: argument[3],
				maxl: argument[4],
				OnChanged: argument[5]
			};	
			break;
		}
		case CONTENT_TYPE.photo: {
			_content = {
				sprite: argument[2]
			};
			break;
		}
		case CONTENT_TYPE.obj: {
			_content = {
				objid: argument[2]
			}
		}
	}
	if (argument_count > 4) {
	    for (var i = 4; i < argument_count; i++) {
	        var _key = "arg" + string(i);
			_content[$ _key] = argument[i];
	    }
	}
}

offset_x = 0;
offset_y = 0;
mouse_prevpos_x = 0;
mouse_prevpos_y = 0;
curstate = STATES.STATE_NONE;

title = "";
icontype = WINDOW_ICON.info;
text = "";
content = [];
size = new Point(0, 0);

chosen_textdiv = -1; t = 0;


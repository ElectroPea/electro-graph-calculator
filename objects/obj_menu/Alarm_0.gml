
with(obj_menu_dropmenu)
	instance_destroy();	
						
var ID = chosen_table._id;
//with(instance_create_layer(chosen_tables[0]._x, 32, "Instances", obj_menu_dropmenu)) {
//	name = struct_vars[ID];
//}
if (ID > -1)
{
	with(instance_create_depth(chosen_table._x, 17, -999, obj_menu_dropmenu))
		name = global.menu_order[ID];
}
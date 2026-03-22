global.a = [];

function Print(val)
{
	array_push(global.a, val)
	if (array_length(global.a) > 600/8) {
		global.a = [];
	}
}

function return_a()
{
	return global.a;	
}
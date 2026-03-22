function draw_grid_box(step, offset, center, max_size, horisontal)
{
	var index = step;
	while(true)
	{
		if ((offset + index >= center && step > 0) || (offset + index <= -center && step < 0)) break;
		if ((center + offset + index <= max_size && step < 0) || (center + offset + index >= 0 && step > 0)) {
			if (horisontal)
			{
				draw_line(
					center + offset + index,
					0,
					center + offset + index,
					max_size
				);
			} else {
				draw_line(
					0,
					center + offset + index,
					max_size,
					center + offset + index
				);
			}
		}
		index += step;
	}
}
board_width = 800
board_height = 600

board_center_x = board_width/2
board_center_y = board_height/2

board_step_x = 15
board_step_y = 15

offset_x = 0
offset_y = 0
mouse_prevpos_x = 0
mouse_prevpos_y = 0

enum STATES {
	STATE_NONE,
	STATE_MOVING
}
curstate = STATES.STATE_NONE

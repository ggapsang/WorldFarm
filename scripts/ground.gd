extends ColorRect

var grid_size = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	queue_redraw() # 그리기 요청

func _draw():
	var line_color = Color(0.6, 0.5, 0.4, 0.5) # 반투명 갈색
	var line_width = 1.0
	
	for x in range(0, int(size.x) + 1, grid_size):
		draw_line(
			Vector2(x, 0),
			Vector2(x, size.y),
			line_color,
			line_width
		)
	for y in range(0, int(size.y) + 1, grid_size):
		draw_line(
			Vector2(0, y), 
			Vector2(size.x, y), 
			line_color, 
			line_width
		)

# main.gd
extends Node2D

# 이끼 씨앗 씬 preload
const MossScene = preload("res://scenes/crops/moss.tscn")

# 격자 설정
var grid_size = 40
var grid_width = 20 # 800 / 40
var grid_height = 5 # 200 / 40

# 점유된 격자 칸 기록
var occupied_grid = {}

# 콘솔 참조
@onready var console = $ConsolePanel

func _ready():
	pass

func _input(event):
	# 마우스 좌클릭
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var grid_cell = pixel_to_grid(event.position)
			plant_at_grid(grid_cell)

# 픽셀 좌표 → 격자 좌표
func pixel_to_grid(pixel_pos: Vector2) -> Vector2i:
	var grid_x = int(floor(pixel_pos.x / grid_size))
	var grid_y = int(floor(pixel_pos.y / grid_size))
	return Vector2i(grid_x, grid_y)

# 격자 좌표 → 픽셀 좌표 (중앙)
func grid_to_pixel(grid_cell: Vector2i) -> Vector2:
	var pixel_x = grid_cell.x * grid_size + grid_size / 2
	var pixel_y = grid_cell.y * grid_size + grid_size / 2
	return Vector2(pixel_x, pixel_y)

# 격자에 심기
func plant_at_grid(grid_cell: Vector2i):
	# 범위 체크
	if grid_cell.x < 0 or grid_cell.x >= grid_width:
		return
	if grid_cell.y < 0 or grid_cell.y >= grid_height:
		return
	
	# 중복 체크 (이미 심어진 칸인지)
	var key = "%d, %d" % [grid_cell.x, grid_cell.y]
	if occupied_grid.has(key):
		console.add_line("Grid [%d, %d] is already occupied!" % [grid_cell.x, grid_cell.y])
		return
	
	# 픽셀 좌표로 변환
	var pixel_pos = grid_to_pixel(grid_cell)
	
	# 이끼 생성
	var moss = MossScene.instantiate()
	moss.position = pixel_pos
	add_child(moss)
	
	# 점유 기록
	occupied_grid[key] = moss
	
	console.add_line("Planted at grid [%d, %d] = pixel %v" % [grid_cell.x, grid_cell.y, pixel_pos])

# main.gd
extends Node2D

# 작물 씬들 딕셔너리로 관리
const CROP_SCENES = {
	"moss": preload("res://scenes/crops/moss.tscn"),
	"raspberry": preload("res://scenes/crops/raspberry.tscn"),
}

# 현재 선택된 작물 (UI에서 변경)
var selected_crop: String = "raspberry"

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
			plant_at_grid(grid_cell, selected_crop)

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
func plant_at_grid(grid_cell: Vector2i, crop_type: String):
	# 1. 범위 체크
	if grid_cell.x < 0 or grid_cell.x >= grid_width:
		return
	if grid_cell.y < 0 or grid_cell.y >= grid_height:
		return
	
	# 2. 중복 체크 (이미 심어진 칸인지)
	var key = "%d, %d" % [grid_cell.x, grid_cell.y]
	if occupied_grid.has(key):
		console.add_line("Grid [%d, %d] is already occupied!" % [grid_cell.x, grid_cell.y])
		return
	
	# 픽셀 좌표로 변환
	var pixel_pos = grid_to_pixel(grid_cell)
	
	# 3.작물 생성
	var crop = CROP_SCENES[crop_type].instantiate()
	crop.position = grid_to_pixel(grid_cell)
	
	# 4. 시그널 연결
	if crop.has_signal("stage_changed"):
		pass
		# crop.stage_changed.connect(_on_crop_stage_changed)
	if crop.has_signal("fully_grown"):
		pass
		# crop.fully_grown.connect(_on_crop_fully_grown.bind(grid_cell))
	
	# 5. 씬에 추가
	add_child(crop)
	
	# 6. 점유 기록
	occupied_grid[key] = crop
	
	console.add_line("Planted at grid [%d, %d] = pixel %v" % [grid_cell.x, grid_cell.y, pixel_pos])


# 유틸리티 함수들
func is_valid_grid_cell(cell: Vector2i) -> bool:
	return cell.x >= 0 and cell.x < grid_width and cell.y >= 0 and cell.y < grid_height

func get_grid_key(cell: Vector2i) -> String:
	return "%d,%d" % [cell.x, cell.y]

func get_crop_at(cell: Vector2i):
	var key = get_grid_key(cell)
	return occupied_grid.get(key, null)

# 시그널 콜백
func _on_crop_stage_changed(stage_name: String):
	console.add_line("Growth → %s" % stage_name)

func _on_crop_fully_grown(grid_cell: Vector2i):
	console.add_line("Crop matured at [%d, %d]!" % [grid_cell.x, grid_cell.y])

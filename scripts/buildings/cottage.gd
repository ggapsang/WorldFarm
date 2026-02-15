extends Area2D

@onready var seed_button: Button = $SeedButton

var is_built: bool = false

signal building_clicked
signal seed_button_clicked

func _ready():
	# 클릭 이벤트 연결
	input_event.connect(_on_input_event)
	
	# 버튼 클릭 연결
	seed_button.pressed.connect(_on_seed_button_pressed)
	
	# 초기 상태: 건물 미건설
	is_built = false
	seed_button.visible = false

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			building_clicked.emit()

func build():
	"""건물 건설"""
	is_built = true
	# 건설 애니메이션이나 이펙트 추가 가능

func show_seed_button():
	"""씨앗 버튼 표시"""
	if is_built:
		seed_button.visible = true

func hide_seed_button():
	"""씨앗 버튼 숨김"""
	seed_button.visible = false

func _on_seed_button_pressed():
	seed_button_clicked.emit()

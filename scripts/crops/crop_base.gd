# crop_base.gd
# 모든 작물의 공통 로직 - 상속받아 사용
extends Node2D

@onready var visual: Sprite2D = $Visual

# 작물 데이터
var crop_data: CropData

# 성장 상태
var current_stage: CropData.GrowthStage = CropData.GrowthStage.SEED
var growth_timer: float = 0.0
var stage_timer: float = 0.0  # 현재 단계 내 타이머

# 신호
signal stage_changed(stage_name: String)
signal fully_grown

func _ready():
	if crop_data == null:
		push_error("CropData not set!")
		return
	
	update_visual()

func _process(delta):
	# 성숙하면 성장 멈춤
	if current_stage == CropData.GrowthStage.MATURE:
		return
	
	# 타이머 증가
	growth_timer += delta
	stage_timer += delta
	
	# 다음 단계로 넘어갈 시간인지 체크
	check_growth()

func check_growth():
	var current_duration = crop_data.stage_durations[current_stage]
	
	# 현재 단계 완료 (duration이 0이면 즉시)
	if current_duration == 0.0 or stage_timer >= current_duration:
		grow_to_next_stage()

func grow_to_next_stage():
	# 마지막 단계 체크
	if current_stage == CropData.GrowthStage.MATURE:
		return
	
	# 다음 단계로
	var next_stage = (current_stage + 1) as CropData.GrowthStage
	current_stage = next_stage
	stage_timer = 0.0
	
	# 비주얼 업데이트
	update_visual()
	
	# 신호 발송
	var stage_name = crop_data.get_stage_name(current_stage)
	stage_changed.emit(stage_name)
	
	# 완전 성숙 체크
	if current_stage == CropData.GrowthStage.MATURE:
		fully_grown.emit()

func update_visual():
	var stage_index = current_stage as int
	
	# 이미지 로드
	if crop_data.stage_textures.size() > stage_index:
		visual.texture = load(crop_data.stage_textures[stage_index])
	
	# 크기 조절
	var target_size = crop_data.stage_sizes[stage_index]
	if visual.texture:
		var texture_size = visual.texture.get_size()
		visual.scale = target_size / texture_size
	
	# 중앙 정렬 (Sprite2D는 기본이 중앙이라 불필요하지만 명시)
	visual.centered = true

# TODO: 수확
func harvest() -> int:
	if current_stage == CropData.GrowthStage.MATURE:
		var value = crop_data.harvest_value
		queue_free()
		return value
	return 0

# 성장 정보 가져오기
func get_growth_progress() -> float:
	if current_stage == CropData.GrowthStage.MATURE:
		return 1.0
	
	var total_time = crop_data.get_total_growth_time()
	return growth_timer / total_time if total_time > 0 else 0.0

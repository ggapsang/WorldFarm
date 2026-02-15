# 모든 작물 데이터
class_name CropData
extends Resource

enum GrowthStage {SEED, SPROUT, GROWING, MATURE}

# 기본 정보
@export var crop_name: String = ""
@export var crop_type: String = ""

# 성장 단계 설정
@export var stage_durations: Array[float] = [] # 각 단계별 소요 시간
@export var stage_sizes: Array[Vector2] = [] # 각 단계 크기
@export var stage_colors: Array[Color] = [] # 각 단계 색상

# 이미지 경로 배열
@export var stage_textures: Array[String] = []

# 경제 정보
@export var harvest_value = 10
@export var seed_cost = 5

# 단계 이름 가져오기
func get_stage_name(stage: GrowthStage) -> String:
	return GrowthStage.keys()[stage]

func get_total_growth_time() -> float:
	var total = 0.0
	for duration in stage_durations:
		total += duration
	return total

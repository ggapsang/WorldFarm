extends CropData

func _init():
	crop_name = "Northern Raspberry"
	crop_type = "raspberry"
	
	# 3단계 성장 (SEED는 0초, 즉시 시작)
	stage_durations = [
		0.0,   # SEED - 즉시
		10.0,   # SPROUT - 10초
		25.0,   # GROWING - 20초
		0.0    # MATURE - 성장 종료
	]
	
	stage_sizes = [
		Vector2(40, 40),  # SEED
		Vector2(40, 40),  # SPROUT (중간)
		Vector2(40, 40),  # GROWING
		Vector2(40, 40)   # MATURE (크기 유지)
	]
	
	stage_colors = [
		Color(0.6, 0.9, 0.5),  # SEED - 연한 녹색
		Color(0.5, 0.8, 0.4),  # SPROUT - 중간 녹색
		Color(0.4, 0.7, 0.3),  # GROWING - 진한 녹색
		Color(0.2, 0.5, 0.1)   # MATURE - 짙은 녹색
	]
	
	stage_textures = [
		"res://assets/sprites/crops/raspberry/raspberry_seed.png",
		"res://assets/sprites/crops/raspberry/raspberry_sprout.png",
		"res://assets/sprites/crops/raspberry/raspberry_growing.png",
		"res://assets/sprites/crops/raspberry/raspberry_mature.png",
	]
	
	harvest_value = 200
	seed_cost = 20

# moss.gd
# 이끼 - CropBase 상속
extends "res://scripts/crops/crop_base.gd"

func _ready():
	# 이끼 데이터 로드
	crop_data = preload("res://scripts/data/moss_data.gd").new()
	
	# 부모 클래스 초기화 호출
	super._ready()

# 이끼만의 특수 기능이 있다면 여기 추가
func _on_mature():
	pass  # 예: 포자 생성 등

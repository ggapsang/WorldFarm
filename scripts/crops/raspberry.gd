# raspberry.gd
# 라즈베리 - CropBase 상속
extends "res://scripts/crops/crop_base.gd"

func _ready():
	# 라즈베리 데이터 로드
	crop_data = preload("res://scripts/data/raspberry_data.gd").new()
	
	# 부모 클래스 초기화 호출
	super._ready()

# 라즈베리만의 특수 기능이 있다면 여기 추가
func _on_mature():
	pass

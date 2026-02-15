# console.gd
# 게임 내 콘솔 창
extends Panel

@onready var console_text: RichTextLabel = $ConsoleText

var max_lines = 10  # 최대 줄 수

func _ready():
	# 배경 색상 설정 (반투명 검회색)
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.2, 0.2, 0.2, 0.8)  # RGBA
	add_theme_stylebox_override("panel", style)
	# 초기 메시지
	add_line("=== Rovaniemi Reindeer Farm ===")
	add_line("Click to plant moss!")

# 새 줄 추가
func add_line(text: String):
	var lines = console_text.text.split("\n")
	
	# 줄 수 제한
	if lines.size() >= max_lines:
		lines.remove_at(0)  # 가장 오래된 줄 제거
	
	lines.append(text)
	console_text.text = "\n".join(lines)
	
	# 스크롤을 맨 아래로
	await get_tree().process_frame  # 한 프레임 대기 (텍스트 업데이트 후)
	console_text.scroll_to_line(console_text.get_line_count() - 1)

# 전체 지우기
func clear():
	console_text.text = ""

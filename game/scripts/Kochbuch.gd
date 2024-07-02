extends Control

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.get_keycode() == KEY_ESCAPE:
			visible = false

func _on_gui_input(event):
	if event is InputEventMouseButton:
		visible = false

	pass

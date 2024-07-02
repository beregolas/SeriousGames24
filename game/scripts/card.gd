class_name Card extends Control

@export var type: FoodType:
	set(value):
		type = value
		set_data(type)
	get:
		return type

var selected: bool = false

var mouse_over: bool = false

var max_angle: float = 45

var angle_speed: float = 0

enum FoodType {vegetable, fruit, nuts, meat, fish, milk, egg}

const TYPE_DATA: Dictionary = {
	FoodType.vegetable: {"Background": Color(0.29803923, 0.52156866, 0.15294118), "Foreground": Color(0.6666667, 0.6666667, 0.60784316), "Name": "vegetable"},
	FoodType.fruit: {"Background": Color(0.9019608, 0.65882355, 0.20392157), "Foreground": Color(0.654902, 0.58431375, 0.50980395), "Name": "fruit"},
	FoodType.nuts: {"Background": Color(0.53333336, 0.33333334, 0.06666667), "Foreground": Color(0.53333336, 0.44313726, 0.37254903), "Name": "nuts"},
	FoodType.meat: {"Background": Color(0.91764706, 0.23529412, 0.12156863), "Foreground": Color(0.72156864, 0.5411765, 0.5294118), "Name": "meat"},
	FoodType.fish: {"Background": Color(0.0627451, 0.5058824, 0.7921569), "Foreground": Color(0.4392157, 0.5058824, 0.5803922), "Name": "fish"},
	FoodType.milk: {"Background": Color(0.8666667, 0.8352941, 0.8352941), "Foreground": Color(0.6666667, 0.6666667, 0.60784316), "Name": "milk"},
	FoodType.egg: {"Background": Color(0.8666667, 0.8352941, 0.8352941), "Foreground": Color(0.6666667, 0.6666667, 0.60784316), "Name": "egg"}
}

func set_data(current_type: FoodType):
	if $Background != null:
		# set background color according to type
		$Background.self_modulate = TYPE_DATA[current_type].Background
		$ContentBackground.self_modulate = TYPE_DATA[current_type].Foreground
		$TypeLabel.text = "Type: " + TYPE_DATA[current_type].Name
	pass


func is_other_card_selected() -> bool:
	for card in get_tree().get_nodes_in_group("cards"):
		if card.selected:
			return true
	return false


func _process(delta: float):
	if Input.is_action_pressed("mouse_button") and not selected and not is_other_card_selected():
		selected = mouse_over
	if not Input.is_action_pressed("mouse_button"):
		selected = false
	if selected:
		# move from hand to card_holder
		var parent: Node = get_parent()
		if parent.name != "CardHolder":
			var card_holder = get_tree().get_root().get_node("Game/CardHolder")
			if card_holder.get_child_count() == 0:
				parent.remove_child(self)
				card_holder.add_child(self)
				position = get_parent().get_local_mouse_position()
		# interpol position to mouse
		# get mouse position relative to pivot
		var mouse_position: Vector2 = get_local_mouse_position() - get_pivot_offset()
		var movement = lerp(Vector2.ZERO, mouse_position, 0.2)
		movement.x = signf(movement.x) * min(abs(mouse_position.x), max(abs(movement.x), 5. * delta))
		movement.y = signf(movement.y) *min(abs(mouse_position.y), max(abs(movement.y), 5. * delta))
		position += movement
		# add movement.x to the dangle
		angle_speed += movement.x / 2
		angle_speed -= rotation_degrees / 5.
		rotation_degrees += angle_speed * delta
		if signf(angle_speed) == signf(rotation_degrees):
			angle_speed *= 0.97
		rotation_degrees = clamp(rotation_degrees, -max_angle, max_angle)
		if abs(rotation_degrees) == max_angle:
			angle_speed = -rotation_degrees / 10
		if (abs(angle_speed) < 0.05) and (abs(rotation_degrees) < 0.05):
			angle_speed = 0
			rotation_degrees = 0
	else:
		angle_speed = 0
		if abs(rotation_degrees) > 0.05:
			rotation_degrees = lerpf(rotation_degrees, 0., 0.05)
		else:
			rotation_degrees = 0


# on mouse over
func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false



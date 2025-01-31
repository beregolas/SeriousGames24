class_name Hand extends Control

var _child_x_list: Array[float] = []

var double_click_threshhold: float = 200

var last_click: int = 0

var max_hand_size: int = 7

var child_count: int     = 0:
	set(value):
		child_count = value
		_child_x_list.resize(child_count)
		var children: Array[Node] = get_children()
		for i in range(child_count):
			_child_x_list[i] = children[i].position.x
		_child_x_list.sort()
	get:
		return child_count

var placeholder: Control = Control.new()

@export var trash: Trashcan
@export var judge: Judge
@export var cooking_area: CookingArea

func get_held_card() -> Node:
	var card_holder: Node = get_parent().get_node("CardHolder")
	if card_holder.get_child_count() > 0:
		return card_holder.get_child(0)
	else:
		return null

func _ready():
	placeholder.custom_minimum_size = Vector2i(126, 176)
	_on_child_order_changed()

func is_mouse_over_other_object(other: Control) -> bool:
	var mp: Vector2 = other.get_local_mouse_position()
	return (mp.x >= 0) and (mp.y >= 0) and (mp.x <= other.size.x) and (mp.y <= other.size.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("mouse_button") and ((Time.get_ticks_msec() - last_click) < double_click_threshhold):
		get_tree().call_group("cards", "double_click")
	elif Input.is_action_just_pressed("mouse_button"):
		last_click = Time.get_ticks_msec()



	var mouse_position: Vector2 = get_local_mouse_position()
	var card: Node = get_held_card()
	if (mouse_position.x >= 0) and (mouse_position.y >= 0) and (mouse_position.x <= size.x) and (mouse_position.y <= size.y) and card != null:
		if not placeholder.is_inside_tree():
			add_child(placeholder)

		move_placeholder(mouse_position.x)
	else:
		if placeholder.is_inside_tree():
			remove_child(placeholder)
	if Input.is_action_just_released("mouse_button") and card != null:
		# put card into hand, but ask first if it was dropped on anything
		# check for drop
		if is_mouse_over_other_object(cooking_area):
			print("dropped in pot")
			get_parent().get_node("CardHolder").remove_child(card)
			cooking_area.add_card(card)
		elif is_mouse_over_other_object(judge):
			judge.give_card(card)
		elif is_mouse_over_other_object(trash):
			trash.throw_card_away(card)
		else:
			get_parent().get_node("CardHolder").remove_child(card)
			placeholder.add_sibling(card)
			remove_child(placeholder)
			card.selected = false




func move_placeholder(mouse_x: float):
	if len(_child_x_list) > 0:
		var idx: int = 0
		var value: float = abs(_child_x_list[0] - mouse_x)
		for i in range(len(_child_x_list)):
			var new_value: float = abs(_child_x_list[i] - mouse_x)
			if new_value < value:
				value = new_value
				idx = i
		move_child(placeholder, idx)

func is_full():
	# Max 7 Handkarten
	return get_child_count() >= max_hand_size

func _on_child_order_changed():
	child_count = get_child_count()


func use_oil() -> bool:
	for card in get_children():
		if (card.data.type == Card.FoodType.oil):
			card.queue_free()
			return true
	return false

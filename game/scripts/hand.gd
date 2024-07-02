extends Control

var _child_x_list: Array[float] = []

var child_count: int = 0:
	set(value):
		child_count = value
		_child_x_list.resize(child_count)
		var children: Array[Node] = get_children()
		for i in range(child_count):
			_child_x_list[i] = children[i].position.x
	get:
		return child_count

var placeholder = Control.new()

func get_held_card() -> Node:
	var card_holder: Node = get_parent().get_node("CardHolder")
	if card_holder.get_child_count() > 0:
		return card_holder.get_child(0)
	else:
		return null

func _ready():
	placeholder.custom_minimum_size = Vector2i(126, 176)
	_on_child_order_changed()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_position: Vector2 = get_local_mouse_position()
	if mouse_position.x >= 0 and mouse_position.y >= 0 and mouse_position.x <= size.x and mouse_position.y <= size.y:
		var card: Node = get_held_card()
		if card != null:
			add_child(placeholder)

		else:
			remove_child(placeholder)
	else:
		remove_child(placeholder)



func _on_child_order_changed():
	child_count = get_child_count()

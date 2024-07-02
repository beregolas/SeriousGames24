class_name CookingArea extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# print(get_local_mouse_position())
	pass


func add_card(card: Card):
	card.scale = Vector2(0.5, 0.5)
	$PlayedCards.add_child(card)
	pass

func _on_button_pressed():
	print("KOCHEN!")
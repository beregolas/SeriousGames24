class_name CookingArea extends TextureRect


func add_card(card: Card):
	card.scale = Vector2(0.5, 0.5)
	$PlayedCards.add_child(card)
	pass

func _on_button_pressed():
	check_recipes()

enum Recipe {SHASHUKA, FISCHSUPPE, SMOOTHIE}

func check_recipes():
	var cards: Array[Node] = $PlayedCards.get_children()

	var options: Dictionary = {}

	# check Shashuka
	if contains_list(cards, ["Tomate", "Paprika", "Zwiebel", "Ei", "Olivenöl"]) and (contains_ingredient(cards, "Koriander") or contains_ingredient(cards, "Basilikum")):
		# add points + 6
		var points = 6 + add_points(cards, ["Tomate", "Paprika", "Zwiebel", "Ei", "Olivenöl", "Koriander", "Basilikum"])
		options[Recipe.SHASHUKA] = points

	# check Fischsuppe


	# check Smoothie

	# cleanup
	for card: Card in cards:
		card.queue_free()

func contains_list(list, names):
	for name in names:
		if not contains_ingredient(list, name):
			return false
	return true

func contains_ingredient(list, name):
	for card in list:
		if card.data.name == name:
			return true
	return false

func add_points(cards, allowed):
	var sum = 0
	for card in cards:
		if card.data.name in allowed:
			sum += card.get_value()
	return sum




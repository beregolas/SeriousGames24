class_name CookingArea extends TextureRect

@onready var popup = $"../GerichtPopup"

func add_card(card: Card):
	card.scale = Vector2(0.5, 0.5)
	$PlayedCards.add_child(card)
	pass

func _on_button_pressed():
	check_recipes()

enum Recipe {SHASHUKA, FISCHSUPPE, SMOOTHIE, PFANNE}

func get_recipe_name(recipe):
	if Recipe.SHASHUKA:
		return "Shakshuka"
	if Recipe.FISCHSUPPE:
		return "Fischsuppe"
	if Recipe.SMOOTHIE:
		return "Smoothie"
	return "Gebreatenes Fleisch"

func check_recipes():
	var cards: Array[Node] = $PlayedCards.get_children()

	var options: Dictionary = {}

	# check Shashuka
	if contains_list(cards, ["Tomate", "Paprika", "Zwiebel", "Ei", "Olivenöl"]) and (contains_ingredient(cards, "Koriander") or contains_ingredient(cards, "Basilikum")):
		var points = 6 + add_points(cards, ["Tomate", "Paprika", "Zwiebel", "Ei", "Olivenöl", "Koriander", "Basilikum"])
		options[Recipe.SHASHUKA] = points

	# check Fischsuppe
	if (contains_ingredient(cards, "Thunfisch") or contains_ingredient(cards, "Lachs")) and contains_list(cards, ["Karotte", "Frühlingszwiebel"]):
		var points = 4 + add_points(cards, ["Thunfisch", "Lachs", "Karotte", "Frühlingszwiebel", "Zitrone"]) + (6 if contains_ingredient(cards, "Zitrone")  else 0)
		options[Recipe.FISCHSUPPE] = points

	# check Smoothie
	if contains_list(cards, ["Banane", "Zitrone"]):
		var points = 4 + add_points(cards, ["Banane", "Zitrone"])
		options[Recipe.SMOOTHIE] = points

	# check Bratpfanne
	var counter = 0
	if contains_ingredient(cards, "Tomate"):
		counter += 1
	if contains_ingredient(cards, "Paprika"):
		counter += 1
	if contains_ingredient(cards, "Zwiebel"):
		counter += 1
	if contains_ingredient(cards, "Frühlingszwiebel"):
		counter += 1
	if contains_ingredient(cards, "Karotte"):
		counter += 1
	if (counter > 1) and (contains_ingredient(cards, "Rindfleisch") or contains_ingredient(cards, "Hähnchenbrust")):
		var points = -5 if contains_ingredient(cards, "Rindfleisch") else 5 + add_points(cards, ["Tomate", "Paprika", "Zwiebel", "Frühlingszwiebel", "Karotte", "Hähnchenbrust"])
		options[Recipe.PFANNE] = points

	var chosen = null
	var max_points = -1000000
	for key in options.keys():
		if options[key] > max_points:
			max_points = options[key]
			chosen = key
	if chosen == null:
		# no recipe worked
		popup.get_node("Label").text = "ES WURDEN FÜR KEIN REZEPT ALLE NÖTIGEN ZUTATEN GESAMMELT!"
	else:
		# recipe found
		popup.get_node("Label").text = "ERFOLGREICH GEKOCHT: \n" + get_recipe_name(chosen)
		$"../Judge".current_points = max_points

	popup.visible = true
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
			sum += abs(card.get_value())
	return sum




class_name Deck extends TextureRect

var deck = []

var card_scene: PackedScene = preload("res://scenes/card.tscn")

@onready var hand: Hand = $"../Hand"

var starting_deck_size: int = 37

var CARD_DATA: Array = [
					   Card.CardData.new("Tomate", Card.FoodType.fruit, 2),
					   Card.CardData.new("Paprika", Card.FoodType.vegetable, 3),
					   Card.CardData.new("Zwiebel", Card.FoodType.vegetable, -2),
					   Card.CardData.new("Olivenöl", Card.FoodType.oil, -4),
					   Card.CardData.new("Basilikum", Card.FoodType.spice, 0),
					   Card.CardData.new("Lachs", Card.FoodType.fish, -5),
					   Card.CardData.new("Zitrone", Card.FoodType.fruit, -4),
					   Card.CardData.new("Banane", Card.FoodType.fruit, 4),
					   Card.CardData.new("Koriander", Card.FoodType.spice, 0),
					   Card.CardData.new("Karotte", Card.FoodType.vegetable, 3),
					   Card.CardData.new("Thunfisch", Card.FoodType.fish, -5),
					   Card.CardData.new("Hähnchenbrust", Card.FoodType.meat, -5)
					   ]

func _ready():
	# generate a starting deck
	for i in range(starting_deck_size):
		var card: Card = card_scene.instantiate()
		card.data = CARD_DATA[randi_range(0, len(CARD_DATA)-1)]
		deck.push_back(card)
	for j in range(7):
		draw_card()
	update_label()


func update_label():
	$Label.text = "Karten: " + str(len(deck))

func draw_card():
	if not hand.is_full() and len(deck) > 0:
		hand.add_child(deck.pop_front())

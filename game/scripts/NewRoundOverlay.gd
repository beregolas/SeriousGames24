class_name NewRoundOverlay extends Control

@onready var deck:Deck = $"../Deck"

func start_overlay(round_number):
	$Container/Label.text = "HERZLICHEN GLÜCKWUNSCH!\nRUNDE " + str(round_number) + " ERREICHT!\n \nNEUE KARTEN ZUR AUSWAHL:"
	for cs: CardSelector in $Container/CardContainer.get_children():
		var card:Card = deck.create_card()
		card.mouse_filter = MOUSE_FILTER_IGNORE
		cs.set_card(card)
		cs.get_node("Button").button_pressed = false
	visible = true



func remove_overlay():
	for cs: CardSelector in $Container/CardContainer.get_children():
		if cs.get_node("Button").button_pressed:
			var card:Card = cs.get_child(0)
			card.mouse_filter = MOUSE_FILTER_STOP
			cs.remove_child(card)
			deck.deck.push_back(card)
	# fill the deck at least to 30 with random cards
	while len(deck.deck) < 30 - $"../Judge".judge_number:
		deck.deck.push_back(deck.create_card())
	deck.deck.shuffle()
	deck.update_label()
	visible = false

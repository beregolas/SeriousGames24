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
	deck.update_label()
	visible = false

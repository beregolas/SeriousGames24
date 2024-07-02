class_name Trashcan extends TextureRect

@onready var deck: Deck = $"../Deck"

func throw_card_away(card: Card):
	card.get_parent().remove_child(card)
	var choice = randi_range(0, 1)
	if choice == 1:
		# back in deck
		card.selected = false
		card.mouse_over = false
		deck.deck.push_back(card)
		deck.update_label()
		# else throw away
	else:
		card.queue_free()
	#redraw one card
	deck.draw_card()
	pass
class_name CardSelector extends VBoxContainer


func set_card(card):
	# remove old card if it exists
	for child in get_children():
		if child is Card:
			remove_child(child)
	add_child(card)
	move_child(card, 0)





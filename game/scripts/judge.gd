class_name Judge extends Control

var judge_number: int = 0

var judge_name: String = "Name"

var preference: Card.FoodType = Card.FoodType.vegetable

var hate: Card.FoodType = Card.FoodType.fruit

var time_limit: int = 10

var required_points: int = 10

@export var game: Game

@onready var deck: Deck = $"../Deck"

#############################

const names: Array[String] = ["Chef Brown", "Chef Chef", "Chef of the Kitchen", "Cheffe", "Chef Italia", "Chef of Chefs", "Chef Senior III"]

##############################

var current_points: int = 0:
	set(value):
		if value > current_points:
			for i in range(value - current_points):
				deck.draw_card()
		current_points = value
		if current_points >= required_points:
			generate_new_judge()
			game.next_round(judge_number)
	get:
		return current_points

var current_cards: int = 0:
	set(value):
		if value >= time_limit:
			# game over
			game.game_over()
		current_cards = value

func give_card(card):
	var card_value = card.data.fried if card.fried else card.data.value
	if card.data.type == preference:
		card_value += 5
	if card.data.type == hate:
		card_value = min(card_value, 0) - 5
	current_points += card_value
	card.queue_free()
	print("test")
	current_cards += 1
	update_data()


func _ready():
	generate_new_judge()

func generate_new_judge():
	game.points += current_points
	game.update_data()
	current_points = 0
	current_cards = 0
	judge_number += 1
	judge_name = names[randi_range(0, len(names) - 1)]
	time_limit = max(5, 10 - judge_number + randi_range(-2, 6))
	required_points = (11 + judge_number) * 2
	preference = randi_range(0, Card.FoodType.size() - 1)
	hate = randi_range(0, Card.FoodType.size() - 1)
	while hate == preference:
		hate = randi_range(0, Card.FoodType.size() - 1)
	update_data()

func update_data():
	$Image.texture = load("res://assets/judges/" + str(judge_number % 5) + ".png")
	$"Text/Name".text = judge_name
	$"Text/Positiv".text = Card.TYPE_DATA[preference].Name
	$"Text/Negativ".text = Card.TYPE_DATA[hate].Name
	$"Text/Punkte".text = str(current_points) + " / " + str(required_points)
	$"Text/Zeitlimit".text =str(current_cards) + " / " + str(time_limit)
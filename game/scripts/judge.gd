class_name Judge extends Control

var judge_number: int = 0

var judge_name: String = "Name"

var preference: Card.FoodType = Card.FoodType.vegetable

var hate: Card.FoodType = Card.FoodType.fruit

var time_limit: int = 10

var required_points: int = 10

@export var game: Game

#############################

const names: Array[String] = ["Chef Brown", "Chef Chef", "Chef of the Kitchen", "Cheffe", "Chef Italia", "Chef of Chefs", "Chef Senior III"]

##############################

var current_points: int = 0

func give_card(card: Card):

	print(card)

func _ready():
	generate_new_judge()

func generate_new_judge():
	game.points += current_points
	game.update_data()
	current_points = 0
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
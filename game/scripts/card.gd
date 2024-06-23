@tool
extends Control


@export var type: FoodType:
	set(value):
		type = value
		set_data(type)
	get:
		return type


enum FoodType {vegetable, fruit, nuts, meat, fish, milk, egg}

const TYPE_DATA: Dictionary = {
	FoodType.vegetable: {"Background": Color(0.29803923, 0.52156866, 0.15294118), "Foreground": Color(0.6666667, 0.6666667, 0.60784316), "Name": "vegetable"},
	FoodType.fruit: {"Background": Color(0.9019608, 0.65882355, 0.20392157), "Foreground": Color(0.654902, 0.58431375, 0.50980395), "Name": "fruit"},
	FoodType.nuts: {"Background": Color(0.53333336, 0.33333334, 0.06666667), "Foreground": Color(0.53333336, 0.44313726, 0.37254903), "Name": "nuts"},
	FoodType.meat: {"Background": Color(0.91764706, 0.23529412, 0.12156863), "Foreground": Color(0.72156864, 0.5411765, 0.5294118), "Name": "meat"},
	FoodType.fish: {"Background": Color(0.0627451, 0.5058824, 0.7921569), "Foreground": Color(0.4392157, 0.5058824, 0.5803922), "Name": "fish"},
	FoodType.milk: {"Background": Color(0.8666667, 0.8352941, 0.8352941), "Foreground": Color(0.6666667, 0.6666667, 0.60784316), "Name": "milk"},
	FoodType.egg: {"Background": Color(0.8666667, 0.8352941, 0.8352941), "Foreground": Color(0.6666667, 0.6666667, 0.60784316), "Name": "egg"}
}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func set_data(current_type: FoodType):
	if $Background != null:
		# set background color according to type
		$Background.self_modulate = TYPE_DATA[current_type].Background
		$ContentBackground.self_modulate = TYPE_DATA[current_type].Foreground
		$TypeLabel.text = "Type: " + TYPE_DATA[current_type].Name
	pass


func set_random():
	type = FoodType.values()[randi_range(0, 6)]

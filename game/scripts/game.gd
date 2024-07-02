class_name Game extends Control

var points: int = 0

var player_name: String = "Player1"

func update_data():
	$Spielerdaten/Punkte.text = str(points)
	$Spielerdaten/Name.text = player_name
	$Spielerdaten/Runden.text = str($Judge.judge_number)


func next_round(number: int):
	$NewRoundOverlay.start_overlay(number)
	pass

func game_over():
	get_tree().quit()

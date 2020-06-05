extends Node2D

onready var card1 = $CardOnField
onready var card2 = $CardOnField2
onready var card3 = $CardOnField3
var lastpressed:int = 0
signal pressed

func _on_CardOnField_selected():
	emit_pressed(1)

func _on_CardOnField2_selected():
	emit_pressed(2)

func _on_CardOnField3_selected():
	emit_pressed(3)

func emit_pressed(section:int):
	lastpressed = section
	emit_signal("pressed")

func _on_Main_selected_card(card):
	if lastpressed == 1:
		card1.damage = card["damage"]
		card1.health = card["health"]
		card1.cardname = card["name"]
		card1.cost = card["cost"]
		card1.generate_text()
	elif lastpressed == 2:
		card2.damage = card["damage"]
		card2.health = card["health"]
		card2.cardname = card["name"]
		card2.cost = card["cost"]
		card2.generate_text()
	elif lastpressed == 3:
		card3.damage = card["damage"]
		card3.health = card["health"]
		card3.cardname = card["name"]
		card3.cost = card["cost"]
		card3.generate_text()

